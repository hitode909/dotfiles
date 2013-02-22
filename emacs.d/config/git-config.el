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


;; -u をつける
(magit-define-command push ()
  (interactive)
  (let* ((branch (or (magit-get-current-branch)
		     (error "Don't push a detached head.  That's gross")))
	 (branch-remote (magit-get-remote branch))
	 (push-remote (if (or current-prefix-arg
			      (not branch-remote))
			  (magit-read-remote (format "Push %s to: " branch)
					     branch-remote)
			branch-remote))
	 (ref-branch (magit-get "branch" branch "merge")))
    (if (and (not branch-remote)
	     (not current-prefix-arg))
	(magit-set push-remote "branch" branch "remote"))
    (apply 'magit-run-git-async "push" "-u" "-v" push-remote
           (if ref-branch
               (format "%s:%s" branch ref-branch)
             branch)
           magit-custom-options)
    ;; Although git will automatically set up the remote,
    ;; it doesn't set up the branch to merge (at least as of Git 1.6.6.1),
    ;; so we have to do that manually.
    (unless ref-branch
      (magit-set (concat "refs/heads/" branch) "branch" branch "merge"))))