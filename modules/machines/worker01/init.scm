;; -*- mode: scheme; -*-
;; Copyright (c) 2026 hollow <i@hollow.ink>

(define-module (machines worker01 init)
  ;; IMPORT
  ;; EXPORT
  #:export (%host-name %packages %services))

(define %host-name "WORKER01")

;; WORKER01-specific packages.
(define %packages
  '())

;; WORKER01-specific services.
(define %services
  '())