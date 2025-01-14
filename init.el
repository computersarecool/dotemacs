;; Prevent emacs from adding (package-initialize) to this file
(setq package--init-file-ensured t)

;; Pause if there are any startup errors
(setq debug-on-error t)

;; Make sure we are working with some modern code
(let ((minver "24.0"))
  (when (version< emacs-version minver)
    (error "You are running an old Emacs. This config requires v%s or higher. Please upgrade" emacs-version)))

(when (version< emacs-version "24.5")
  (message "Your Emacs is old, and some functionality in this config will not work. Please upgrade."))

;; Add lisp directory to load path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Set custom custom file directory
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Load and initialize packages
(require 'init-packages)

;; System specific configuration
(if (eq system-type 'windows-nt)
    (require 'init-windows)
  (require 'init-linux))

;; Mode customization files
(require 'init-circe)
(require 'init-neotree)

(require 'init-company)
(require 'init-tramp)
(require 'init-ansi-term)
(require 'init-eshell)
(require 'init-python)
(require 'init-javascript)
(require 'init-c)
(require 'init-cpp)
(require 'init-glsl)
(require 'init-flycheck)
(require 'init-dockerfile)

(require 'init-mc)
(require 'init-ws-butler)
(require 'init-yasnippet)
(require 'init-wdired)
(require 'init-repl-toggle)
(require 'init-tty-settings)
(require 'init-file-management)

(require 'init-helper-functions)
(require 'init-keyboard-shortcuts)
(require 'init-editor-settings)
(require 'init-style)

(require 'init-auctex)

;; Load separate custom file
(when (file-exists-p custom-file)
  (load custom-file))

;; Entrance message 
(add-hook 'after-init-hook
        (lambda ()
          (message "Welcome home %s" (user-login-name))))

