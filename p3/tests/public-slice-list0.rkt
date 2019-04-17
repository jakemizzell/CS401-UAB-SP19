#lang racket

(require "../p3.rkt")

(if (equal? (slice-list '(0 1 2 3 4 5 6 7 8 9) 0 3) '(0 1 2 3))
    (exit 0)
    (exit 1))


