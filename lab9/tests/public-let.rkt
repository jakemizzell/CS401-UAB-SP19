#lang racket

(require "../interp-CEK.rkt")


(if (equal? (interp-CEK '(let ([a #t])
                           (let ([b (let ([c #f]) (or #t c))])
                             (and a b))) (hash) 'halt)
            #t)
    (exit 0)
    (exit 1))


