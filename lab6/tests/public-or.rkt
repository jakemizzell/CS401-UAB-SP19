#lang racket

(require "../interp-CE.rkt")


(if (equal? (interp-CE '(or #t (bad syntax)) (hash))
            #t)
    (exit 0)
    (exit 1))


