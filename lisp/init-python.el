;; Jedi
(add-hook 'python-mode-hook 'jedi:setup)
(unless (eq system-type 'windows-nt)
  (setq py-python-command "/usr/bin/python3")
  (setq jedi:environment-root "jedi"))

(provide 'init-python)
