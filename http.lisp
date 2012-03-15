;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(in-package #:wsf)

(defparameter auth-cookie-name "authentication-seal")

(defparameter max-auth-cookie-life (* 365 24 60 60))

(defvar auth-cookie-life (make-hash-table))

(defun auth-cookie-life (subject)
  (gethash subject auth-cookie-life max-auth-cookie-life))

(defun (setf auth-cookie-life) (new-life subject)
  (setf (gethash subject auth-cookie-life)
        (or new-life max-auth-cookie-life)))

(defun auth-period (subject)
  (reduce #'min (mapcar #'auth-cookie-life (kgb::groups subject))))

(defun set-auth-cookie (user)
  (set-cookie auth-cookie-name
              :value (kgb::seal user)
              :expires (+ (get-universal-time) (auth-period user))
              :path "/"))

(defun kill-auth-cookie ()
  (set-cookie auth-cookie-name
              :value ""
              :expires 0
              :path "/"))
