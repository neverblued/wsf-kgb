;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(in-package #:wsf)

(defclass secure-server (database-server) ())
(defclass secure-http-server (secure-server http-server) ())
(defclass secure-website (secure-server website) ())

(defmethod respond ((server secure-http-server) request)
  (with-authentication request (call-next-method)))
