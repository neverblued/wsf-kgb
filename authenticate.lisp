;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(in-package #:wsf)

(defmethod authenticate ((request request))
  (let ((*request* request))
    (start-session)
    (awhen (cookie-in auth-cookie-name)
      (kgb::seal-person it))))

(defmethod kgb::guest-password ((request request))
  (session-cookie-value *session*))

(defmethod kgb::introduce-guest :around ((request request))
  (let ((guest (call-next-method)))
    (set-auth-cookie guest)
    guest))
