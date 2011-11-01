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


;; -------------
;;補完候補としたい辞書ファイルの場所を指定します。
(setq ac-skk-jisyo-file "~/co/dotfiles/emacs.d/etc/skk/SKK-JISYO.L")
;;補完候補生成に必要な中間ファイルを置く場所を指定します。
(setq ac-skk-alist-file "~/co/dotfiles/emacs.d/etc/ac-skk-alist.el")
(require 'ac-ja)
(setq ac-sources (append ac-sources '(ac-source-dabbrev-ja)))
(setq ac-sources (append ac-sources '(ac-source-skk)))

;; 変換後になんとか
(eval-after-load "skk"
  '(progn
     (defadvice skk-kakutei (after ad-skk-kakutei last)
       "skk-kakuteiの後にatuo-complete-modeによる補完を実行するadvice"
       (unless (minibufferp)
         (ac-start)))))

(add-hook 'skk-mode-hook
          (lambda ()
            "skk-kakuteiのadviceを活性化"
            (interactive)
            (ad-activate 'skk-kakutei)))

(defadvice skk-mode-exit (before ad-skk-mode-exit last)
       "skk-modeから抜ける時にskk-kakuteiのadviceを不活性化。"
       (ad-deactivate 'skk-kakutei))