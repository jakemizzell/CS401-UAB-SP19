#lang racket

(require "../interp-CEK.rkt")


(if (equal? (interp-CEK '(lambda (w) w) (hash) 'halt)
            `(closure (lambda (w) w) ,(hash)))
    (exit 0)
    (exit 1))


