#lang racket

(require "../interp-CES.rkt")


(if (equal? (car (interp-CES '((lambda (z) #t) #f) (hash) (hash)))
            '#t)
    (exit 0)
    (exit 1))
