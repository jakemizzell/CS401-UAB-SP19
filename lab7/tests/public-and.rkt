#lang racket

(require "../interp-CES.rkt")


(define rv (interp-CES '((lambda (q)
                            (and (set! q #f (and #t #t))
                                 (and q
                                      ((lambda (w) (w w))
                                       (lambda (z) (z z))))))
                          #t)
                        (hash)
                        (hash)))

(match rv
       [(cons #f _)
        (exit 0)]
       [else (exit 1)])



