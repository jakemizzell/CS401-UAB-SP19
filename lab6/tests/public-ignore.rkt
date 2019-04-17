#lang racket

(require "../interp-CE.rkt")


(if (equal? (interp-CE '((lambda (z) #t) #f) (hash))
            '#t)
    (exit 0)
    (exit 1))
