;; auto-complete-mode
;; http://dev.ariel-networks.com/Members/matsuyama/auto-complete
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/auto-complete/dict")
(global-auto-complete-mode t)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(setq ac-dwim t)
(setq ac-ignore-case 'smart)
(setq ac-auto-show-menu 0.4)
(setq ac-menu-height 10)

(when (boundp 'ac-modes)
  (setq ac-modes
    (append ac-modes
      (list 'espresso-mode 'javascript-mode 'css-mode 'text-mode ))))

;; (require 'ac-anything)
;; (define-key ac-complete-mode-map (kbd "C-;") 'ac-complete-with-anything)
(require 'auto-complete-yasnippet)
