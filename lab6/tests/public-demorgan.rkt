#lang racket

(require "../interp-CE.rkt")


(let* ([a (lambda (p q) `(not (and ,p ,q)))]
	   [b (lambda (p q) `(or (not ,p) (not ,q)))]
	   [e (lambda (t1 t2) (equal? (interp-CE (a t1 t2) (hash))
	   							  (interp-CE (b t1 t2) (hash))))])
	(if (and (e #f #f)
	  	 	 (e #f #t)
	  	  	 (e #t #f)
	  	 	 (e #t #t))
		(exit 0)
		(exit 1)))
