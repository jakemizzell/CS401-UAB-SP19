#lang racket

(require "../interp-CE.rkt")

; ((λ (x) (x x)) (λ (s) (id (s (λ (x) #t)))))
(if (equal? (interp-CE '((lambda (id) ((lambda (x) (x x)) (lambda (s) (id (s (lambda (x) #t)))))) (lambda (f) f)) (hash))
            #t)
    (exit 0)
    (exit 1))


