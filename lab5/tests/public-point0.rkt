#lang racket

(require "../warm-up.rkt")

(if (point? (cons 1 #f))
    (exit 1)
    (exit 0))

