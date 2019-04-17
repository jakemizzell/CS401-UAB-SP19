#lang racket


(require "../amb.rkt")


(let ([a (amb '(1 2 3 4 5 6))]
      [b (amb '(1 2 3 4 5 6))]
      [c (amb '(1 2 3 4 5 6))])
  
  ;(pretty-print `(trying ,a ,b ,c))
  (assert (= (+ (* a a) (* b b)) (* c c)))

  (if (equal? `(,a ,b ,c)
              `(3 4 5))
      (exit 0)
      (exit 1)))


