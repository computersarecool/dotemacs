;; List all packages and archives that will be used
(setq package-list '(
                    exec-path-from-shell
                    cmake-mode
                    company
                    company-jedi
                    company-quickhelp
                    elpy
                    buffer-move
                    circe
                    neotree
                    auctex
                    yasnippet
                    flycheck
                    multiple-cursors
                    ws-butler
                    dockerfile-mode
                    nodejs-repl
                    tern
                    js2-mode
                    json-mode
                    skewer-mode
                    repl-toggle
                    markdown-mode
                    dtrt-indent
                    rust-mode
                    rainbow-mode
                    rainbow-delimiters
                    cyberpunk-theme
                    ))

;; Marmalade is currently not working and therefore can not install the following packages:
;; glsl-mode, tramp-term, js-doc

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ))

;; Load installed packages
(package-initialize)

;; Get list of packages available on archives
(unless package-archive-contents
  (package-refresh-contents))

;; Install missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(provide 'init-packages)
