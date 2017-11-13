(setq-default indent-tabs-mode nil)
(setq dtrt-indent-mode t)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)


(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(show-paren-mode t)
(electric-pair-mode t)
(global-hi-lock-mode t)
(setq require-final-newline t)
(setq visible-bell t)
(setq column-number-mode t)

(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time)

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook
	(lambda ()
		(rainbow-mode 1)))

(add-hook 'find-file-hook 'linum-mode)
(add-hook 'find-file-hook 'ac-emoji-setup)

(provide 'init-editor-settings)
