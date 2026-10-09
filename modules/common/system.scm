;; -*- mode: scheme; -*-
;; Copyright (c) 2026 hollow <i@hollow.ink>

;; This GUIX system assumes that two disks with 
;; different Labels:
;; - Label `BOOT` -> `/boot`
;; - Label `GUIX` -> `/` 

(define-module (common system)
  ;; IMPORT
  #:use-module (gnu)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu services base)
  #:use-module (gnu services guix)

  #:use-module ((common home) #:prefix home:)
  #:use-module ((common onlypackages) #:prefix onlypackages:)
  #:use-module ((common networking) #:prefix networking:)
  #:use-module ((common ssh) #:prefix ssh:)
  #:use-module ((common vim init) #:prefix vim:)
  ;; EXPORT
  #:export (make-system))

(define %packages (append
                    onlypackages:%packages
                    networking:%packages
                    ssh:%packages
                    vim:%packages))

(define %services
  (append networking:%services
          ssh:%services
          (list
            (service guix-home-service-type
              `(("hollow" ,home:%home))))))

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
    (users (cons
             (user-account
               (name "hollow")
               (comment "administrator")
               (group "users")
               (supplementary-groups '("wheel")))
             %base-user-accounts))
        
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
                                                 (cons "https://mirror.sjtu.edu.cn/guix"
                                                       %default-substitute-urls))))))))