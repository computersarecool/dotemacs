;; Set paths correctly
(unless (eq system-type 'windows-nt)
  (exec-path-from-shell-copy-env "EDITOR")
  (exec-path-from-shell-copy-env "VISUAL")
  (exec-path-from-shell-copy-env "MONGO_PATH")
 (exec-path-from-shell-initialize))

(provide 'init-linux)
