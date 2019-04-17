#lang racket

(require "../interp-CE.rkt")


(if (equal? (interp-CE '(not #t) (hash))
            #f)
    (exit 0)
    (exit 1))


