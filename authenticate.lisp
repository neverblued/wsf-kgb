;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(in-package #:wsf-kgb)

(defmethod authenticate ((request request))
  (aif (request-credentials request)
       (authenticate it)
       (awhen (authentication-cookie)
         (seal-person it))))

(defmethod authenticate :around ((request request))
  (let ((*request* request))
    (call-next-method)))
