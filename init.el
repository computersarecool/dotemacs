(setq package--init-file-ensured t)

;; Make sure we are working with some modern code
(let ((minver "24.0"))
  (when (version< emacs-version minver)
    (message "You are running some old-ass emacs. As in %s old." emacs-version)))

(when (version< emacs-version "24.5")
  (message "Your Emacs is old, and some functionality in this config will not work. Please upgrade if possible."))

;; Add lisp directory to load path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Set custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))


(require 'init-packages)

;; Linux specific configuration
(unless (eq system-type 'windows-nt)
  (require 'init-linux))

(require 'init-neotree)
(require 'init-circe)
(require 'init-mc)
(require 'init-yasnippet)
(require 'init-ido)
(require 'init-ws-butler)
(require 'init-autocomplete)
(require 'init-flycheck)
(require 'init-javascript)
(require 'init-repl-toggle)
(require 'init-python)
(require 'init-c)
(require 'init-cpp)
(require 'init-glsl)
(require 'init-tty-settings)
(require 'init-file-management)
(require 'init-tramp)
(require 'init-ansi-term)
(require 'init-eshell)
(require 'init-wdired)
(require 'init-keyboard-shortcuts)
(require 'init-general-coding-style)
(require 'init-editor-settings)
(require 'init-style)

;; Load separate custom file
(when (file-exists-p custom-file)
  (load custom-file))

;; Entrance message 
(add-hook 'after-init-hook
        (lambda ()
          (message "Welcome home %s" (user-login-name))))

