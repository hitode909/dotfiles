;; zencoding
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes

(define-key zencoding-mode-keymap (kbd "<C-return>") 'zencoding-expand-yas)
(define-key zencoding-mode-keymap (kbd "C-c C-m") 'zencoding-expand-yas)
(define-key zencoding-mode-keymap (kbd "C-c C-p") 'zencoding-expand-line)
;; (define-key zencoding-preview-keymap (kbd "C-m") 'zencoding-expand-yas)
;; (define-key zencoding-preview-keymap (kbd "RET") 'zencoding-expand-yas)
;; (define-key zencoding-preview-keymap (kbd "<return>") 'zencoding-expand-yas)

(define-key zencoding-mode-keymap (kbd "C-j") 'skk-mode)


(add-hook 'html-mode-hook
          '(lambda ()
             (define-key html-mode-map (kbd "=") (smartchr '("=")))
             ))