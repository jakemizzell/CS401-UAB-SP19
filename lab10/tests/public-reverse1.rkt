#lang racket


(require "../cps-examples.rkt")

(reverse (lambda (_ lst)
           (if (equal? lst '())
               (exit 0)
               (exit 1)))
         '())

(exit 1)

