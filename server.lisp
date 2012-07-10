;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(in-package #:wsf-kgb)

(defclass secure-server () ())

(defclass secure-http-server (http-server secure-server) ())
(defclass secure-website (website secure-server) ())

(defmethod respond :around ((server secure-server) request)
  (with-authentication request (call-next-method)))

(defmethod request-user :around ((request request))
  (awith (call-next-method)
    (setf (authentication-cookie) it)
    it))
