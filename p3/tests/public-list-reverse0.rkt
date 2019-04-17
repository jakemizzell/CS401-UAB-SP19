#lang racket

(require "../p3.rkt")



(if (equal? (list-reverse '(2 3 4)) '(4 3 2))
    (exit 0)
    (exit 1))


