;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(in-package #:wsf-kgb)

;; session

(defmethod session-cookie-name
    ((acceptor wsf::acceptor))
  "session-id")

(defun get-session-id ()
  (session-id *session*))

;; cookie life

(defparameter max-authentication-cookie-life
  (* 365 24 60 60))

(defvar authentication-cookie-life
  (make-hash-table))

(defun authentication-cookie-life
    (subject)
  (gethash subject authentication-cookie-life max-authentication-cookie-life))

(defun (setf authentication-cookie-life)
    (new-life subject)
  (setf (gethash subject authentication-cookie-life)
        (or new-life max-authentication-cookie-life)))

(defun authentication-period
    (subject)
  (aif (communities subject)
       (reduce #'min (mapcar #'authentication-cookie-life it))
       100500))

;; cookie

(defparameter authentication-cookie-name
  "authentication-seal")

(defun authentication-cookie ()
  (cookie-in authentication-cookie-name))

(defun (setf authentication-cookie)
    (user)
  (macrolet ((set-it ()
               `(set-cookie authentication-cookie-name
                            :value (kgb::seal user)
                            :expires (+ (get-universal-time)
                                        (authentication-period user))
                            :path "/")))
    (handler-case (set-it)
      (error () nil))))

(defun kill-authentication-cookie ()
  (set-cookie authentication-cookie-name
              :value ""
              :expires 0
              :path "/"))
