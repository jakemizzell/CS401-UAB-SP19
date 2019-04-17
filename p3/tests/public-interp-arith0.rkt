#lang racket

(require "../p3.rkt")


(if (= (interp-arith '(+ 1 (+ 2 (+ 3 (* 2 (- 3 1))))))
       10)
    (exit 0)
    (exit 1))


