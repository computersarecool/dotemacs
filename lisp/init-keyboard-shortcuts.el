(global-set-key (kbd "<f5>")
 (lambda (&optional force-reverting)
   "Interactive call to revert-buffer. Ignoring the auto-save
file and not requesting for confirmation. When the current buffer
is modified, the command refuses to revert it, unless you specify
the optional argument: force-reverting to true."
  (interactive "P")
  (if (or force-reverting (not (buffer-modified-p)))
    (revert-buffer :ignore-auto :noconfirm)
    (error "The buffer has been modified"))))

(provide 'init-keyboard-shortcuts)
