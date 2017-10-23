;; Never stop cursor blinking
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

;; Set font (this might hide the splash screen)
(when (member "DejaVu Sans Mono" (font-family-list))
   (set-face-attribute 'default nil :font "DejaVu Sans Mono"))

(provide 'init-style)
