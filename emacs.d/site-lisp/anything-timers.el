(defvar anything-c-source-absolute-time-timers
  '((name . "Absolute Time Timers")
    (candidates . timer-list)
    (type . timer)))
;; (anything 'anything-c-source-absolute-time-timers)

(defvar anything-c-source-idle-time-timers
  '((name . "Idle Time Timers")
    (candidates . timer-idle-list)
    (type . timer)))
;; (anything 'anything-c-source-idle-time-timers)

(define-anything-type-attribute 'timer
  '((real-to-display . anything-c-timer-real-to-display)
    (action ("Cancel Timer" . cancel-timer))))

(defun anything-c-timer-real-to-display (timer)
  (destructuring-bind (_ t1 t2 t3 _ func args &rest rest) (append timer nil)
    (format "%s %s(%s)"
            (format-time-string "%m/%d %T" (list t1 t2 t3))
            func
            (mapconcat 'prin1-to-string (aref timer 6) " "))))

(defun anything-timers ()
  "Preconfigured `anything' for timers."
  (interactive)
  (anything-other-buffer '(anything-c-source-absolute-time-timers
                           anything-c-source-idle-time-timers)
                         "*anything timers*"))

(provide 'anything-timers)