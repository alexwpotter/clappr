(load "html.lisp")
(use-package 'html_pkg)

(setf page 

(html
(head 
(link "stylesheet" "text/css" "stylesheet.css")
)
(body '(id "body1")
(h1 "Hello, world!")
(p "This is a test page.")
(a '((href . "http://thenewtonite.com/")) "Link here")
(p (+ 2 5))
))

)
(defun http-send-line (stream line)
  ;;Send a line of text to the HTTP stream terminating it with CR+LF
  (princ line stream)
  (princ (code-char 13) stream)  ;; carriage-return
  (princ (code-char 10) stream)) ;; linefeed

(let ((server (socket:socket-server 8080)))
	(unwind-protect
		(loop (with-open-stream (socket (socket:socket-accept server))
			(multiple-value-bind (local-host local-port) (socket:socket-stream-peer socket))
			(print socket)
				(http-send-line socket page)
				(terpri socket))))
	(socket:socket-server-close server))
