#lang racket


(require "../cps.rkt")


(define prog
  '(let ([id ((lambda (u) (u u)) (lambda (a) a))])
     (id 99)))

(define ns (make-base-namespace))
(define v (eval prog ns))
(define cps-prog-raw (cps-convert prog))
(define cps-prog `(call/cc (lambda (halt) ,cps-prog-raw)))
(define cps-v (eval cps-prog ns))


(define (cps? exp)
  (define (ce? ce)
    (match ce
           [`(let ([,(? symbol?) (,(? prim?) ,(? ae?) ...)]) ,(? ce?)) #t]
           [`(if ,(? ae?) ,(? ce?) ,(? ce?)) #t]
           [`(,(? ae?) ...) #t]
           [else (ae? ce)]))
  (define (ae? ae)
    (match ae
           [`(lambda (,(? symbol?) ...) ,(? ce?)) #t]
           [(? symbol?) #t]
           [(? number?) #t]
           [else #f]))
  (ce? exp))


(if (and (cps? cps-prog-raw) (equal? v cps-v))
    (exit 0)
    (exit 1))



