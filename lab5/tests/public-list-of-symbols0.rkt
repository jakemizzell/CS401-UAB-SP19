#lang racket

(require "../warm-up.rkt")

(if (list-of-symbols? '(a b c))
    (exit 0)
    (exit 1))


