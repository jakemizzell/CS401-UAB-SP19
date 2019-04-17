#lang racket

(require "../interp-CEK.rkt")


(if (equal? (interp-CEK '(and #t (and #t (lambda (q) q))) (hash) 'halt)
            `(closure (lambda (q) q) ,(hash)))
    (exit 0)
    (exit 1))


