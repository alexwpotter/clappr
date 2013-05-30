(load "html.lisp")
(use-package 'html_pkg)
(defun ex (file)
(let ((in (open file)))
        (eval (read-line in))
        (close in)))
(setf page (ex "index.l"))
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
