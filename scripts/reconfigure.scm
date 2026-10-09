;; -*- mode: scheme; -*-
;; Copyright (c) 2026 hollow <i@hollow.ink>
;; Invoke with: guix repl -- scripts/reconfigure.scm
;; WARNING: This scirpt will not automatically `guix pull`

;; Resolve the repository relative to this script, regardless of cwd.
(define %repository
  (canonicalize-path (string-append (dirname (car (command-line))) "/..")))
(chdir %repository)

(define (run . args)
  (let ((status (apply system* args)))
    (unless (zero? status)
      (format (current-error-port) "Command failed: ~s~%" args)
      (exit 1))))

;; Use the freshly pulled Guix executable when reconfiguring the system.
(define %home (getenv "HOME"))
(unless %home (error "HOME is unset"))
(define %guix (string-append %home "/.config/guix/current/bin/guix"))
(unless (file-exists? %guix) (error "Guix executable not found" %guix))

;; The system's guix-home-service-type also deploys the home environment.
(run "sudo" %guix "system" "reconfigure" "-L" "modules" "config.scm")