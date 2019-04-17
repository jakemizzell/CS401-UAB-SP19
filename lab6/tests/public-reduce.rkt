#lang racket

(require "../interp-CE.rkt")


(if (equal? (interp-CE '((lambda (z) z) #t) (hash))
            '#t)
    (exit 0)
    (exit 1))
