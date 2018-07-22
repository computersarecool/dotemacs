;; Theme
(load-theme 'cyberpunk t)

;; Arguments here are for when emacs is active and inactive
(set-frame-parameter (selected-frame) 'alpha '(.95 . 95))
(add-to-list 'default-frame-alist '(alpha . (.95 . 95)))

;; Cursor always blink
(setq blink-cursor-blinks 0)

;; Change cursor color on blink
(defvar blink-cursor-colors (list "#0090E5" "#2493E8" "#4896eb" "#6d9aef" "#919df2" "#b6a1f6" "#daa4f9" "#ffa8fd"))
(setq blink-cursor-count 0)
(defun blink-cursor-timer-function ()
  (when (not (internal-show-cursor-p))
    (when (>= blink-cursor-count (length blink-cursor-colors))
      (setq blink-cursor-count 0))
    (set-cursor-color (nth blink-cursor-count blink-cursor-colors))
    (setq blink-cursor-count (+ 1 blink-cursor-count)))

  (internal-show-cursor nil (not (internal-show-cursor-p))))

;; Font size
(if (eq system-type 'windows-nt)
  (set-face-attribute 'default nil :height 100))

;; Highlighted region
(set-face-attribute 'region nil :background "cyan" :foreground "blue")

;; Rainbow delimeters
(rainbow-delimiters-mode)
(set-face-attribute 'rainbow-delimiters-unmatched-face nil :foreground "red")
(set-face-attribute 'rainbow-delimiters-mismatched-face nil :foreground "white")
(set-face-attribute 'rainbow-delimiters-depth-1-face nil :foreground "cyan")
(set-face-attribute 'rainbow-delimiters-depth-2-face nil :foreground "orchid1")
(set-face-attribute 'rainbow-delimiters-depth-3-face nil :foreground "MediumPurple1")

;; Font family (this hides the splash screen on some Windows systems)
(setq default_font "Office Code Pro D")
(when (member default_font (font-family-list))
  (set-face-attribute 'default nil
                      :family default_font
                      :font default_font))

(provide 'init-style)
