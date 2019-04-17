#lang racket

(require "../interp-CE.rkt")


(if (equal? (interp-CE '(lambda (z) z) (hash))
            `(closure (lambda (z) z) ,(hash)))
    (exit 0)
    (exit 1))


