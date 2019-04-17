#lang racket 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;	 	 
; Lab 5 -- Warm-up with Racket 
; 
; The goal of this lab is to write five simple functions in Racket.	 	 
;	
; Each is described in comments below.   
;	 	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	 	 


(provide least 
         point?   
         list-length
         sum-list   
         list-of-symbols?) 
	

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
	 	 
 
; Define a least function taking two numbers and returning the lesser	 	 
;;; e.g., (least 2 5) => 2	 	 
(define (least x y)	 	 
  (if (< x y) x
    y))


; Define a point? predicate that returns true if and only if its 
; input is a cons cell made of two numbers; you might want to use	 	 
; predicates cons? and number?, along with cons-cell accessors car, cdr	 	 
;;; e.g., (point? (cons 1 2)) => #t 
;;;       (point? 3)   
(define (point? p)
  (if (cons? p)
    (and (number? (car p)) (number? (cdr p)))
    #f )) 



; Define a list-length function that returns an input lists length
;;; e.g., (list-length '(1 2 3 4)) => 4 
(define (list-length lst)	 	 
  (if (null? lst)
      0	 	 
      (+ 1 (list-length (cdr lst)))))  


; Define a sum-list function that takes a list of numbers and computes their sum   
;;; e.g., (sum-list '(1 2 3)) => 6 
(define (sum-list lst)	 	 
  (foldr + 0 lst))	 	 


; Define a xlist-of-symbols? predicate that only returns true for lists of symbols;	 	 
; the predicate for a symbol is symbol?	
;;; e.g., (list-of-symbols? '(a b c d e 7 f)) => #f	 	 
(define (list-of-symbols? lst)	 	 
  (if (null? lst)	
      #t 
      (and (cons? lst) 
           (symbol? (car lst)) 
           (list-of-symbols? (cdr lst)))))


