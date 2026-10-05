;; -*- mode: scheme; -*-
;; Copyright (c) 2026 hollow <i@hollow.ink>

;; `hollow` is the config channel, while default channel supports packages sources
(cons (channel (name 'hollow)
               (url "https://github.com/HollowDobt/guix.git")
               (branch "main")
               (introduction
                 (make-channel-introduction
                   "5c367e00e233f6dce01a621d3e8ab62dd39b971c"
                   (openpgp-fingerprint
                     "143A 0106 4582 B4DC 27CE  15BB 90CC EC5F 3ABC 5F6C"))))

       %default-channels)