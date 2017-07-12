(add-to-load-path "/home/yenat/Opencog/opencog/build") ;;change the path to your directory
(use-modules (opencog) (opencog moviedb))

(define (run)
(load-scm-from-file "Out.scm")
(load-scm-from-file "movie-query.scm")
(load-scm-from-file "restapi.scm")
)

(run)






 
 
  

