;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(in-package #:wsf-kgb)

(defmethod guest-alias ((request request))
  nil)

(defmethod guest-password ((request request))
  (get-session-id))

(defun request-credentials (request)
  (with-accessors ((alias kgb::alias)
                   (password kgb::password))
      request
    (when (and alias password)
      (alias+password alias password))))

(defmethod authenticate ((request request))
  (aif (request-credentials request)
       (authenticate it)
       (awhen (authentication-cookie)
         (seal-person it))))

(defmethod authenticate :around ((request request))
  (let ((*request* request))
    (start-session)
    (call-next-method)))
