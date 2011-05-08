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



;; ------------------------
;; 
(require 'auto-complete-config)

(defun my-ac-look ()
  "look コマンドの出力をリストで返す"
  (interactive)
  (unless (executable-find "look")
    (error "look コマンドがありません"))
  (let ((search-word (thing-at-point 'word)))
    (with-temp-buffer
      (call-process-shell-command "look" nil t 0 search-word)
      (split-string-and-unquote (buffer-string) "\n"))))

(defun ac-complete-look ()
  (interactive)
  (let ((ac-menu-height 50)
        (ac-candidate-limit t))
  (auto-complete '(ac-source-look))))

;; 表示数制限を変更しない場合
;;(defun ac-complete-look ()
;;  (interactive)
;;  (auto-complete '(ac-source-look)))

(defvar ac-source-look
  '((candidates . my-ac-look)
    (requires . 2)))  ;; 2文字以上ある場合にのみ対応させる

;; キーは好きなのを割り当てて下さい
(global-set-key (kbd "M-h") 'ac-complete-look)