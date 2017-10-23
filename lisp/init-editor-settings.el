(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode nil)
(show-paren-mode t)
(electric-pair-mode t)
(setq require-final-newline t)
(setq visible-bell t)
(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)
(setq column-number-mode t)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook
	(lambda ()
		(rainbow-mode 1)))
(add-hook 'find-file-hook 'linum-mode)
(add-hook 'find-file-hook 'ac-emoji-setup)

(global-hi-lock-mode t)

(load-theme 'cyberpunk t)

(provide 'init-editor-settings)
