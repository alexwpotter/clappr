;;; -*- mode: Lisp -*-
;;;
;;; $Header: /home/gene/library/website/docsrc/lh/RCS/html-opti.lisp,v 395.1 2008/04/20 17:25:45 gene Exp $
;;;

(defpackage html_pkg
  (:use "COMMON-LISP")
  (:export "a"
     "link"
     "body"
     "br"
     "em"
     "encode"
     "h1"
     "h2"
     "h3"
     "h4"
     "head"
     "hr"
     "html"
     "img"
     "li"
     "ol"
     "p"
     "script"
     "small"
     "strong"
     "table"
     "title"
     "td"
     "th"
     "tr"
     "ul"))
(in-package html_pkg)

(defvar *html-translations* (make-hash-table :test #'eql))
(setf (gethash #\< *html-translations*) "&lt;"
      (gethash #\> *html-translations*) "&gt;"
      (gethash #\& *html-translations*) "&amp;"
      (gethash #\" *html-translations*) "&quot;")

(defun encode (str)
  "Scan a string, converting the unsafe characters to entities
for HTML.  Return the new, safe, HTML string."
  (let ((html ""))
    (map nil #'(lambda (c)
     (setq html (format nil "~a~a" html
            (gethash c *html-translations* c))))
   str)
    html))

(defun tag-begin (tag attribs)
  (apply #'concatenate 'string
   (append (list (format nil "<~a" tag))
     (mapcar #'(lambda (pair)
           (format nil
             " ~a=\"~a\""
             (car pair)
             (cdr pair)))
       attribs)
     (list ">"))))

(defun tag-end (tag)
  (format nil "</~a>" tag))

(defun ensure-strings (lst)
  "Convert each element of LST to a string &
return a new list of the new strings."
  (mapcar #'(lambda (x)
        (typecase x
      (string x)
      (symbol (symbol-name x))
      (t (format nil "~a" x))))
          lst))

(defmacro defhtml-region (name &key
                          prepend-newline
                          append-newline)
  `(defun ,name (&rest args)
     (let ((attribs (and (consp (first args))
       (first args)))
     (lst (if (consp (first args))
        (rest args)
      args)))
       (apply #'concatenate 'string
        (append ,(if prepend-newline
         `'(,(format nil "~%"))
       ())
          (list (tag-begin ',name attribs))
          (ensure-strings lst)
          (list (tag-end ',name))
          ,(if append-newline
         `'(,(format nil "~%"))
       ()))))))


(defhtml-region a)
(defhtml-region link)
(defhtml-region body :prepend-newline t)
(defhtml-region em)
(defhtml-region h1 :prepend-newline t)
(defhtml-region h2 :prepend-newline t)
(defhtml-region h3 :prepend-newline t)
(defhtml-region h4 :prepend-newline t)
(defhtml-region head :prepend-newline t)
(defhtml-region html :append-newline t)
(defhtml-region img)
(defhtml-region li :prepend-newline t)
(defhtml-region ol :prepend-newline t)
(defhtml-region p :prepend-newline t)
(defhtml-region strong)
(defhtml-region table :prepend-newline t)
(defhtml-region title :prepend-newline t)
(defhtml-region td)
(defhtml-region th)
(defhtml-region tr :prepend-newline t)
(defhtml-region ul)
(defhtml-region script)
(defun br () "<br>")
(defun hr () "<hr>")
(defun link (x y z) (format nil "<link rel='~a' type='~a' href='~a' />" x y z))
;;; --- end of file ---
