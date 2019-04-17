#lang racket


(require "../amb.rkt")


(let ([a (amb '(1 2 3 4 5 6 7))]
      [b (amb '(5 15 25 35 45))])

  ; Check a and b, if a^2 != b, backtrack
  (assert (= (* a a) b))

  (if (equal? `(,a ,b)
              `(5 25))
      (exit 0)
      (exit 1)))


