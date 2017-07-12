(setenv "LTDL_LIBRARY_PATH"
    (if (getenv "LTDL_LIBRARY_PATH")
        (string-append (getenv "LTDL_LIBRARY_PATH")
            ":/usr/local/lib/opencog:/usr/local/lib/opencog/modules")
        "/usr/local/lib/opencog:/usr/local/lib/opencog/modules"))



(define-module (opencog moviedb))

(use-modules (opencog) (opencog atom-types))
; Load various parts....


(load-extension "libmoviedb-types" "moviedb_types_init")

(add-to-load-path "/usr/local/share/opencog/scm")
(use-modules (opencog))  ; needed for cog-type->int

(load-from-path "moviedb/moviedb_types.scm")
