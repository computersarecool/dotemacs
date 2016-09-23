;; make sure we are working with some modern code
(when (version<= emacs-version "24.0")
  (message "You are running some old-ass emacs. As in %s.%s old." emacs-major-version emacs-minor-version))


;; package management
(setq package-list '(
                    nodejs-repl
                    tern
                    tern-auto-complete
                    jedi
		    skewer-mode
		    markdown-mode
		    json-mode
		    ac-emoji
		    guess-style
		    ws-butler
		    glsl-mode
		    flycheck
		    multiple-cursors
                    rainbow-delimiters
		    js2-mode
		    auto-complete
		    ac-capf
		    neotree
		    yasnippet
		    cyberpunk-theme
		    ))


(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

;; activate all packages
(package-initialize)

;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; install missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;; change location of backups
(setq backup-directory-alist
      `(("." . ,"~/.emacs.d/.saves/")))
(setq auto-save-file-name-transforms
            `(("." ,"~/.emacs.d/.saves/" t)))

(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; TODO: Do not disable autosave
(setq auto-save-default nil)


;; guess-style mode
(autoload 'guess-style-set-variable "guess-style" nil t)
(autoload 'guess-style-guess-variable "guess-style")
(autoload 'guess-style-guess-all "guess-style" nil t)


;; butler mode
(ws-butler-mode t)


;; eshell
;; prompt
(setq eshell-prompt-function (lambda nil
   (concat
    (propertize (user-login-name) 'face `(:foreground "color-87"))
    (propertize "@" 'face `(:foreground "white"))
    (propertize (car (split-string system-name "\\.")) 'face `(:foreground "green"))
    (propertize (eshell/pwd) 'face `(:foreground "yellow"))
    (propertize " $ " 'face `(:foreground "white")))))
(setq eshell-highlight-prompt nil)

;; clear it!
(defun eshell/clear ()
  (let ((inhibit-read-only t))
    (erase-buffer)))


;; neotree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(global-set-key (kbd "M-n n") 'neotree)


;; multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-c C-y a") 'mc/edit-lines)
(global-set-key (kbd "C-c C-y d") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-y p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-y x") 'mc/mark-all-like-this)


;; yasnippit (load before auto complete)
(require 'yasnippet)
(yas-global-mode 1)


;; autocomplete mode
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(global-auto-complete-mode t)


;; skewer mode
(skewer-setup)


;; flycheck mode
(global-flycheck-mode)


;; tern mode
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))


;; javascript things
(add-to-list 'auto-mode-alist '("\\.js" . js2-mode))
(setq-default js2-basic-offset 2)
(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)
(add-hook 'js2-mode-hook
          (lambda ()
            (setq mode-name "Zono-mode")
            (tern-mode t)))


;; tern mode
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))


;; repl-toggle
;; key shortcuts- are C-u (1 - 3 times) followed by C-c C-z
;; (setq rtog/fullscreen t)
;; (require 'repl-toggle)
;; (setq rtog/mode-repl-alist '((js2-mode . nodejs-repl)))


;; python + jedi mode
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)


;; flycheck mode
(global-flycheck-mode)


;; This is what happens if you don't have a GUI version
(unless window-system
  ;; linum-mode
  (defun linum-format-func (line)
    (concat
     (propertize (format linum-format-fmt line) 'face 'linum)
     (propertize " " 'face 'mode-line)))
  
  (add-hook 'linum-before-numbering-hook
            (lambda ()
              (setq-local linum-format-fmt
                          (let ((w (length (number-to-string
                                            (count-lines (point-min) (point-max))))))
                            (concat "%" (number-to-string w) "d")))))
  (setq linum-format 'linum-format-func))


;; general hook functions
(add-hook 'find-file-hook 'linum-mode)
(add-hook 'find-file-hook 'ac-emoji-setup)


;; ac-cap init
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")


;; turn off tabs
(setq-default indent-tabs-mode nil)


;; set wdired options
(setq wdired-allow-to-change-permissions t)
(setq wdired-confirm-overwrite t)


;; styling
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-function-param ((t (:foreground "green"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "brightred"))))
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 102 :width normal))))
 '(region ((t (:background "color-33" :foreground "color-251"))))
 '(show-paren-match ((t (:background "green" :foreground "#000000"))))
 '(tooltip ((t (:inherit variable-pitch :background "cyan" :foreground "black")))))


;; set the global cosmetics
(blink-cursor-mode t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)
(show-paren-mode t)
(electric-pair-mode t)
(setq column-numver-mode t)
(setq require-final-newline t)
(load-theme 'cyberpunk t)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'find-file-hook 'linum-mode)
(add-hook 'find-file-hook 'ac-emoji-setup)

;; ac-cap init
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")


;; turn off tabs
(setq-default indent-tabs-mode nil)

;; entrance message
(add-hook 'after-init-hook
	  (lambda ()
	    (message "Welcome home %s" (user-login-name))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (editorconfig auto-complete cyberpunk-theme simple-httpd json-mode nodejs-repl repl-toggle tern-auto-complete tern yasnippet multiple-cursors neotree)))
 '(tool-bar-mode nil)
 '(show-paren-mode t) 
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25))

