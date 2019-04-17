#lang racket

(require racket/exn)
(require "../contracts.rkt")


(with-handlers ([exn:fail?
                 (lambda (r)
                   (if (string-contains? (exn->string r) "fib: contract violation")
                       (void)
                       (exit 1)))])
               (fib #f)
               (exit 2))


(with-handlers ([exn:fail?
                 (lambda (r)
                   (if (string-contains? (exn->string r) "fib: contract violation")
                       (void)
                       (exit 1)))])
               (fib -1)
               (exit 2))




