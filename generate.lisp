(load "html.lisp")
(use-package 'html_pkg)

(setf items(list "a" "body" "h1" "h2" "h3" "h4" "head" "html" "p" "strong" "title" "br" "hr"))

(setf cont "Hello, world!")

(defparameter content " ")

(defun gen_cont (len)
(loop for i from 1 to len do 
	(print (elt items (random (length items)) ))
	)
)
(gen_cont 10)
;;(setf file (format nil "(html ~a )" (concatenate 'string content)))
;;(print file)