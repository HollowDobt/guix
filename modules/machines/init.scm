;; -*- mode: scheme; -*-
;; Copyright (c) 2026 hollow <i@hollow.ink>

(define-module (machines init)
  #:use-module ((common system) #:prefix common:)
  #:export (machine-system))

(define (machine-system machine)
  (let* ((name (string->symbol (string-downcase machine)))
         (module-name `(machines ,name init))
         (module (resolve-interface module-name)))
    (common:make-system
      (module-ref module '%host-name)
      (module-ref module '%packages)
      (module-ref module '%services))))
