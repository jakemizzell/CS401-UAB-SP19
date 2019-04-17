#lang racket

(require "../interp-CES.rkt")


(if (equal? (interp-CES '(lambda (w) w) (hash) (hash))
            (cons `(closure (lambda (w) w) ,(hash))
                  (hash)))
    (exit 0)
    (exit 1))


