;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(in-package #:wsf-kgb)

(defmethod kgb::alias ((request request))
  (or (post-parameter "alias" request)
      (progn (assert-session)
             (get-session-id))))

(defmethod kgb::password ((request request))
  (post-parameter "password" request))

(defmethod guest-alias ((request request))
  nil)

(defmethod guest-password ((request request))
  (handler-case (get-session-id)
    (error ()
      (call-next-method))))
