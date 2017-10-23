;; Set backup and autosave options
(defvar auto-save-location "~/.emacs.d/.saves/")
(setq backup-directory-alist
      `((".*" . ,auto-save-location)))
(setq auto-save-file-name-transforms
      `((".*" ,auto-save-location t)))

(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)


;; Always follow symlink files
(setq vc-follow-symlinks t)

(provide 'init-file-management)
