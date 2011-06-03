(require 'anything-config)

;; アルファベットで選択
;; (setq anything-enable-digit-shortcuts 'alphabet)

;;; anything-c-moccurの設定

(require 'anything-c-moccur)
(load "~/.emacs.d/site-lisp/find-file-anything.el")
;; カスタマイズ可能変数の設定(M-x customize-group anything-c-moccur でも設定可能)
(setq anything-c-moccur-anything-idle-delay 0.1 ;`anything-idle-delay'
      anything-c-moccur-higligt-info-line-flag t ; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
      anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
      anything-c-moccur-enable-initial-pattern t
      anything-c-moccur-enable-auto-look-flag t ; 選択中の候補を他のバッファにリアルタイムに表示する
      ) ; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする

(setq anything-idle-delay 0)
(setq anything-quick-update t)


;;; キーバインドの割当(好みに合わせて設定してください)
(global-set-key (kbd "C-o") 'anything-c-moccur-occur-by-moccur) ;バッファ内検索
(global-set-key (kbd "M-o") 'anything-c-moccur-buffer-list) ;moccur
(global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur) ;ディレクトリ
(add-hook 'dired-mode-hook ;dired
          '(lambda ()
             (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))


(global-set-key (kbd "C-;") 'anything)
(setq anything-sources (list 
                             ;anything-c-source-project
                             ;anything-c-source-imenu
                             ;; anything-c-source-file-name-history
                             ;; anything-c-source-projects-history ;; I need!!!!!
                             ;; anything-c-source-mac-spotlight
                             anything-c-source-buffers
                             anything-c-source-recentf
                             anything-c-source-bookmarks
                             nym:anything-find-file   ;; cool
                             ;;anything-c-source-complete-ruby-all
                             ;;anything-c-source-occur-by-moccur
                             anything-c-source-files-in-current-dir
                             ;; anything-c-source-emacs-functions
                             ;; anything-c-source-google-suggest
                             anything-c-source-emacs-commands
                             ;; anything-c-source-locate
                             anything-c-source-mac-spotlight
                             anything-c-source-complex-command-history
                             ))
(define-key anything-map "\C-p" 'anything-previous-line)
(define-key anything-map "\C-n" 'anything-next-line)
(define-key anything-map "\C-v" 'anything-next-page)
(define-key anything-map "\M-v" 'anything-previous-page)
(global-set-key (kbd "M-y") 'anything-show-kill-ring)
(setq anything-candidate-number-limit 100) ; 表示する最大候補数。デフォルトで 50

(global-set-key (kbd "M-i") 'anything-imenu)

  (require 'anything-dabbrev-expand)
  (global-set-key "\M-/" 'anything-dabbrev-expand)
  (define-key anything-dabbrev-map "\M-/" 'anything-dabbrev-find-all-buffers)

;; dabbrev時に、大文字・小文字を区別しない。
(setq dabbrev-case-fold-search nil)

(when nil
(defun anything-execute-persistent-action ()
  "If a candidate was selected then perform the associated action without quitting anything."
  (interactive)
  (save-selected-window
    (select-window (get-buffer-window anything-buffer))
    (select-window (setq minibuffer-scroll-window
                         (if (one-window-p t) (split-window) (next-window (selected-window) 1))))
    (let* ((anything-window (get-buffer-window anything-buffer))
           (selection (if anything-saved-sources
                          ;; the action list is shown
                          anything-saved-selection
                        (anything-get-selection)))
           (default-action (anything-get-action))
           (action (assoc-default 'persistent-action (anything-get-current-source))))
      (setq action (or action default-action))
      (if (and (listp action)
               (not (functionp action)))  ; lambda
        ;; select the default action
          (setq action (cdar action)))
      (set-window-dedicated-p anything-window t)
      (unwind-protect
          (and action selection (funcall action selection))
        (set-window-dedicated-p anything-window nil)))))
(define-key anything-map "\C-z" 'anything-execute-persistent-action)
)

(require 'anything-grep)
(require 'anything-project)
  ;; drill-instructor
  ;;   (require  'drill-instructor)
  ;;   (drill-instructor t)


(defun anything-find-file ()
  (interactive)
  (anything-other-buffer 'nym:anything-find-file "*anything find-file*"))

(global-set-key (kbd "M-p") 'anything-project)

(when (require 'magit nil t)
  (require 'anything-git-grep)
  (defun anything-git-grep ()
    (interactive)
    (anything-other-buffer 'anything-c-source-git-grep "*anything find-file*"))

  (global-set-key  [(super o)] 'anything-git-grep)
  )

;; (define-key global-map [(super t)] 'anything-timers)



(require 'anything-rdefs)

(setq ar:command "~/bin/rdefs.rb")
(add-hook 'ruby-mode-hook
  (lambda ()
    (define-key ruby-mode-map [(meta i)] 'anything-rdefs)))
