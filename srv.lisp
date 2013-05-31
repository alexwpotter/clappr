(load "deps.lisp")
(use-package 'deps)
(setf page (req-h "index.l"))
(srv 8080 page)