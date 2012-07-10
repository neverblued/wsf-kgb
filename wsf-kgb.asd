;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(defpackage #:wsf-kgb-system
  (:use #:common-lisp #:asdf))

(in-package #:wsf-kgb-system)

(defsystem "wsf-kgb"
  :description "Web Site Framework security module"
  :version "0.1"
  :author "Дмитрий Пинский <demetrius@neverblued.info>"
  :depends-on (#:wsf #:kgb)
  :serial t
  :components ((:file "package")
               (:file "server")
               (:file "model")
               (:file "http")
               (:file "authenticate")))
