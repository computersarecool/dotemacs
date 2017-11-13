;; Set theme
(load-theme 'cyberpunk t)

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

;; Set font family (this hides the splash screen on some systems)
(setq default_font "DejaVu Sans Mono")
(when (member default_font (font-family-list))
   (set-face-attribute 'default nil :font default_font))

;; Set font size
(if (eq system-type 'windows-nt)
  (set-face-attribute 'default nil :height 90))

(provide 'init-style)
