(defpackage "DEPS"
	(:use "COMMON-LISP"))
(load "html.lisp")
(use-package 'html_pkg)

(defun req-h (file)
	(let ((f (open file)))
		(eval f)
	)
)


(defun http-send-line (stream line)
  ;;Send a line of text to the HTTP stream terminating it with CR+LF
  (princ line stream)
  (princ (code-char 13) stream)  ;; carriage-return
  (princ (code-char 10) stream)) ;; linefeed
  
(defun req-a (script)
	(let ((fi (open script)))
		(read fi)
	)
)

(defun srv (port page)
(let ((server (socket:socket-server port)))
	(unwind-protect
		(loop (with-open-stream (socket (socket:socket-accept server))
			(multiple-value-bind (local-host local-port) (socket:socket-stream-peer socket))
			(print socket)
				(http-send-line socket page)
				(terpri socket)
		))
	)
	(socket:socket-server-close server)
))
