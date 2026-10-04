;; -*- mode: scheme; -*-
;; hollow <i@hollow.ink>

(use-modules (guix channels))

(cons (channel (name 'hollow)
               (url "https://github.com/HollowDobt/guix.git")
               (branch "main")
               (introduction
                 (make-channel-introduction)))

       %default-channels)