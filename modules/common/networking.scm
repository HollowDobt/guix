;; -*- mode: scheme; -*-
;; Copyright (c) 2026 hollow <i@hollow.ink>

(define-module (common networking)
  ;; IMPORT
  #:use-module (gnu packages linux)
  #:use-module (gnu services)
  #:use-module (gnu services networking)
  ;; EXPORT
  #:export (%packages %services))

(define %packages (list ethtool))

(define %services (list
                    (service dhcpcd-service-type)))