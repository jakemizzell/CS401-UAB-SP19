#lang racket

(require racket/exn)
(require "../contracts.rkt")


(with-handlers ([exn:fail?
                 (lambda (r)
                   (if (string-contains? (exn->string r) "append: contract violation")
                       (void)
                       (exit 1)))])
               (append 5 '())
               (exit 2))


(with-handlers ([exn:fail?
                 (lambda (r)
                   (if (string-contains? (exn->string r) "append: contract violation")
                       (void)
                       (exit 1)))])
               (append '() 5)
               (exit 2))


