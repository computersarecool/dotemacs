(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-hook 'js2-mode-hook
          (lambda ()
            (setq mode-name "Zono-mode")
            (setq js2-basic-offset 2)
            (setq js2-indent-switch-body t)
            (setq js-switch-indent-offset t)

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
)
          )

	  

;; Node.js REPL
(require 'nodejs-repl)

;; JSON mode
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(setq json-reformat:indent-width 2)

;; Skewer mode
(skewer-setup)

(provide 'init-javascript)
