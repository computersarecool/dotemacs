;;; Package --- My Emacs intialization file

;;; Commentary:
;; Tested on Windows and Linux

;; Code:

;; Make sure we are working with some modern code
(when (version<= emacs-version "24.0")
  (message "You are running some old-ass emacs. As in %s.%s old." emacs-major-version emacs-minor-version))


;; List all packages and repos used
(setq package-list '(
                    exec-path-from-shell
                    auto-complete
                    buffer-move
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
                    js-doc
                    skewer-mode
                    repl-toggle
                    markdown-mode
                    dtrt-indent
                    glsl-mode
                    rainbow-mode
                    rainbow-delimiters
                    cyberpunk-theme
                    ))

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

;; Load installed packages
(package-initialize)

;; Get list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; Install missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;; Linux: Set paths correctly
(unless (eq system-type 'windows-nt)
  (exec-path-from-shell-copy-env "EDITOR")
  (exec-path-from-shell-copy-env "VISUAL")
  (exec-path-from-shell-copy-env "MONGO_PATH")
 (exec-path-from-shell-initialize))


;; Backup and autosave files
(defvar auto-save-location "~/.emacs.d/.saves/")

(setq backup-directory-alist
      `((".*" . ,auto-save-location)))
(setq auto-save-file-name-transforms
      `((".*" ,auto-save-location t)))

(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)


;; Tramp
(setq tramp-default-method "ssh")
;; Do not save backups of files saved as su or sudo
(setq backup-enable-predicate
      (lambda (name)
        (and (normal-backup-enable-predicate name)
             (not
              (let ((method (file-remote-p name 'method)))
                (when (stringp method)
                                    (member method '("su" "sudo"))))))))

;; ANSI-Term
;; Kill buffer on exit
(defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
  (if (memq (process-status proc) '(signal exit))
      (let ((buffer (process-buffer proc)))
        ad-do-it
        (kill-buffer buffer))
    ad-do-it))
(ad-activate 'term-sentinel)

;; Use Bash
(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

;; Use UTF-8 in ANSI-Term
(defun my-term-use-utf8 ()
  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
(add-hook 'term-exec-hook 'my-term-use-utf8)

;; Eshell
;; Style prompt
(setq eshell-prompt-function (lambda nil
   (concat
    (propertize (eshell/pwd) 'face `(:foreground "blue"))
    (propertize " $ " 'face `(:foreground "green")))))
(setq eshell-highlight-prompt nil)


;; Neotree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(global-set-key (kbd "M-n n") 'neotree)
(setq neo-smart-open t)


;; Circe
(setq circe-network-options
      '(("Freenode"
         :tls t
         :nick "optonox"
         :sasl-username "optonox"
         :sasl-password (lambda (x) (read-passwd "SASL password: "))
         )))


;; Multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-c C-y a") 'mc/edit-lines)
(global-set-key (kbd "C-c C-y n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-y p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-y x") 'mc/mark-all-like-this)


;; Yasnippit
(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas-global-mode 1)


;; WindMove
(windmove-default-keybindings)


;; Turn off tabs - turn on dtrt checking of tabs
(setq-default indent-tabs-mode nil)
(setq dtrt-indent-mode t)

;; Ido mode
(setq ido-enable-flex-matching t)
(ido-mode t)

;; Autocomplete mode
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(global-auto-complete-mode t)


;; WS-Butler  mode
(ws-butler-global-mode t)


;; Flycheck mode
(global-flycheck-mode)
(setq-default flycheck-disabled-checkers '(javascript-jshint javascript-eslint json-python-json))


;; Javascript
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook
          (lambda ()
            (setq mode-name "Zono-mode")
            (setq js2-basic-offset 2)
            (setq js2-indent-switch-body t)

            ;; Disable js2-mode's built in error checking
            (setq js2-mode-show-parse-errors nil)
            (setq js2-mode-show-strict-warnings nil)

            ;; JSDoc shortcuts
            (define-key js2-mode-map "\C-ci" 'js-doc-insert-function-doc)
            (define-key js2-mode-map "@" 'js-doc-insert-tag)

            ;; Node.js repl shortcuts
            (define-key js2-mode-map (kbd "C-c C-g") 'nodejs-repl-send-last-sexp)
            (define-key js2-mode-map (kbd "C-c C-t") 'nodejs-repl-send-region)
            (define-key js2-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
            (define-key js2-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)

            ;; Enable tern mode
            (tern-mode t)))


;; Node.js REPL
(require 'nodejs-repl)

;; REPL-toggle
(setq rtog/fullscreen t)
(require 'repl-toggle)
(setq rtog/mode-repl-alist '((js2-mode . nodejs-repl)))


;; Tern mode
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))


;; JSON mode
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(setq json-reformat:indent-width 2)


;; Skewer mode
(skewer-setup)


;; Python
;; Jedi
(add-hook 'python-mode-hook 'jedi:setup)
(unless (eq system-type 'windows-nt)
  (setq py-python-command "/usr/bin/python3")
  (setq jedi:environment-root "jedi"))


;; C++
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Non-GUI Things
(unless window-system
  ;; Linum-mode special formatting
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


;; Wdired
(setq wdired-allow-to-change-permissions t)
(setq wdired-confirm-overwrite t)

;; Styling
;; Never stop blinking
(setq blink-cursor-blinks 0)
;; Cursor colors
(defvar blink-cursor-colors (list "#0090E5" "#2493E8" "#4896eb" "#6d9aef" "#919df2" "#b6a1f6" "#daa4f9" "#ffa8fd")
"On each blink the cursor will cycle to the next color in this list.")

(setq blink-cursor-count 0)
(defun blink-cursor-timer-function ()
  "Zarza wrote this cyberpunk variant of timer `blink-cursor-timer'.
Warning: overwrites original version in `frame.el'.

This one changes the cursor color on each blink. Define colors in `blink-cursor-colors'."
  (when (not (internal-show-cursor-p))
    (when (>= blink-cursor-count (length blink-cursor-colors))
      (setq blink-cursor-count 0))
    (set-cursor-color (nth blink-cursor-count blink-cursor-colors))
    (setq blink-cursor-count (+ 1 blink-cursor-count))
    )
  (internal-show-cursor nil (not (internal-show-cursor-p))))




(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(setq visible-bell t)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)
(show-paren-mode t)
(electric-pair-mode t)
(setq column-number-mode t)
(load-theme 'cyberpunk t)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook
	(lambda ()
		(rainbow-mode 1)))
(add-hook 'find-file-hook 'linum-mode)
(add-hook 'find-file-hook 'ac-emoji-setup)

(setq require-final-newline t)
(global-hi-lock-mode t)


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


;; Entrance message 
(add-hook 'after-init-hook
        (lambda ()
          (message "Welcome home %s" (user-login-name))))


;; (Hides splash screen)
;; Set font (This hides splash screen)
; (when (member "DejaVu Sans Mono" (font-family-list))
;    (set-face-attribute 'default nil :font "DejaVu Sans Mono"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-function-param ((t (:foreground "#00ff00"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#ff0000"))))
 '(region ((t (:background "#00ffff" :foreground "#ff00ff" :box (:line-width 2 :color "#ff00ff" :style released-button) :slant oblique))))
 '(show-paren-match ((t (:background "#00ff00" :foreground "#000000"))))
 '(tooltip ((t (:inherit variable-pitch :background "cyan" :foreground "#000000")))))

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
 '(fci-rule-color "#383838")
 '(grep-find-ignored-directories
   (quote
    ("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "node_modules" "bower_components")))
 '(package-selected-packages
   (quote
    (dtrt-indent editorconfig auto-complete cyberpunk-theme simple-httpd json-mode nodejs-repl repl-toggle tern-auto-complete tern yasnippet multiple-cursors neotree)))
 '(send-mail-function (quote smtpmail-send-it))
 '(show-paren-mode t)
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25)
 '(tool-bar-mode nil)
 '(whitespace-display-mappings (quote ((space-mark 32 [183]) (tab-mark 9 [187 9])))))
