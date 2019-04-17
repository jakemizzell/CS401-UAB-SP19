#lang racket


(require "../clo.rkt")


; Interpreter for output language:
(define ns (make-base-namespace))
(define (racket-cps-eval expr)
  (with-handlers ([exn:fail? (lambda (x) x)])
                 (parameterize ([current-namespace ns])
                               (namespace-require 'rnrs)
                               (namespace-require 'racket)
                               (namespace-require 'srfi/34)
                               (eval (compile
                                      `(call/cc (lambda (halt)
                                                  ,expr)))))))
(define (racket-proc-eval procs)
  (with-handlers ([exn:fail? (lambda (x) x)])
                 (parameterize ([current-namespace ns])
                               (namespace-require 'rnrs)
                               (namespace-require 'racket)
                               (namespace-require 'srfi/34)
                               (eval (compile
                                      `(call/cc (lambda (hlt)
                                                  (define halt (vector (lambda (_ v) (hlt v))))
                                                  (define (clo-app f . vs) (apply (vector-ref f 0) (cons f vs)))
                                                  ,@(map (match-lambda [`(proc (,xs ...) ,bdy) `(define ,xs ,bdy)]) procs)
                                                  (main))))))))

; Predicate for output grammar
(define (prog? p)
  (define (proc? p)
    (match p
           [`(proc ,(? (listof symbol?)) ,bdy) (ce? bdy)]
           [else #f]))
  (define (ce? ce)
    (match ce
           [`(let ([,(? symbol?) (,(? prim?) ,(? ae?) ...)]) ,(? ce?)) #t]
           [`(if ,(? ae?) ,(? ce?) ,(? ce?)) #t]
           [`(,(? ae?) ...) #t]
           [else (ae? ce)]))
  (define (ae? ae)
    (match ae
           [`(,(? prim?) ,(? ae?) ...) #t]
           [(? symbol?) #t]
           [(? number?) #t]
           [else #f]))
  ((listof proc?) p))



(define prog
  '((lambda (k357 u) (u k357 u))
  (lambda (a277)
    (a277
     (lambda (fact) ((lambda (a283) (fact halt a283)) 5))
     (lambda (k352 fact)
       (k352
        (lambda (k353 n)
          ((lambda (a278)
             (let ((t356 (<= n a278)))
               ((lambda (a279)
                  (if a279
                    (k353 1)
                    ((lambda (a280)
                       (let ((t355 (- n a280)))
                         ((lambda (a281)
                            (fact
                             (lambda (a282)
                               (let ((t354 (* n a282))) (k353 t354)))
                             a281))
                          t355)))
                     1)))
                t356)))
           1))))))
  (lambda (k358 y)
    (k358
     (lambda (k359 f)
       (f
        k359
        (lambda (k360 x)
          (y (lambda (a275) (a275 (lambda (a276) (a276 k360 x)) f)) y))))))))


(define v (racket-cps-eval prog))
(define clo-prog (closure-convert prog))
(define clo-v (racket-proc-eval clo-prog))


(if (and (prog? clo-prog) (equal? v clo-v))
    (exit 0)
    (exit 1))

