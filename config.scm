;; -*- mode: scheme; -*-
;; Copyright (c) 2026 hollow <i@hollow.ink>

(use-modules (machines init))

;; change `WORKER01` to any node name in need
(machine-system (or (getenv "GUIX_MACHINE") (gethostname)))