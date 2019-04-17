#lang racket


(require "../church-encode.rkt")


;;; Testing helpers
;;;;;;;;;;;;;;;;;;;;;


; Some functions for dealing with church-encoded values in Racket
; These functions unchurch a value, turning it back into a number, list, bool, pair...
(define (church->nat cv) ((cv add1) 0))
(define (church->list cv) ((cv (lambda (car) (lambda (cdr) (cons car (church->list cdr)))))
                           (lambda (na) '())))
(define (church->bool cv) ((cv (lambda (_) #t)) (lambda (_) #f)))
(define (church->pair cv)
  ((cv (lambda (car) (lambda (cdr) (cons car cdr)))) 'unused))


(define (make-unchurch val)
  ;; make-unchurch :: Value -> (ChurchValue -> Value)
  (cond
   [(number? val) church->nat]
   [(boolean? val) church->bool]
   [(list? val)
    (compose1
     (curry
      map
      (lambda (x y)
        ((make-unchurch x) y))
      val)
     church->list)]
   [(pair? val)
    (lambda (pair)
      (match (church->pair pair)
        [(cons x y)
          (cons
           ((make-unchurch (car val)) x)
           ((make-unchurch (cdr val)) y))]))]
   [else (display "Unrecognized value type.\n") (exit 1)]))


;; Returns true (an error list) if the term is not in the output grammar
(define (invalid-term? e)
  (match e
         [`(lambda (,(? symbol?)) ,e0) (invalid-term? e0)]
         [(? symbol?) #f]
         [`(,e0 ,e1) (ormap invalid-term? e)]
         [else `(bad-term ,e)]))


(define base-ns (make-base-namespace))
(define (run-test inp)
  (define church (church-encode inp))
  (when (invalid-term? church)
        (display "Output was not in the output language.\n")
        (exit 1))
  (define cval (eval church base-ns))
  (define rval (eval inp base-ns))
  (define rcval ((make-unchurch rval) cval))
  (if (equal? rval rcval)
      (exit 0)
      (exit 1)))



;;; Test
;;;;;;;;;;;;;;;;;;;

(run-test
 '(let ([x 2])
    (let ([y (cons x (cons x '()))])
      (let ([z (cons x (cons y '()))])
        (cons (cons x y)
              (cons y z))))))


