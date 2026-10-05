;; -*- mode: scheme; -*-
;; Copyright (c) 2026 hollow <i@hollow.ink>

;; This GUIX system assumes that two disks with 
;; different Labels:
;; - Label `BOOT` -> `/boot`
;; - Label `GUIX` -> `/` 

(define-module (common init)
  ;; IMPORT
  #:use-module (gnu)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu services base)
  #:use-module (guix gexp)

  #:use-module ((common onlypackages) #:prefix onlypackages:)
  #:use-module ((common networking) #:prefix networking:)
  #:use-module ((common ssh) #:prefix ssh:)
  #:use-module ((common vim) #:prefix vim:)
  ;; EXPORT
  #:export (%packages %services make-system))

(define %packages (append
                    onlypackages:%packages
                    networking:%packages
                    ssh:%packages
                    vim:%packages))

(define %services (append
                    networking:%services
                    ssh:%services
                    vim:%services))

(define (make-system host-name machine-packages machine-services)

  (operating-system
    (host-name host-name)
    (timezone "Asia/Shanghai")
    (locale "en_US.utf8")
    
    ;; assume to use UEFI bootloader
    (bootloader (bootloader-configuration
                  (bootloader grub-efi-bootloader)
                  (targets '("/boot"))))

    ;; AGAIN WARNING
    ;; - Label `BOOT` -> `/boot`
    ;; - Label `GUIX` -> `/` 
    (file-systems (cons*
                    (file-system
                      (mount-point "/")
                      (device (file-system-label "GUIX"))
                      (type "ext4")) ; `ext4` is enough for GUIX
                    (file-system
                      (mount-point "/boot")
                      (device (file-system-label "BOOT"))
                      (type "vfat"))
                    %base-file-systems))

    ;; administrator account config : "hollow"                 
    (users (cons*
             (user-account
               (name "hollow")
               (comment "administrator")
               (group "users")
               (supplementary-groups '("wheel")))
             %base-user-accounts))

    (sudoers-file (plain-file 
                    "sudoers"
                    "root ALL=(ALL) ALL\n%wheel ALL=(ALL) ALL\n"))
        
    (packages
      (append
        machine-packages
        %packages
        %base-packages))

    (services (modify-services
                (append machine-services %services %base-services)
                (guix-service-type config => (guix-configuration
                                               (inherit config)
                                               ;; NOT use SJTU Mirror as the only substitute server.
                                               ;; FOR avoid compiling sources locally.
                                               ;; FOR `gnu.org` provides compilation caches.
                                               (substitute-urls
                                                 '("https://mirror.sjtu.edu.cn/guix"
                                                   "https://bordeaux.guix.gnu.org"
                                                   "https://ci.guix.gnu.org"))))))))
