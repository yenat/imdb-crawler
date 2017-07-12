(use-modules (opencog) (opencog query))
(use-modules (ice-9 threads))
(use-modules (ice-9 rdelim))
(use-modules (ice-9 popen))
(use-modules (ice-9 rw))
(use-modules (rnrs io ports))

(define new-as (cog-new-atomspace))
(define path "Visualize.scm")  
(define x 1)
(define data "")
(define type "w")
 
(define (find-movie)
 (make-thread       

(while (<= x 350)

(set! data (cog-incoming-set (Concept  (string-append "Movie " (number->string x)))) )

(let ((port (open-file path type)))
			(prt-atom-list port data)
			
		(close-port port)
	)

(if (= (remainder x 5) 0) (begin (sleep 15) (delete-file path)(set! type "a") )) 
(set! x (+ x 1))
)
)
)

(define (loading)
(make-thread 
(while #t
(cog-set-atomspace! new-as) (load "Visualize.scm")
(sleep 15)
(clear)
))
)
(parallel (find-movie) (loading))

