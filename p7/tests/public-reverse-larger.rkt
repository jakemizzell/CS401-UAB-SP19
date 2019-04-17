#lang racket


(require "../mk.rkt")
(require "../reverseo.rkt")

(define result
  (run 1 (lst) (reverseo lst '(1 2 3 4 5 6 7 8 9))))

(if (equal? result '((9 8 7 6 5 4 3 2 1)))
    (void)
    (exit 1))


