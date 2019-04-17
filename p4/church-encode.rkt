#lang racket	 	 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
; 
; Project 4 -- A church compiler -- Scheme -> Lambda	
;
; The goal of this project is to write a functional compiler that transforms   
; code in an input language (a significant subset of Scheme, roughly) into 
; equivalent code in the lambda calculus. Details below.
;	 	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	 	 


(provide church-encode)



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


;; Your task is to compile the input language:   
;	 	 
; e ::= (letrec ([x (lambda (x ...) e)]) e)   
;     | (let ([x e] ...) e)	 	 
;     | (lambda (x ...) e)	 	 
;     | (e e ...)	 	 
;     | x   
;     | (and e e) | (or e e)
;     | (if e e e)	 	 
;     | (prim e) | (prim e e)   
;     | datum
; datum ::= nat | (quote ()) | #t | #f	
; nat ::= < satisfies natural? >	 	 
; x ::= < satisfies symbol? > 
; prim ::= < is a primitive operation in: > 
(define prims '(+ * - = add1 sub1 cons car cdr null? not zero?)) 

;; To the lambda calculus, output language:   
;	 	 
; e ::= (lambda (x) e) 
;     | (e e)   
;     | x	 	 
;   

;; Only 501 students are required to support '=, '-, and 'sub1	 	 

;; The input language should behave as it does evaluated by Racket,	 	 
;; however, you do not need to handle non-booleans being treated as #t 
;; at guard expressions, or at and/or expressions.	 	 

;; The grammar above does not include variadic lambdas or apply.   
 
;; No test will produce a negative number, input '(- 1 3) is undefined.

;; Implementing your church encodings and these primitive operations, 
;; you are free to look up standard church encodings online   
;; (e.g., on wikipedia), as long as you understand them, but are not	 	 
;; allowed to use an existing church-encoder or to get help in writing   
;; your church compiler itself. 


(define (prim? prim)    
  (if (member prim prims) #t #f))    


; Note how churchify is called from church-encode below. 
; To make output less verbose, intead of inserting a church encoding,   
; e.g., for 'car, at each occurance of a constant or prim-op, 
; it's recommended you bind them to a variable prefixed with 'church:,    
; e.g., 'church:car, and then use this function to generate that name   
; from the name of the primitive operation. 
; (churchify-prim 'car) => 'church:car
(define (churchify-prim prim)
  (string->symbol (string-append "church:" (symbol->string prim))))

; This is your main compiler transformation rewriting exp -> exp
(define (churchify e)
  (match e   
         ; Tagged expressions	 	 
         [`(let ([,xs ,e0s] ...) ,e1)   
          ; A common idiom will be to make a tail call.   
          ; In this case, if xs is '(a b), the recursive call 
          ; to churchify should perform the needed currying.   
          ; Watch out for forming infinite loops!
          (churchify `((lambda ,xs ,e1) . ,e0s))]

         [`(letrec [(,f ,lam)] ,body)
          (churchify `(let ((,f (Y-comb (lambda (,f) ,lam)))) ,body))]

         [`(lambda () ,e0) 
          `(lambda (_) ,(churchify e0))]

         [`(lambda (,x) ,e0)
          `(lambda (,x) ,(churchify e0))]

         [`(lambda (,x . ,rest) ,e0)
          `(lambda (,x) ,(churchify `(lambda ,rest ,e0)))]   

         ;; TODO: are there more match cases to add?	 	 

         [(? prim? p) (churchify-prim p)] 

         ; Variables 
         [(? symbol? x) x]       

         ; Datums   
         [(? natural? nat)
            (define (iter n)
              (if (= n 0) 'x
                `(f ,(iter (- n 1)))))
            `(lambda (f) (lambda (x) ,(iter nat)))]

         [''()	 	 
          `(lambda (when-cons) (lambda (when-null) (when-null when-null)))]

         [#t
          `(lambda (tt) (lambda (ft) (tt tt)))]

         [#f 
          `(lambda (tt) (lambda (ft) (ft ft)))]

         [`(if ,cond ,then ,else)
          (churchify `(,cond (lambda () ,then) (lambda () ,else)))]

         [`(and ,e0 ,e1)
          (churchify `(if ,e0 ,e1 #f))]

         [`(or ,e0 ,e1)
          (churchify `(if ,e0 #t ,e1))] 

         ; Untagged application (has to go last)   
         [`(,fun)   
          `(,(churchify fun) (lambda (x) x))]

         [`(,fun ,arg)   
          `(,(churchify fun) ,(churchify arg))]	

         [`(,fun ,arg . ,rest)
          (churchify `((,fun ,arg) ,@rest))]
  )
) 

;; This is the top-level church encoder	 	 
;; You might find it convenient to define your church:prim functions here,	 	 
;; as illustrated, but this also means testing at the REPL will be easier
;; by calling churchify directly and seeing that its output looks correct.   

(define (church-encode expr)	
  (define Y-comb '((lambda (u) (u u)) (lambda (y) (lambda (mk) (mk (lambda (x) (((y y) mk) x)))))))  
  
  (define church:null? '(lambda (p) (p (lambda (a b) #f) (lambda (_) #t))))

  (define church:cons '(lambda (a b) (lambda (when-cons when-null) (when-cons a b))))
   
  (define church:car '(lambda (p) ((p (lambda (a) (lambda (b) a))) (lambda (_) (lambda (x) x)))))   

  (define church:cdr '(lambda (p) ((p (lambda (a) (lambda (b) b))) (lambda (_) (lambda (x) x)))))

  ; Because these are all passed through churchify, we do not need to curry
  (define church:add1 '(lambda (n0) (lambda (f) (lambda (x) (f ((n0 f) x))))))   

  (define church:sub1 '(lambda (n0) (lambda (f)
                        (lambda (z) (((n0 (lambda (g) (lambda (h) (h (g f))))) (lambda (u) z)) (lambda (x) x))))))	 	 
  
  (define church:zero? '(lambda (n) ((n (lambda (b) #f)) #t)))	 	 
  
  (define church:+ '(lambda (n0) (lambda (n1) (lambda (f) (lambda (x) ((n1 f) ((n0 f) x)))))))	 	 

  (define church:- '(lambda (n0) (lambda (n1) ((n1 (lambda (n0) (lambda (f)
                      (lambda (z) (((n0 (lambda (g) (lambda (h) (h (g f))))) (lambda (u) z)) (lambda (x) x)))))) n0))))	 	 
  
  (define church:* '(lambda (n0) (lambda (n1) (lambda (f) (lambda (x) ((n0 (n1 f)) x))))))

  ;this is like (and (zero? (- n0 n1) (zero? (- n1 n0)))
  ;can't figure out how to use the functions above as the text
  (define church:= '(lambda (n0) (lambda (n1) ((
                      ((lambda (n) ((n (lambda (b) #f)) #t))
                        (((lambda (n0) (lambda (n1) ((n1 (lambda (n0) (lambda (f) (lambda (z) (((n0 (lambda (g) (lambda (h) (h (g f))))) (lambda (u) z)) (lambda (x) x)))))) n0))) n0) n1))
                      (lambda (_) ((((lambda (n) ((n (lambda (b) #f)) #t)) 
                        (((lambda (n0) (lambda (n1) ((n1 (lambda (n0) (lambda (f) (lambda (z) (((n0 (lambda (g) (lambda (h) (h (g f))))) (lambda (u) z)) (lambda (x) x)))))) n0))) n1) n0)) 
                    (lambda (_) #t)) (lambda (_) #f)))) (lambda (_) #f)))))    	 	 
  
  (define church:not '(lambda (b) ((b (lambda (_) #f)) (lambda (_) #t))))


  (churchify   
   `(let ([Y-comb ,Y-comb]
          [church:null? ,church:null?] 
          [church:cons ,church:cons]
          [church:car ,church:car]   
          [church:cdr ,church:cdr]	 	 
          [church:add1 ,church:add1]	 	 
          [church:sub1 ,church:sub1] 
          [church:+ ,church:+]	 	 
          [church:- ,church:-]
          [church:* ,church:*]	
          [church:zero? ,church:zero?]   
          [church:= ,church:=]	 	 
          [church:not ,church:not]
    ) 
      ,expr)))	