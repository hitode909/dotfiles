(require 'auto-complete)
(require 'yasnippet)

(defun ac-yasnippet-candidate-1 (table)
  (let ((hashtab (yas/snippet-table-hash table))
        (parents (yas/snippet-table-parents table))
        candidates)
    (maphash (lambda (key value)
               (push key candidates))
             hashtab)
    (setq candidates (all-completions ac-prefix (nreverse candidates)))
    (when parents
      (mapc (lambda (table)
              (setq candidates
                    (append candidates (ac-yasnippet-candidate-1 table))))
            parents))
    candidates))

(defun ac-yasnippet-candidate ()
  (let ((tables (yas/get-snippet-tables major-mode))
        candidate)
    (when tables
      (mapc (lambda (table)
              (setq candidate
                    (append candidate (ac-yasnippet-candidate-1 table))))
            tables))
    candidate))

(defface ac-yasnippet-candidate-face
  '((t (:background "sandybrown" :foreground "black")))
  "Face for yasnippet candidate.")

(defface ac-yasnippet-selection-face
  '((t (:background "coral3" :foreground "white")))
  "Face for the yasnippet selected candidate.")

(defvar ac-source-yasnippet
  '((candidates . ac-yasnippet-candidate)
    (action . yas/expand)
    (limit . 3)
    (candidate-face . ac-yasnippet-candidate-face)
    (selection-face . ac-yasnippet-selection-face))
  "Source for Yasnippet.")

(provide 'auto-complete-yasnippet)
