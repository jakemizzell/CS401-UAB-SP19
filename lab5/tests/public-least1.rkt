#lang racket

(require "../warm-up.rkt")

(if (= (least 5 3) 3)
    (exit 0)
    (exit 1))
