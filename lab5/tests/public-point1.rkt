#lang racket

(require "../warm-up.rkt")

(if (point? (cons 3 4))
    (exit 0)
    (exit 1))

