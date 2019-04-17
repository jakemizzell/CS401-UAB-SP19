#lang racket

(require "../interp-CE.rkt")


(if (equal? (interp-CE '(and #f ((lambda (w) (w w)) (lambda (z) (z z)))) (hash))
            #f)
    (exit 0)
    (exit 1))


