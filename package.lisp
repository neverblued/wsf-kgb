;; (c) Дмитрий Пинский <demetrius@neverblued.info>
;; Допускаю использование и распространение согласно
;; LLGPL -> http://opensource.franz.com/preamble.html

(defpackage #:wsf-kgb
  (:use #:cl #:hunchentoot #:kgb)
  (:export
                                        ; server
   #:secure-http-server #:secure-website
                                        ; http
   #:auth-cookie-life #:kill-auth-cookie #:set-auth-cookie

   ))
