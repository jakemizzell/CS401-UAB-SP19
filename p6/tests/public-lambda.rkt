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
  '((lambda (x) (halt x)) 1))


(define v (racket-cps-eval prog))
(define clo-prog (closure-convert prog))
(define clo-v (racket-proc-eval clo-prog))


(if (and (prog? clo-prog) (equal? v clo-v))
    (exit 0)
    (exit 1))

