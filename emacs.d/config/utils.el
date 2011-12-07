(defun set-face-inherit (face inherit &optional frame)
  (interactive (read-face-and-attribute :inherit))
  (set-face-attribute face frame :inherit inherit))
