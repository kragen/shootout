;;;;										;
;;;; (c) 2001-2004 by Jochen Schmidt.
;;;;
;;;; File:            meta.lisp
;;;; Revision:        3.0.0
;;;; Description:     A simple parsing technique
;;;; Date:            20.01.2004
;;;; Authors:         Jochen Schmidt
;;;; Tel:             (+49 9 11) 47 20 603
;;;; Email:           js@codeartist.org
;;;;
;;;; Redistribution and use in source and binary forms, with or without
;;;; modification, are permitted provided that the following conditions
;;;; are met:
;;;; 1. Redistributions of source code must retain the above copyright
;;;;    notice, this list of conditions and the following disclaimer.
;;;; 2. Redistributions in binary form must reproduce the above copyright
;;;;    notice, this list of conditions and the following disclaimer in the
;;;;    documentation and/or other materials provided with the distribution.
;;;;
;;;; THIS SOFTWARE IS PROVIDED "AS IS" AND THERE ARE NEITHER 
;;;; EXPRESSED NOR IMPLIED WARRANTIES -  THIS INCLUDES, BUT 
;;;; IS NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
;;;; AND FITNESS FOR A PARTICULAR PURPOSE.IN NO WAY ARE THE
;;;; AUTHORS LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;;;; SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
;;;; NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES ;
;;;; LOSS OF USE, DATA, OR PROFITS			; OR BUSINESS INTERRUPTION)
;;;; 
;;;; For further details contact the authors of this software.
;;;;
;;;;  Jochen Schmidt        
;;;;  Zuckmantelstr. 11     
;;;;  91616 Neusitz         
;;;;  GERMANY               
;;;;
;;;;
;;;; NOTE:
;;;; This code is based on the well known paper "Pragmatic Parsing in Common Lisp"
;;;; of Henry G. Baker. You can find it at:
;;;;
;;;;    http://linux.rice.edu/~rahul/hbaker/Prag-Parse.html
;;;;
;;;; Bakers version used reader-macros to define a special syntax
;;;; for the META language. I used an s-expression based syntax
;;;; in this implementation
;;;;
;;;; The parsing technique Baker describes in his paper goes back to:
;;;;
;;;;     Schorre, D.V.  "META II: A Syntax-Oriented Compiler Writing Language".
;;;;       Proc. 19'th Nat'l. Conf. of the ACM (Aug. 1964),D1.3-1-D1.3-11.
;;;;
;;;;
;;;; Nürnberg, 01.Jul.2001 Jochen Schmidt

;;; Modified by Markus Ziegler (2004)

(defpackage :meta
  (:use #:common-lisp)
  (:export #:with-string-meta
	   #:with-list-meta
	   #:with-stream-meta
	   #:while
	   #:index
	   #:end
	   #:match))

(in-package :meta)


;;; String matching
(defmacro string-match (x &key source-symbol)
  (etypecase x
    (character
     `(when (and (< index end) (eql (char ,source-symbol index)  ,x))
        (incf index)))
    (string
     (let ((old-index-symbol (gensym "OLD-INDEX-")))
       `(let ((,old-index-symbol index))
          (or (and ,@(map 'list #'(lambda (c) `(string-match ,c
                                                             :source-symbol ',source-symbol)) x))
              (progn (setq index ,old-index-symbol) nil)))))))

(defmacro string-match-type (x v &key source-symbol)
  (let ((char-sym (gensym)))
    `(when (< index end)
       (let ((,char-sym (char ,source-symbol index)))
         (declare (base-char ,char-sym))
         (when (typep ,char-sym ',x)
	   ,@(if v `((setf ,v ,char-sym)) '())
           (incf index))))))


;;; List matching
(defmacro list-match (x &key source-symbol); sublist uses new lexical index
 `(when (and (consp ,source-symbol)
             ,(if (atom x) `(eql (car ,source-symbol) ',x)
                `(let ((,source-symbol (car ,source-symbol))) ,(compile-list x :source-symbol source-symbol))))
    (pop ,source-symbol) t))

(defmacro list-match-type (x v &key source-symbol)
  `(when (and (consp ,source-symbol) (typep (car ,source-symbol) ',x))
     ,@(if v `((setf ,v (car ,source-symbol))) '())
     (pop ,source-symbol) t))

(defun compile-list (l &key source-symbol)
  (if (atom l) `(eql ,source-symbol ',l)
      `(and ,(sexpr-compileit (car l) :meta-parser-type :list :source-symbol source-symbol)
            ,(compile-list (cdr l) :source-symbol source-symbol))))

;;; Stream matching
(defmacro stream-match (x &key source-symbol)
  `(when (eql (peek-char ,source-symbol) ',x) (read-char ,source-symbol)))

(defmacro stream-match-type (x v &key source-symbol)
  `(when (typep (peek-char ,source-symbol) ',x)
     ,(if v `(setf ,v (read-char ,source-symbol)) `(read-char ,source-symbol))))

(defun sexpr-compileit (x &key meta-parser-type source-symbol)
	(typecase x
	  (cons
	   (case (intern (symbol-name (car x)) :keyword)
	     (:and `(and ,@(mapcar #'(lambda (f) (sexpr-compileit f
							   :meta-parser-type meta-parser-type
							   :source-symbol source-symbol))
				  (rest x))))
	     (:or `(or ,@(mapcar #'(lambda (f) (sexpr-compileit f
							  :meta-parser-type meta-parser-type
							  :source-symbol source-symbol))
				 (rest x))))
	     (:while `(not (do () ((not ,(sexpr-compileit (second x)
						 :meta-parser-type meta-parser-type
						 :source-symbol source-symbol))))))
	     (:type (let ((f (rest x))) (list (ecase meta-parser-type
						   (:list 'list-match-type)
						   (:string 'string-match-type)
						   (:stream 'stream-match-type))
						 (first f) (second f)
						 :source-symbol source-symbol
			       		 )))
	     (otherwise x)))
	  (t (list (ecase meta-parser-type
		     (:list 'list-match)
		     (:string 'string-match)
		     (:stream 'stream-match))
		   x
		   :source-symbol source-symbol
		   ))))

(defmacro with-stream-meta ((source-symbol stream) &body body)
  `(let ((,source-symbol ,stream))
     (macrolet ((match (x)
                       (sexpr-compileit x
                                  :meta-parser-type :stream
                                  :source-symbol ',source-symbol)))
       ,@body)))

(defmacro with-string-meta ((source-symbol string-buffer &key (start 0) end) &body body)
  `(let* ((,source-symbol ,string-buffer)
          (index ,start)
          (end ,(or end `(length ,source-symbol))))
     (declare (fixnum index end)
              (type simple-base-string ,source-symbol))
     (macrolet ((match (x)
                       (sexpr-compileit x
                                  :meta-parser-type :string
                                  :source-symbol ',source-symbol)))
             ,@body)))


(defmacro with-list-meta ((source-symbol list) &body body)
  `(let ((,source-symbol ,list))
     (macrolet ((match (x)
                       (sexpr-compileit x
                                  :meta-parser-type :list
                                  :source-symbol ',source-symbol)))
       ,@body)))

#|

(eval-when (compile load eval)
  (deftype digit () '(member #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9))

  (deftype non-digit () '(not (member #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9)))

  (defun ctoi (d) (- (char-code d) #.(char-code #\0)))
)


(defun parse-int (string &aux (s +1) d (n 0))
  (with-string-meta (buffer string)
                    (and
                     (match
                      (and (or #\+ (and #\- (setq s -1)) (and))
			   (type digit d) (setq n (ctoi d))
			   (while (and (type digit d) (setq n (+ (* n 10) (ctoi d)))))))
                     (* s n))))


|#
