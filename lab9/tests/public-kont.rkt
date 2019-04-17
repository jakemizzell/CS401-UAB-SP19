#lang racket

(require "../interp-CEK.rkt")


(if (equal? (interp-CEK `(call/cc (lambda (k0)
                                    ((call/cc (lambda (k1) (k0 k1))) #f)))
                        (hash)
                        'halt)
            `(kont (ar #f ,(hash 'k0 '(kont halt)) halt))) 
    (exit 0)
    (exit 1))


