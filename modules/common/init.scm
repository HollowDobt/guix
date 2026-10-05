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
  #:use-module (guix gexp)

  #:use-module ((common networking) #:prefix networking:)
  #:use-module ((common ssh) #:prefix ssh:)
  ;; EXPORT
  #:export (%packages %services make-system))

(define %packages (append
                    networking:%packages
                    ssh:%packages))

(define %services (append
                    networking:%services
                    ssh:%services))

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
    (file-systems (append 
                    (list
                      (file-system
                        (mount-point "/")
                        (device (file-system-label "GUIX"))
                        (type "ext4")) ; `ext4` is enough for GUIX
                      
                      (file-system
                        (mount-point "/boot")
                        (device (file-system-label "BOOT"))
                        (type "vfat")))
                      
                      %base-file-systems))

    ;; administrator account config : "hollow"                 
    (users (append (list
                     (user-account
                       (name "hollow")
                       (comment "")
                       (group "users")
                       (supplementary-groups '("wheel"))))
                       
                      %base-user-accounts))

    (sudoers-file
      (plain-file
        "sudoers"
        "root ALL=(ALL) ALL\n%wheel ALL=(ALL) ALL\n"))
        
    (packages
      (append
        machine-packages
        %packages
        %base-packages))
        
    (services
      (append
        machine-services
        %services
        %base-services))))