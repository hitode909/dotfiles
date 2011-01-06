(require 'flymake)

(setq flymake-growl-warning-priority 1)
(setq flymake-growl-error-priority   2)

(setq flymake-growl-warning-sticky t)
(setq flymake-growl-error-sticky   t)

(setq flymake-growl-sticky-list nil)

(defun flymake-growl-notify (file line-no message priority sticky)
  (let* ((title (concat file ":" (int-to-string line-no) ":"))
        (command (concat "growlnotify --appIcon  Emacs"
                                    " --progress 0.1"
                                    " --title \""  title "\""
                                    " --identifier \"" title "\""
                                    " --message \"" message "\""
                                    " --priority " (int-to-string priority))))
    (shell-command (concat command (if sticky " --sticky")))
    (if sticky (add-to-list 'flymake-growl-sticky-list (list file line-no message priority)))))

(defun flymake-growl-delete-notify (buffer-name)
  (interactive "b")
  (let ((sticky-list flymake-growl-sticky-list))
    (setq flymake-growl-sticky-list nil)
    (mapc (lambda (sticky)
            (if (string= buffer-name (car sticky))
                (apply 'flymake-growl-notify (append sticky '(nil)))
              (add-to-list 'flymake-growl-sticky-list sticky)))
          sticky-list)))

(defun flymake-growl-delete-all-notify ()
  (interactive)
  (mapc (lambda (sticky)
          (apply 'flymake-growl-notify (append sticky '(nil))))
        flymake-growl-sticky-list)
  (setq flymake-growl-sticky-list nil))

(defun flymake-growl-rename-notify (old-name new-name)
  (mapc (lambda (sticky)
          (when (string= old-name (car sticky))
            (flymake-growl-delete-notify old-name)
            (flymake-growl-notify new-name
                                  (nth 1 sticky)
                                  (nth 2 sticky)
                                  (nth 3 sticky)
                                  t)))
        flymake-growl-sticky-list))

(defadvice flymake-make-overlay (after flymake-growl-make-overlay activate)
  (let* ((face (ad-get-arg 3))
         (priority (case face
                     ('flymake-warnline flymake-growl-warning-priority)
                     ('flymake-errline  flymake-growl-error-priority)
                     (t 0)))
         (sticky (case face
                   ('flymake-warnline flymake-growl-warning-sticky)
                   ('flymake-errline flymake-growl-error-sticky)
                   (t nil))))
    (flymake-growl-notify (buffer-name) line-no (ad-get-arg 2) priority sticky)))

(defadvice flymake-delete-own-overlays (after flymake-growl-delete-own-overlays activate)
  (flymake-growl-delete-notify (buffer-name)))

(defadvice kill-buffer (before flymake-growl-kill-buffer activate)
  (flymake-growl-delete-notify (buffer-name)))

(add-hook 'kill-emacs-hook 'flymake-growl-delete-all-notify)

(defadvice rename-buffer (around flymake-growl-rename-buffer activate)
  (let ((old-name (buffer-name))
        new-name)
    ad-do-it
    (setq new-name (buffer-name))
    (flymake-growl-rename-notify old-name new-name)))