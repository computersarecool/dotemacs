(setq tramp-default-method "ssh")

;; Do not save backups of files saved as su or sudo
(setq backup-enable-predicate
      (lambda (name)
        (and (normal-backup-enable-predicate name)
             (not
              (let ((method (file-remote-p name 'method)))
                (when (stringp method)
                                    (member method '("su" "sudo"))))))))

(provide 'init-tramp)
