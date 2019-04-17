#lang racket	 	 
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   
; Lab 6 -- A control and environment (CE) interpreter
; 
; The goal of this lab is to write a directly recursive interpreter   
; for a simple language (including lambda calculus and some boolean expressions)   
; where the program state is modeled by a control expression and an environment   
; mapping variables in scope to their values. Details below. 
;   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   


(provide interp-CE)	 	 
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	 	 
;   
; Honor pledge (please write your name.)   
;
; I jacob Mizzell have completed this code myself, without
; unauthorized assistance, and have followed the academic honor code.
;   
; Edit the code below to complete your solution.	 	 
;	 	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 



; Define interp-CE, a direct recursive (big-step) interpreter for the language:
;;;  e ::= (lambda (x) e)
;;;      | (e e)
;;;      | x	 	 
;;;      | (if b e e) 
;;;      | (and e e)	 	 
;;;      | (or e e)	 	 
;;;      | (not e)   
;;;      | b
;;;  x ::= < any variable satisfying symbol? >   
;;;  b ::= #t | #f 

; (A subset of Scheme/Racket that should be interpreted as Scheme/Racket.) 
; You can use (error ...) to handle errors, but will only be tested on 
; on correct inputs. And/Or must properly short-circuit as in Scheme.   
; Boolean-returning programs should yield a boolean. Closure-returning   
; programs should yield a representation of an explicit closure:   
; `(closure (lambda (,x) ,body) ,env) that pairs a syntactic lambda with an
; environment encoded as an immutable hash. You may want to use (hash),
; (hash-ref ...), (hash-set ...), (hash-has-key? ...), etc.	 	 

; For example:
;;; (interp-CE `((lambda (x) x) (lambda (y) y)) (hash))   
; should yield a value equal? to: 
;;; `(closure (lambda (y) y) ,(hash)) 

(define (interp-CE cexp env)
  (match cexp	 	 

         ;; TODO: further cases go here? 

         [(? symbol? x)
         	(hash-ref env x)]

         [(? boolean? x) x]


         [`(if ,ec ,et ,ef)    
         	(if (interp-CE ec env)
                (interp-CE et env)
                (interp-CE ef env))]

         [`(and ,e0 ,e1)
         	(and (interp-CE e0 env)
         		 (interp-CE e1 env))]

         [`(or ,e0 ,e1)
         	(or (interp-CE e0 env)
         		(interp-CE e1 env))]

         [`(not ,e) 
         	(not (interp-CE e env))]

         [`(lambda (,x) ,body)	 	 
          ; A closure-creating interpreter evaluates a lambda-abstraction
          ; to a closure pairing the function with the current environment 
          `(closure ,cexp ,env)]	

         ;; TODO: further cases go here ?
         [`(,e0 ,e1)
         	(define v0 (interp-CE e0 env))
         	(define v1 (interp-CE e1 env))
         	(match v0
         		[`(closure (lambda (,x) ,e2) ,env)
         			(interp-CE e2 (hash-set env x v1))])]	 	 

         [else (error (format "Exp not recognized: ~a" cexp))]))



   
