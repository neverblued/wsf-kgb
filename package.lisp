;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(defpackage #:wsf-kgb
  (:use #:cl #:wsf #:kgb #:hunchentoot #:blackjack)
  (:export
                                        ; server
   #:secure-server
   #:secure-http-server
   #:secure-website
                                        ; http
   #:authentication-cookie-name
   #:max-authentication-cookie-life
   #:authentication-cookie-life
   #:authentication-period
   #:authentication-cookie
   #:kill-authentication-cookie
                                        ; .
   ))
