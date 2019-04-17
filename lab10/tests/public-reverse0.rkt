#lang racket


(require "../cps-examples.rkt")

(reverse (lambda (_ lst)
           (if (equal? lst '(4 3 2 1))
               (exit 0)
               (exit 1)))
         '(1 2 3 4))

(exit 1)

