#lang racket


(require "../mk.rkt")
(require "../reverseo.rkt")

(define result
  (run 1 (lst) (reverseo '(1 2) lst)))

(if (equal? result '((2 1)))
    (void)
    (exit 1))




