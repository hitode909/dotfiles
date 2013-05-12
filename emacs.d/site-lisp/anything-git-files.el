;;; anything-git-files.el --- anything for git files

;; Author: INA Lintaro <tarao.gnn at gmail.com>
;; Version: 0.1
;; Keywords: anything, git

;; This file is NOT part of GNU Emacs.

;;; License:
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(eval-when-compile (require 'cl))
(require 'vc-git)
(require 'anything-config)
(require 'sha1 nil t)

(defgroup anything-git-files nil
  "anything for git files."
  :prefix "anything-git-files:" :group 'anything)

(defcustom anything-git-files:update-submodules-once nil
  "t means to update file list in submodules only once."
  :type 'boolean
  :group 'anything-git-files)

(defconst anything-git-files:ls-args
  '((modified . ("--modified"))
    (untracked . ("--others" "--exclude-standard"))
    (all . nil)))

(defconst anything-git-files:update-check-functions
  '((modified . anything-git-files:status-updated-p)
    (untracked . anything-git-files:status-updated-p)
    (all . anything-git-files:head-updated-p)))

(defconst anything-git-files:status-expire 1)

(defsubst anything-git-files:chomp (str)
  (replace-regexp-in-string "[\r\n]+$" "" str))

(defun anything-git-files:hash (obj)
  obj)
(cond ((fboundp 'secure-hash)
       (defun anything-git-files:hash (obj)
         (secure-hash 'sha1 obj)))
      ((fboundp 'sha1) (fset 'anything-git-files:hash 'sha1)))

(defun anything-git-files:command-to-string (&rest args)
  (with-output-to-string
    (with-current-buffer standard-output
      (apply 'vc-git-command (current-buffer) 0 nil args))))

(defun anything-git-files:root-1 ()
  (file-name-as-directory
   (anything-git-files:chomp
    (anything-git-files:command-to-string "rev-parse" "--show-toplevel"))))

(defun anything-git-files:root ()
  (or (vc-file-getprop default-directory 'git-root)
      (vc-file-setprop default-directory 'git-root
                       (anything-git-files:root-1))))

(defun anything-git-files:head (&optional root)
  (let ((default-directory (or root default-directory)))
    (anything-git-files:chomp
     (anything-git-files:command-to-string "rev-parse" "HEAD"))))

(defun anything-git-files:ls (buffer &rest args)
  (apply 'vc-git-command buffer 0 nil "ls-files" args))

(defun anything-git-files:status-1 ()
  (anything-git-files:command-to-string "status" "--porcelain"))

(defun anything-git-files:status-hash (&optional root)
  "Get hash value of \"git status\" for ROOT repository.
The status and its hash value will be reused until
`anything-git-files:status-expire' seconds after the last time
they have been updated."
  (let* ((default-directory (or root default-directory))
         (prop 'anything-git-files:status-hash)
         (info (vc-file-getprop default-directory prop))
         (last (plist-get info :last))
         (now (float-time)))
    (when (or (not (numberp last))
              (> now (+ anything-git-files:status-expire last)))
      (let ((hash (anything-git-files:hash (anything-git-files:status-1))))
        (setq info (plist-put info :hash hash))))
    (setq info (plist-put info :last now))
    (vc-file-setprop default-directory prop info)
    (plist-get info :hash)))

(defun anything-git-files:once-updated-p (root &optional key)
  (let* ((key (or (and key (format "-%s" key)) ""))
         (prop (intern (format "anything-git-files:once-updated%s" key)))
         (updated (vc-file-getprop root prop)))
    (unless updated
      (vc-file-setprop root prop t)
      t)))

(defun anything-git-files:head-updated-p (root &optional key)
  (let* ((key (or (and key (format "-%s" key)) ""))
         (prop (intern (format "anything-git-files:last-head%s" key)))
         (last-head (vc-file-getprop root prop))
         (head (anything-git-files:head root)))
    (unless (and last-head (string= head last-head))
      (vc-file-setprop root prop head)
      t)))

(defun anything-git-files:status-updated-p (root &optional key)
  (let* ((key (or (and key (format "-%s" key)) ""))
         (prop (intern (format "anything-git-files:last-status%s" key)))
         (last-status (vc-file-getprop root prop))
         (status (anything-git-files:status-hash root)))
    (unless (and last-status (string= status last-status))
      (vc-file-setprop root prop status)
      t)))

(defun anything-git-files:updated-p (mode root &optional key update-once)
  "Check if the status hash value for ROOT repository is updated.
MODE specifies how to check the update status.  The update status
is tracked for each KEY separately."
  (let ((funs (or (and update-once 'anything-git-files:once-updated-p)
                  (cdr (assq mode anything-git-files:update-check-functions))
                  '(anything-git-files:head-updated-p
                    anything-git-files:status-updated-p))))
    (unless (listp funs) (setq funs (list funs)))
    (loop for fun in funs
          always (funcall fun root key))))

(defun anything-git-files:init-fun (what &optional root update-once)
  `(lambda ()
     (let* ((root (or ,root (anything-git-files:root)))
            (buffer-name (format " *anything candidates:%s:%s*" root ',what))
            (buffer (get-buffer-create buffer-name)))
       (anything-attrset 'default-directory root) ; saved for `display-to-real'
       (anything-candidate-buffer buffer)
       (when (anything-git-files:updated-p ',what root ',what ,update-once)
         (let ((default-directory root)
               (args (cdr (assq ',what anything-git-files:ls-args))))
           (apply 'anything-git-files:ls buffer "--full-name" args))))))

(defun anything-git-files:display-to-real (name)
  (expand-file-name name (anything-attr 'default-directory)))

(defun anything-git-files:source (what &optional root repository update-once)
  (let ((name (concat (format "Git %s" (capitalize (format "%s" what)))
                      (or (and repository (format " in %s" repository)) ""))))
    `((name . ,name)
      (init . ,(anything-git-files:init-fun what root update-once))
      (candidates-in-buffer)
      (delayed)
      (type . file)
      (display-to-real . anything-git-files:display-to-real))))

(defun anything-git-files:submodules (&optional root)
  (let ((default-directory (or root (anything-git-files:root)))
        (args '("submodule" "--quiet" "foreach" "echo $path")))
    (loop for module in (split-string
                         (anything-git-files:chomp
                          (apply 'anything-git-files:command-to-string args))
                         "[\r\n]+")
          if (> (length module) 0)
          collect module)))

;;;###autoload
(defun anything-git-files:git-p (&optional root)
  (ignore-errors (anything-git-files:status-hash root)))

;;;###autoload
(defvar anything-git-files:modified-source nil)
(setq anything-git-files:modified-source
      (anything-git-files:source 'modified))

;;;###autoload
(defvar anything-git-files:untracked-source nil)
(setq anything-git-files:untracked-source
      (anything-git-files:source 'untracked))

;;;###autoload
(defvar anything-git-files:all-source nil)
(setq anything-git-files:all-source
      (anything-git-files:source 'all))

;;;###autoload
(defun anything-git-files:submodule-sources (kinds &optional root)
  (let* ((root (or root (anything-git-files:root)))
         (modules (anything-git-files:submodules root))
         (kinds (if (listp kinds) kinds (list kinds)))
         (once anything-git-files:update-submodules-once))
    (loop for module in modules
          append (loop for what in kinds
                       for path = (file-name-as-directory
                                   (expand-file-name module root))
                       collect (anything-git-files:source
                                what path module once)))))

;;;###autoload
(defun anything-git-files ()
  "`anything' for opening files managed by Git."
  (interactive)
  (anything-other-buffer `(anything-git-files:modified-source
                           anything-git-files:untracked-source
                           anything-git-files:all-source
                           ,@(anything-git-files:submodule-sources
                              '(modified untracked all)))
                         "*anything for git files*"))

(provide 'anything-git-files)
;;; anything-git-files.el ends here