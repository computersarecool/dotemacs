;; Set prompt
(defun my-eshell-prompt ()
  "Highlight eshell pwd and prompt separately."
  (mapconcat
   (lambda (list)
     (propertize (car list)
                 'read-only      t
                 'font-lock-face (cdr list)
                 'front-sticky   '(font-lock-face read-only)
                 'rear-nonsticky '(font-lock-face read-only)))
   `((, user-login-name :foreground "cyan")
     (, "@" :foreground "white")
     (, system-name :foreground "#00bfff")
     (,(abbreviate-file-name (eshell/pwd)) :foreground "magenta")
     (,(if (zerop (user-uid)) " # " " $ ") :foreground "cyan"))
   ""))

(setq eshell-highlight-prompt nil
      eshell-prompt-function  #'my-eshell-prompt)

(provide 'init-eshell)
