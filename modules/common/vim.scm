;; -*- mode: scheme; -*-
;; Copyright (c) 2026 hollow <i@hollow.ink>

(define-module (common vim)
  ;; IMPORT
  #:use-module (gnu packages vim)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  ;; EXPORT
  #:export (%packages
            %services))

(define %packages (list vim))

(define %services
  (list
    (extra-special-file "/home/hollow/.vimrc" (local-file "vimrc")))))