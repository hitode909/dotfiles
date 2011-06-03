;; zencoding
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes

(define-key zencoding-mode-keymap (kbd "C-c C-m") 'zencoding-expand-line)
(define-key zencoding-preview-keymap (kbd "C-m") 'zencoding-preview-accept)
(define-key zencoding-mode-keymap (kbd "C-j") 'skk-mode)
(define-key html-mode-map (kbd "=") (smartchr '("=")))

