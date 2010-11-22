(defvar anything-c-source-git-grep-cache nil "(path)")

(defun anything-git-grep-init ()
  (lexical-let* ((top-dir
                  (magit-get-top-dir
                   (if (buffer-file-name)
                       (file-name-directory (buffer-file-name))
                     default-directory))))
    (setq anything-c-source-git-grep-cache
          (if (magit-git-repo-p top-dir) (list top-dir) nil))))

(defun anything-git-grep-process ()
  (if anything-c-source-git-grep-cache
      (let ((default-directory (first anything-c-source-git-grep-cache)))
        (start-process "git-grep-process" nil
                       "git" "--no-pager" "grep" "-n" "--no-color" "--"
                       anything-pattern))
    '()))

(defun anything-git-grep-transformer (cds source)
  (mapcar (lambda (x)
            (lexical-let* ((list (split-string x ":"))
                           (file-name (first list))
                           (line-number (second list))
                           (line (apply 'concat (cddr list))))
              (cons (format "%s:%s:\n  %s" file-name line-number line) x)))
          cds))

(defun anything-git-grep-goto (x)
  (lexical-let* ((list (split-string x ":"))
                 (file-name (first list))
                 (line-number (second list))
                 (top-dir (first anything-c-source-git-grep-cache)))
    (find-file (file-truename (expand-file-name file-name top-dir)))
    (goto-line (string-to-number line-number))))

(defvar anything-c-source-git-grep
  '((name . "Git Grep")
    (multiline)
    (init . anything-git-grep-init)
    (candidates . anything-git-grep-process)
    (filtered-candidate-transformer anything-git-grep-transformer)
    (action . (("Goto " . anything-git-grep-goto)))
    (requires-pattern . 3)
    (volatile)
    (delayed)))

(provide 'anything-git-grep)