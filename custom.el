;; Customize
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#000000" :foreground "#d3d3d3" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :width normal :foundry "outline"))))
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
    (cmake-mode tramp-term web-beautify dtrt-indent editorconfig auto-complete cyberpunk-theme simple-httpd json-mode nodejs-repl repl-toggle tern-auto-complete tern yasnippet multiple-cursors neotree)))
 '(send-mail-function (quote smtpmail-send-it))
 '(show-paren-mode t)
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25)
 '(tool-bar-mode nil)
 '(whitespace-display-mappings (quote ((space-mark 32 [183]) (tab-mark 9 [187 9])))))
