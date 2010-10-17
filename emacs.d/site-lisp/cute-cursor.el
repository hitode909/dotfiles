(defvar cute-cursor-interval 0.5
  "Interval")

(defvar cute-cursor-colors '("red" "green" "blue" "yellow" "purple" "magenta" "cyan")
  "Colors")

(defvar cute-cursor-current-cursor 0
  "Current color")

(defvar cute-cursor-timer nil
  "Current color")

(defun cute-cursor-toggle-cursor-color ()
  "Toggle cursor color."
  (progn
    (set-cursor-color (nth cute-cursor-current-cursor cute-cursor-colors))
    (setq cute-cursor-current-cursor (1+ cute-cursor-current-cursor))
    (if (>= cute-cursor-current-cursor (length cute-cursor-colors))
        (setq cute-cursor-current-cursor 0))
    ))

(defun cute-cursor (flag)
  "Start toggling cursor color when flag is true."
  (if (and flag cute-cursor-timer)
      (cute-cursor nil))
  (if flag
      (progn
        (setq cute-cursor-timer (run-with-timer cute-cursor-interval
                                                cute-cursor-interval
                                                'cute-cursor-toggle-cursor-color))
        (blink-cursor-mode 0))
    (when cute-cursor-timer
      (cancel-timer cute-cursor-timer)
      (setq cute-cursor-timer nil))))

(provide 'cute-cursor)
