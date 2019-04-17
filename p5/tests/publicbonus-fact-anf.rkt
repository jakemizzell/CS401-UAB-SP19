#lang racket


(require "../cps.rkt")


(define Yc `((lambda (u) (u u))
             (lambda (y)
               (lambda (f)
                 (f (lambda (x) (((y y) f) x)))))))

(define prog
  `(let ([fact (,Yc (lambda (fact)
                      (lambda (n)
                        (if (<= n 1)
                            1
                            (* n (fact (- n 1)))))))])
     (fact 5)))

(define ns (make-base-namespace))
(define v (eval prog ns))

(define anf-prog (anf-convert prog))
(define anf-v (eval anf-prog ns))

(pretty-print anf-prog)

(if (equal? v anf-v)
    (exit 0)
    (exit 1))


