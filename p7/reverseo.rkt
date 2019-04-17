#lang racket


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;	 	 
; Project 7 -- A relational reverse function in miniKanren   
;	 	 
; The goal of this project is to write a relational reverseo function that can be run 
; forwards *or* backwards to produce a reversed list, or that can be used to find many	
; palindrome lists by asking for lists that reverse to themselves!	 	 
;       E.g., (run 7 (lst) (reverseo lst lst))
;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


(provide reverseo)


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



(require "mk.rkt")   


;; Example: an appendo function for relational list append	
;; (You might even try making use of appendo to define reverseo!)   
(define (appendo lst0 lst1 full)	 	 
  (conde ; conde is disjunction: either case in square brackets must be true   
   ; Base case:
   [(== lst0 '())
    ; this case says: lst0 is unified (matched) with '(), 
    ; and full is unified with lst1
    (== full lst1)]	 	 
   ; Recursive case:
   [(fresh (first rest tail)
           ; we introduce three new fresh (initially unconstrained variables)	 	 
           ; this case says: lst0 deomposes into (cons first rest),	 	 
           (== lst0 (cons first rest))	
           ; full decomposes into (const first tail)	 	 
           (== full (cons first tail))	 	 
           ; and rest appended to lst1 matches tail	 	 
           (appendo rest lst1 tail))]))	 	 

   

; Your job is to write a similar (relational) reverseo function 
(define (reverseo lst0 lst1)   
  (conde 
   ; TODO: what cases are involved? What must be true in each case?
   [(== lst0 '())
    (== lst1 '())]
    [(fresh [first rest tail]
      (== lst0 (cons first rest))
      (appendo tail (list first) lst1)
      (reverseo rest tail))]
   ))




