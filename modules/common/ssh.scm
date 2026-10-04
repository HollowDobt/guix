;; -*- mode: scheme; -*-
;; Copyright (c) 2026 hollow <i@hollow.ink>

;; @@@ WARNING @@@
;; This config will install hollow's public
;; SSH key in the GUIX System

(define-module (common ssh)
  ;; IMPORT
  #:use-module (gnu packages ssh)
  #:use-module (gnu services)
  #:use-module (gnu services ssh)
  #:use-module (guix gexp) ; 
  ;; EXPORT
  #:export (%packages %services))

(define %packages (list openssh-sans-x))

(define %services (list 
                    (service openssh-service-type
                      (openssh-configuration
                        ;; `sans-x` -> SSH without X11
                        (openssh openssh-sans-x)
                        ;; `#f` -> false
                        (password-authentication? #f)
                        ;; @@@ WARNING @@@
                        ;; install hollow's public key
                        (authorized-keys
                          `(("hollow" ,(plain-file
"hollow.pub"
"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA0HuOewDSuZZ2T91vWXfnJRvcqomymrc7luju5fjDwA i@hollow.ink"))))))))