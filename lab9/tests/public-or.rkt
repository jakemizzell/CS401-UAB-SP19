#lang racket

(require "../interp-CEK.rkt")


(if (equal? (interp-CEK '((lambda (c) (if c (c #f) (lambda (d) c))) (or #f (call/cc (lambda (b) (b b))))) (hash) 'halt)
            `(closure (lambda (d) c) ,(hash 'c #f)))
    (exit 0)
    (exit 1))


