#lang racket

(require "../interp-CES.rkt")


(if (equal? (car (interp-CES '#t (hash) (hash)))
            '#t)
    (exit 0)
    (exit 1))

