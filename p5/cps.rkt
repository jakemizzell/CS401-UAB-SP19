#lang racket	 	 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
; 
; Project 5 -- ANF + CPS conversion passes -- implementing continuations 
; 
; The goal of this project is to write two functional compiler passes: 
; ANF conversion (501 only) and CPS conversion. Each is described below in terms of	 	 
; input/output languages (subsets of Racket). ANF conversion makes the only   
; form that extends the current continuation the let form: this means all 
; intermediate expressions must be explicitly let-bound to a temporary variable	 	 
; (use gensym to generate fresh variable names), giving it an administrative binding.   
; CPS conversion implements continuations as functions, passing them forward at each 
; function call (just as the CEK interpreter does) and implements call/cc.	
;   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


(provide prim?	
         anf-convert 
         cps-convert)   


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


;;; Input language for anf-convert: 
; e ::= (lambda (x ...) e)
;     | (e e ...)
;     | x	 	 
;     | (prim-op e ...) 
;     | (if e e e) 
;     | (let ([x e]) e)	
;     | (call/cc e)
;     | n	 	 
; x is a symbol?	 	 
; n is a number?   
; prim-op is a prim?	 	 

(define (prim? op)	 	 
  (if (member op '(< = <= + - *)) 
      #t
      #f))	 	 
	 	 

; Administrative-normal-form (ANF) conversion pass (501 only, or extra credit)   
(define (anf-convert e)	 	 
  ; normalize-ae uses normalize to turn an e into an ae   
  (define (normalize-ae e k)   
    (normalize e (lambda (anf)
                   ; Check if anf is an ae, if so, done	 	 
                   ; if not, add a let-binding for it
                   (match anf 
                          ; TODO: missing cases? 
                          [`(lambda ,xs ,e0)	 	 
                           (k `(lambda ,xs ,e0))]	 	 
                          [else 
                           (define ax (gensym 'a))
                           `(let ([,ax ,anf])   
                              ,(k ax))]))))	 	 
  ; Normalize takes an expression to convert to ANF and a transformer k	 	 
  ; (basically a composable continuation) that wraps the transformed e in any   
  ; needed context once e is converted 
  (define (normalize e k)   
    (match e 
           [(? symbol? x)	 	 
            (k x)] 
           ; TODO: missing forms	 	 
           [`(lambda (,xs ...) ,e0)   
            (k `(lambda ,xs ,(anf-convert e0)))]
           [`(if ,e0 ,e1 ,e2)   
            (normalize-ae e0 (lambda (ae)	 	 
                               (k `(if ,ae ,(anf-convert e1) ,(anf-convert e2)))))]	 	 
           [`(,es ...)
            'TODO]))
  (normalize e (lambda (x) x)))    
 

;;; Output language for anf-convert / input for cps-convert	 	 
; ce ::= (let ([x ce]) ce)	 	 
;     |  (ae ae ...) 
;     |  (prim-op ae ...) 
;     |  (if ae ce ce)   
;     |  (call/cc ae)
;     |  ae 
; ae ::= x
;     |  n 
;     |  (lambda (x ...) ce)
; x is a symbol?	
; n is a number? 
; prim-op is a prim?	 	 


; Continuation-passing style (CPS) conversion pass   
(define (cps-convert e)	
  (define (T-ae ae) 
    (match ae   
           [`(lambda (,xs ...) ,e0)	 	 
            (define k (gensym 'k))	 	 
            ; add a new first parameter k (for the current continuation)   
            ; to this lambda so it may be passed its continuation	 	 
            `(lambda (,k ,@xs) 
              ,(T-e e0 k))]
	 	 
           ; Other atomic expressions require no changes	 	 
           [else ae]))
  
  (define (T-e e cae) 
    (match e	 	 
           [(? symbol? x)
            `(,cae 0 ,x)]

           ; TODO: missing forms
           [(? number? n)
            `(,cae 0 ,n)]

           [`(lambda . ,rest)
            `(,cae 0 ,(T-ae e))]

           [`(,(? prim? op) ,aes ...)
            (define t (gensym 't))
            `(let ([,t (,op ,@(map T-ae aes))]) (,cae 0 ,t))]	
      
           ; TODO: missing forms

           [`(let ([,x ,RHS]) ,BODY)
            (T-e RHS `(lambda (_ ,x) ,(T-e BODY cae)))]
      
           [`(if ,ae ,ce0 ,ce1)
            `(if ,(T-ae ae) ,(T-e ce0 cae) ,(T-e ce1 cae))]

           [`(call/cc ,ae)
            `(,(T-ae ae) ,cae ,cae)]

           [`(,aef ,aes ...)
            `(,(T-ae aef) ,cae ,@(map T-ae aes))]
           )
    )

  ; We transform the program e, using an initial continuation that calls halt	 	 
  ; Here we assume the first parameter to functions is the current continuation.	 	 
  ; If it's the last, then use (x _) as the parameter list. We use a _ because
  ; a continuation does not need to be passed a continuation---so its thrown away.   
  (T-e e '(lambda (_ x) (halt x))))   

	
;;; Output language for cps-convert   
; ce ::= (let ([x (prim-op ae ...)]) ce)	 	 
;     |  (ae ae ...) 
;     |  (if ae ce ce) 
; ae ::= x | n | (lambda (x ...) ce) 
; x is a symbol?  (possibly 'halt) 
; n is a number?
; prim-op is a prim? 



