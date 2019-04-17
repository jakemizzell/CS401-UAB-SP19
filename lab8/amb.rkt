#lang racket      
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   
; Lab 8 -- Ambiguous choice operator
; 
; The goal of this lab is to write two functions amb and assert     
; that permits backtracking search through a list of possibilities by     
; using first-class continuations and mutation (e.g. call/cc, set!).
; Consider the notes below and the two test cases provided.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    


(provide amb      
         assert)      

 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Honor pledge (please write your name.)    
;   
; I Jake Mizzell have completed this code myself, without   
; unauthorized assistance, and have followed the academic honor code.     
;   
; Edit the code below to complete your solution.
;     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


(define ccstack '())      
      
      
; (fail) backtracks to the next combination of elements using     
; ccstack to record a stack continuations (each a saved call stack)
; in previous calls to amb, so the next choice can be made instead      
(define (fail)      
  (if (null? ccstack) 
      (error 'no-solution) 
      (let ([next-cc (car ccstack)])  
        ; TODO: decrement the current stack
        (set! ccstack (cdr ccstack))
        (next-cc next-cc)))) 


; (amb lst) ambiguously chooses an element of lst to return 
(define (amb lst)   
  ; TODO: save the current continuation to cc 
  (let ([cc (call/cc (lambda (u) (u u)))])      
    (if (null? lst)     
        (fail) 
        (let ([head (car lst)]) 
          ; TODO: progress lst and add cc to the stack
          (set! lst (cdr lst))
          (set! ccstack (cons cc ccstack))
          head))))      


; (assert t) returns #t if t is not false, otherwise it backtracks      
; using (fail) and tries the next combination of choices 
(define (assert t)
  (if (not t) 
      (fail)      
      #t))    



