#lang racket


(require "../cps-examples.rkt")

(append (lambda (_ lst)
          (if (equal? lst '(1 2 3 4 5))
              (exit 0)
              (exit 1)))
        '(1 2)
        '(3 4 5))

(exit 1)

