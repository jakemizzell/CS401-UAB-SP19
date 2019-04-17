#lang racket

(require "../interp-CES.rkt")


(define rv (interp-CES '((lambda (q)
                            (or (set! q #t (or #f #f))
                                (or q
                                    ((lambda (w) (w w))
                                     (lambda (z) (z z))))))
                          #f)
                        (hash)
                        (hash)))

(match rv
       [(cons #t _)
        (exit 0)]
       [else (exit 1)])


