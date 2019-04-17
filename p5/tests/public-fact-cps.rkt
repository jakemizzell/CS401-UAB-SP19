#lang racket


(require "../cps.rkt")


(define prog
  '(let ((fact
          (let ((a277
                 ((lambda (u) (u u))
                  (lambda (y)
                    (lambda (f)
                      (f
                       (lambda (x)
                         (let ((a275 (y y)))
                           (let ((a276 (a275 f))) (a276 x))))))))))
            (a277
             (lambda (fact)
               (lambda (n)
                 (let ((a278 1))
                   (let ((a279 (<= n a278)))
                     (if a279
                         1
                         (let ((a280 1))
                           (let ((a281 (- n a280)))
                             (let ((a282 (fact a281))) (* n a282)))))))))))))
     (let ((a283 5)) (fact a283))))

(define ns (make-base-namespace))
(define v (eval prog ns))
(define cps-prog-raw (cps-convert prog))
(define cps-prog `(call/cc (lambda (halt) ,cps-prog-raw)))
(define cps-v (eval cps-prog ns))

(define (cps? exp)
  (define (ce? ce)
    (match ce
           [`(let ([,(? symbol?) (,(? prim?) ,(? ae?) ...)]) ,(? ce?)) #t]
           [`(if ,(? ae?) ,(? ce?) ,(? ce?)) #t]
           [`(,(? ae?) ...) #t]
           [else (ae? ce)]))
  (define (ae? ae)
    (match ae
           [`(lambda (,(? symbol?) ...) ,(? ce?)) #t]
           [(? symbol?) #t]
           [(? number?) #t]
           [else #f]))
  (ce? exp))

(if (and (cps? cps-prog-raw) (equal? v cps-v))
    (exit 0)
    (exit 1))




