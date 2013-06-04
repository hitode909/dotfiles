(defun git-blame-current-line ()
  (interactive)
  (let ((old-buf (current-buffer))
    (blame-buf (get-buffer-create "*blame*"))
    (line-num (number-to-string (line-number-at-pos))))
    (set-buffer blame-buf)
    (erase-buffer)
    (call-process "git-blame-oneline" nil "*blame*" t (buffer-file-name old-buf) line-num)
    (setq content (buffer-string))
    (set-buffer old-buf)
    (when (not (eq (length content) 0))
      (popup-tip content)
      ; (message content)
      )
    ))
(global-set-key [(super b)] 'git-blame-current-line)

(defun git-blame-current-buffer ()
  (interactive)
  (shell-command (concat "git blame " (buffer-file-name (current-buffer))))
  )
(global-set-key [(super B)] 'git-blame-current-buffer)

(defun git-show-at-point ()
  (interactive)
  (shell-command (concat "git show " (thing-at-point 'symbol)))
  )
(global-set-key [(super return)] 'git-show-at-point)


(defun git-root-directory ()
  (replace-regexp-in-string "\n+$" "" (shell-command-to-string "git rev-parse --show-toplevel")))

(defun git-grep (grep-dir command-args)
  (interactive
   (let ((root (concat (git-root-directory) "/")))
     (list
      (read-file-name
       "Directory for git grep: " root root t)
      (read-shell-command
            "Run git-grep (like this): "
            (format "git --no-pager grep -I -n -i -e %s"
                    "")
            'git-grep-history))))
  (let ((grep-use-null-device nil)
        (command
         (format (concat
                  "cd %s && "
                  "%s")
                 grep-dir
                 command-args)))
    (grep command)))

(global-set-key [(super g)] 'git-grep)

(setq magit-save-some-buffers nil)

(setq magit-set-upstream-on-push t)


(require 'open-github-from-here)

(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)

(set-face-inverse-video-p 'diff-added nil)
(set-face-inverse-video-p 'diff-removed nil)

(set-face-foreground 'magit-header "#586e75")
(set-face-background 'magit-header "#fdf6e3")
