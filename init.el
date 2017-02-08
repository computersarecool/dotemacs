;;; Package --- summary

;;; Commentary:
;; My Emacs initialization file

;;; Code:
;; Make sure we are working with some modern code
(when (version<= emacs-version "24.0")
  (message "You are running some old-ass emacs. As in %s.%s old." emacs-major-version emacs-minor-version))


;; List all packages used and their repos
(setq package-list '(
                    exec-path-from-shell
                    auto-complete
                    buffer-move
                    ac-capf
                    ac-emoji
                    nodejs-repl
                    circe
                    neotree
                    yasnippet
                    flycheck
                    tern
                    tern-auto-complete
                    jedi
                    multiple-cursors
                    ws-butler
                    js2-mode
                    json-mode
                    skewer-mode
                    repl-toggle
                    markdown-mode
                    glsl-mode
                    rainbow-mode
                    rainbow-delimiters
                    cyberpunk-theme
                    ))

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

;; Activate all packages
(package-initialize)

;; Get list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; Install missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;; set path correctly
(unless (eq system-type 'windows-nt)
(exec-path-from-shell-initialize))


;; handle back ups and auto-saves
(defvar auto-save-location "~/.emacs.d/.saves/")

(setq backup-directory-alist
      `((".*" . ,auto-save-location)))
(setq auto-save-file-name-transforms
      `((".*" ,auto-save-location t)))

(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)


;; tramp
(setq tramp-default-method "ssh")
(setq tramp-auto-save-directory auto-save-location)
(setq tramp-backup-directory-alist auto-save-location)

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


;; neotree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(global-set-key (kbd "M-n n") 'neotree)


;; circe
(setq circe-network-options
      '(("Freenode"
         :tls t
         :nick "optonox"
         :sasl-username "optonox"
         :sasl-password (lambda (x) (read-passwd "SASL password: "))
         )))


;; multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-c C-y a") 'mc/edit-lines)
(global-set-key (kbd "C-c C-y n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-y p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-y x") 'mc/mark-all-like-this)


;; yasnippit (load before auto complete)
(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas-global-mode 1)


;; turn off tabs
(setq-default indent-tabs-mode nil)


;; autocomplete mode
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(global-auto-complete-mode t)


;; butler mode
(ws-butler-global-mode t)
(ws-butler-trim-eob-lines)


;; flycheck mode
(global-flycheck-mode)
(setq-default flycheck-disabled-checkers '(javascript-jshint javascript-eslint))


;; flycheck mode
(global-flycheck-mode)


;; skewer mode
(skewer-setup)


;; javascript things
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(setq js2-basic-offset 2)
(setq js2-indent-switch-body t)
(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)
(add-hook 'js2-mode-hook
          (lambda ()
            (setq mode-name "Zono-mode")
            (define-key js2-mode-map (kbd "C-c C-g") 'nodejs-repl-send-last-sexp)
            (define-key js2-mode-map (kbd "C-c C-t") 'nodejs-repl-send-region)
            (define-key js2-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
            (define-key js2-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)
            (tern-mode t)))


;; json mode
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(setq json-reformat:indent-width 2)


;; tern mode
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))


;; nodejs repl
(require 'nodejs-repl)


;; repl-toggle
;; shortcuts to sent content to REPL are C-u (1 - 3 times) followed by C-c C-z
(setq rtog/fullscreen t)
(require 'repl-toggle)
(setq rtog/mode-repl-alist '((js2-mode . nodejs-repl)))


;; python + jedi mode
(unless (eq system-type 'windows-nt)
  (setq jedi:environment-root "jedi")
  (setq jedi:environment-virtualenv
      (append python-environment-virtualenv
                            '("--python" "/usr/bin/python3"))))


;;(add-hook 'python-mode-hook 'jedi:setup)
;;(setq jedi:complete-on-dot t)


;; enable rainbow mode
(add-hook 'css-mode-hook 'my-css-mode-hook)
(defun my-css-mode-hook ()
  (rainbow-mode t))


;; c++
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; these are things that happen if you do not have a GUI version
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


;; ac-cap init
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")


;; set wdired options
(setq wdired-allow-to-change-permissions t)
(setq wdired-confirm-overwrite t)


;; styling
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 102 :width normal))))
 '(js2-function-param ((t (:foreground "green"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "brightred"))))
 '(region ((t (:background "color-33" :foreground "color-251"))))
 '(show-paren-match ((t (:background "green" :foreground "#000000"))))
 '(tooltip ((t (:inherit variable-pitch :background "cyan" :foreground "black"))))
 '(whitespace-empty ((t (:background "brightblack" :foreground "#ff0000"))))
 '(whitespace-hspace ((t (:background "#000000" :foreground "color-235"))))
 '(whitespace-indentation ((t (:background "color-234" :foreground "#ff0000"))))
 '(whitespace-line ((t nil)))
 '(whitespace-space ((t (:background "#000000" :foreground "color-232")))))


;; set the global cosmetics
(setq require-final-newline t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)
(show-paren-mode t)
(electric-pair-mode t)
(setq column-number-mode t)
(load-theme 'cyberpunk t)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'find-file-hook 'linum-mode)
(add-hook 'find-file-hook 'ac-emoji-setup)


;; entrance message
(add-hook 'after-init-hook
         (lambda ()
           (message "Welcome home %s" (user-login-name))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(css-indent-offset 2)
 '(custom-enabled-themes (quote (cyberpunk)))
 '(custom-safe-themes
   (quote
    ("38e64ea9b3a5e512ae9547063ee491c20bd717fe59d9c12219a0b1050b439cdd" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default)))
 '(grep-find-ignored-directories
   (quote
    ("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "node_modules" "bower_components")))
 '(package-selected-packages
   (quote
    (editorconfig auto-complete cyberpunk-theme simple-httpd json-mode nodejs-repl repl-toggle tern-auto-complete tern yasnippet multiple-cursors neotree)))
 '(send-mail-function (quote smtpmail-send-it))
 '(show-paren-mode t)
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25)
 '(tool-bar-mode nil)
 '(whitespace-display-mappings (quote ((space-mark 32 [183]) (tab-mark 9 [187 9])))))
