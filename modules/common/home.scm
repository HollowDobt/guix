;; -*- mode: scheme; -*-
;; Copyright (c) 2026 hollow <i@hollow.ink>

(define-module (common home)
  #:use-module (gnu home)
  #:use-module ((common vim init) #:prefix vim:)
  #:export (%home))

(define %home (home-environment (services vim:%home-services)))
