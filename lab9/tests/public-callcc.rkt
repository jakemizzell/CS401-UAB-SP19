#lang racket

(require "../interp-CEK.rkt")


(if (equal? (interp-CEK '((lambda (f) (and f (f #f))) (call/cc (lambda (k) (k k)))) (hash) 'halt)
            #f)
    (exit 0)
    (exit 1))


