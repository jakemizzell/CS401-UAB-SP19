#lang racket

(require "../interp-CEK.rkt")


(if (equal? (interp-CEK `(call/cc (lambda (k) (and (k #t) #f))) (hash) 'halt)
            '#t)
    (exit 0)
    (exit 1))

