;; -*- mode: scheme; -*-
;; Copyright (c) 2026 hollow <i@hollow.ink>

;; Although only `common init` are imported here,
;; `resolve-interface` in function `machine-system`could
;; automatically import modules in need.
(define-module (machines init)
  ;; IMPORT
  #:use-module (common init)
  ;; EXPORT
  #:export (machine-system))

;; New machine config must obey the path standards:
;; `machines {new machine name(CAPITAL)} init`
(define (machine-system machine)
  (let* ((name (string->symbol (string-downcase machine)))
         (module-name `(machines ,name init))
         (module (resolve-interface module-name)))
    (make-system
     (module-ref module '%host-name)
     (module-ref module '%packages)
     (module-ref module '%services))))