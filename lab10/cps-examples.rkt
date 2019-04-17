#lang racket	 	 

	 	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   
; Lab 10 -- Two simple examples in CPS   
;	 	 
; The goal of this lab is to practice our understanding of CPS on two simple   
; functions, append and reverse. Write a version of each in CPS where every 
; function and continuation takes a new zeroth parameter to be passed the current continuation. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(provide append reverse)	 	 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
;	
; Honor pledge (please write your name.)
; 
; I Jake Mizzell have completed this code myself, without   
; unauthorized assistance, and have followed the academic honor code.	 	 
;   
; Edit the code below to complete your solution. 
;	 	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


; CPS convert two more examples manually as practice: append & reverse   

; e.g.  (append (lambda (_ lst) (print lst)) '(1) '(2))	 	 
 
(define (append k lst0 lst1) 
  (let ([nullb (null? lst0)])
    (if nullb
        (k k lst1)
        (let ([car-lst0 (car lst0)])
          (let ([cdr-lst0 (cdr lst0)])
            (append (lambda (_ tail)
                    (let ([rv (cons car-lst0 tail)])
                  (k k rv)))
            cdr-lst0
             lst1))))))

; What makes reverse simpler to CPS convert in some sense?

(define (reverse k lst) 
  (define (trev k1 lst0 lst1)	 	 
    (if (null? lst0)
        (k1 k1 lst1)
        (trev k1 (cdr lst0) (cons (car lst0) lst1))))
  (trev k lst '()))


   


