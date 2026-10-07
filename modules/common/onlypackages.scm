;; -*- mode: scheme; -*-
;; Copyright (c) 2026 hollow <i@hollow.ink>

(define-module (common onlypackages)
  ;; IMPORT
  #:use-module (gnu packages admin)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages web)
  ;; EXPORT
  #:export (%packages))

(define %packages (list
                    git
                    curl
                    fastfetch-minimal ; avoid zfs and other dependencies
                    btop
                    ncurses ; basic packages, supports `clear` and other basic commands.
                    bash-completion
                    tree
                    ripgrep
                    jq ; json-format
                    zip
                    unzip))