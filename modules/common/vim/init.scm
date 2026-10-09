;; -*- mode: scheme; -*-
;; Copyright (c) 2026 hollow <i@hollow.ink>

(define-module (common vim init)
  #:use-module (gnu packages vim)
  #:use-module (gnu home services)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:export (%packages %home-services))

(define %packages (list vim))

(define %home-services (list (simple-service
                               'vim-config
                               home-files-service-type
                               `((".vimrc" ,(local-file "vimrc"))))))