;; List all packages and archives that will be used
(setq package-list '(
                    exec-path-from-shell
                    cmake-mode
                    company
                    buffer-move
                    circe
                    tramp-term
                    neotree
                    yasnippet
                    flycheck
                    multiple-cursors
                    ws-butler
                    nodejs-repl
                    tern
                    js2-mode
                    json-mode
                    js-doc
                    skewer-mode
                    repl-toggle
                    markdown-mode
                    dtrt-indent
                    glsl-mode
                    rust-mode
                    rainbow-mode
                    rainbow-delimiters
                    cyberpunk-theme
                    ))

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

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
