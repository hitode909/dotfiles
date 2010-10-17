(defvar cute-region-interval 0.05
  "*Interval")

(defvar cute-region-colors '("red" "green" "blue" "yellow" "purple" "magenta" "cyan")
  "*Colors")

(defvar cute-region-current-region 0
  "Current color")

(defvar cute-region-timer nil
  "Timer")

(defun cute-region-toggle-region-color ()
  "Toggle region color."
  (progn
    (set-face-background 'region (nth cute-region-current-region cute-region-colors))
    (setq cute-region-current-region (1+ cute-region-current-region))
    (if (>= cute-region-current-region (length cute-region-colors))
        (setq cute-region-current-region 0))
    ))

(defun cute-region (flag)
  "Start toggling region color when flag is true."
  (if (and flag cute-region-timer)
      (cute-region nil))
  (if flag
      (progn
        (setq cute-region-timer (run-with-timer cute-region-interval
                                                cute-region-interval
                                                'cute-region-toggle-region-color))
        )
    (when cute-region-timer
      (cancel-timer cute-region-timer)
      (setq cute-region-timer nil))))

(provide 'cute-region)
