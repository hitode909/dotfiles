(defun anything-define-kyr-grep (command)
  (lexical-let ((command command))
    (lambda ()
      (interactive)
      (let ((query (read-string "Grep query: " (or (thing-at-point 'symbol) "")))
            (root-dir (agrep-find-project-root-dir
                       (or (and buffer-file-name (file-name-directory (buffer-file-name)))
                           (expand-file-name default-directory)
                           (expand-file-name "~")))))
        (when (and query root-dir)
          (anything-grep-base
           (list
            (agrep-source (format (agrep-preprocess-command command)
                                  (shell-quote-argument query)) root-dir))))))))

(defun agrep-find-project-root-dir (dir)
  "Determine whether the given directory is project root dir.
This function checks parent directories recursively. If this
function found the user's home directory or the system root directory,
returns nil."
  (let* ((expanded-dir (expand-file-name dir))
        (file (some 'agrep-resource--project-filep (directory-files expanded-dir))))
    (if file expanded-dir
      (if (or
           (string= expanded-dir "/")
           (string= expanded-dir (expand-file-name "~/"))
           ) nil
        (agrep-find-project-root-dir
         (concat (file-name-as-directory dir) ".."))))))

(defvar agrep-project-root-files
  '("build.xml" "prj.el" ".project" "pom.xml"
    "Makefile" "configure" "Rakefile"
    "NAnt.build" "Makefile.PL"))

(defun agrep-resource--project-filep (file)
  "Determine whether the given file is a project build file.
The current implementation checks
`agrep-project-root-files'."
  (find file
        agrep-project-root-files
        :test 'string=))

(provide 'anything-git-grep)