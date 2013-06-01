(load "html.lisp")
(use-package 'html_pkg)

(setf items(list "a" "h1" "h2" "h3" "h4" "p" "strong" "br" "hr"))

(setf cont "Hello, world!")
(setf *random-state* (make-random-state t))
(setf content (list))

(defun gen_cont (len)
(loop for i from 1 to len do 
	(append (list (elt items (random (length items)))) content)
	)
)
(gen_cont 10)
(setf file (format nil "(html ~a )" content))
(print file)