;; List all packages and repos used
(setq package-list '(
                    exec-path-from-shell
                    auto-complete
                    buffer-move
                    ac-emoji
                    circe
                    tramp-term
                    neotree
                    yasnippet
                    flycheck
                    jedi
                    multiple-cursors
                    ws-butler
                    nodejs-repl
                    tern
                    tern-auto-complete
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

(provide 'init-packages)
