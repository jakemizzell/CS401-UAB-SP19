#lang racket

(require "../interp-CES.rkt")

; ((λ (x) (x x)) (λ (s) (id (s (λ (x) #t)))))
(if (equal? (car (interp-CES '((lambda (id) ((lambda (x) (x x)) (lambda (s) (id (s (lambda (x) #t)))))) (lambda (f) f)) (hash) (hash)))
            #t)
    (exit 0)
    (exit 1))


