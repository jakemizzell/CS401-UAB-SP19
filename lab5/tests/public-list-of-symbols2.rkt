#lang racket

(require "../warm-up.rkt")

(if (list-of-symbols? '(a 7 c))
    (exit 1)
    (exit 0))


