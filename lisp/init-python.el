;; Elpy
(elpy-enable)

;; Jedi
(unless (eq system-type 'windows-nt)
  (defun my/python-mode-hook ()
    (add-to-list 'company-backends 'company-jedi))

  (add-hook 'python-mode-hook 'my/python-mode-hook))

(provide 'init-python)
