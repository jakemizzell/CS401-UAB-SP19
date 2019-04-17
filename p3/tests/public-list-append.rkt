#lang racket

(require "../p3.rkt")



(if (equal? (list-append '(2 3 4) '()) '(2 3 4))
    (exit 0)
    (exit 1))


