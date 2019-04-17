#lang racket

(require "../p3.rkt")


(if (equal? (reduce-lambda '((lambda (x) x) (lambda (y) y)))
            '(lambda (y) y))
    (exit 0)
    (exit 1))

