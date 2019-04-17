#lang racket 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;
; Lab 7 -- A control, environment, store (CES) interpreter 
; 
; The goal of this lab is to extend your interpreter from Lab 6 to include	
; mutation, a set! form in the target language that can mutate variables,	
; *without* using any mutation in the host language! Details below. 
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   


(provide interp-CES)	 	 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	
; Honor pledge (please write your name.)   
;
; I Jacob Mizzell have completed this code myself, without 
; unauthorized assistance, and have followed the academic honor code.   
;   
; Edit the code below to complete your solution.
; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	



; Define interp-CES, a direct recursive (big-step) interpreter for the language:	 	 
;;;  e ::= (lambda (x) e)	 	 
;;;      | (e e) 
;;;      | x 
;;;      | (set! x e e)     ;; <-- only this form is new compared with Lab 6 
;;;      | (if e e e)
;;;      | (and e e)   
;;;      | (or e e) 
;;;      | (not e)   
;;;      | b   
;;;  x ::= < any variable satisfying symbol? > 
;;;  b ::= #t | #f   

; You can use (error ...) to handle errors, but will only be tested against	 	 
; correct inputs. The language should work as described in Lab 6, except   
; with an added (set! x e0 e1) form intended to work as (begin (set! x e0) e1)
; does in Racket. Instead of using an environment that maps variables to values
; as in Lab 6, use an environment that maps variables to fresh, unique addresses.	 	 
; Then, add an explicit store (a model of the heap, just as in our IMP semantics)
; mapping each address to its current value. Crucially, while the environment   
; is reset at each return, the store must not be---the store must always reflect	 	 
; the latest values at each address, so a current (potentially updated) store must
; be returned from each call to interp-CES, carrying any new updates made by set!.

; For example: 
;;; (interp-CES `((lambda (x) (set! x #t x)) #f) (hash) (hash))   
; should yield a value equal? to: 
;;; (cons #t (hash 0 #t))
; representing the value #t in the context of a store mapping address 0 to #t


; TODO: Below is a CE interpreter you should modify to produce a CES interpreter	
; start by adding third parameter, store, and then modify each case to support it. 
; Alternatively, you might start by using your interp-CE from Lab 6 and modify that.	 	 
(define (interp-CES cexp env store)   
  (match cexp 
         [`(not ,e0)
          (match-define (cons out store0) (interp-CES e0 env store))
          (if out 
              (cons #f store0)
              (cons #t store0))] 

         [(? boolean? b) (cons b store)]   

         [`(set! ,x ,e0 ,body)
          (match-define (cons out store0) (interp-CES e0 env store))
          (define addr (hash-ref env x))
          (define store1 (hash-set store0 addr out))
          (interp-CES body env store1)] 

         [`(lambda (,x) ,body)   
          (cons `(closure ,cexp ,env)   
                store)]	 	 

         [`(,fun ,arg) 
          (match-define (cons fv store0) (interp-CES fun env store))
          (match-define (cons av store1) (interp-CES arg env store0))
          (define addr (hash-count store1))
          (match fv   
                 [`(closure (lambda (,fx) ,fbody) ,fenv)
                  (interp-CES fbody 
                    (hash-set fenv fx addr) 
                    (hash-set store1 addr av))])] 

         [(? symbol? x) 
         (define addr (hash-ref env x))
          (cons (hash-ref store addr	 	 
            (lambda () (error (format "Unbound variable: ~a" x)))) store)]

         [`(if ,guard ,then ,else) 
          (match-define (cons out store0) (interp-CES guard env store))
          (if out 
              (interp-CES then env store0)	 	 
              (interp-CES else env store0))] 

         [`(and ,e0 ,e1)
          (match-define (cons out store0) (interp-CES e0 env store))
          (if out	 	 
              (interp-CES e1 env store0)	 	 
              (cons #f store0))]	 	 

         [`(or ,e0 ,e1)
          (match-define (cons out store0) (interp-CES e0 env store))
          (if out	 	 
              (cons #t store0)	 	 
              (interp-CES e1 env store0))] 

         [else (error (format "Exp not recognized: ~a" cexp))])) 