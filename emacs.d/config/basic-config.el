
;; default encodingをutf-8に変更
(set-default-coding-systems 'utf-8)

;; 日本語
(setq current-language-environment "Japanese")

;; color-theme
(require 'color-theme)
(require 'color-theme-solarized)
(color-theme-solarized-light)
(set-face-background 'header-line "#586e75")
(set-face-foreground 'header-line "#fdf6e3")
(set-face-bold-p 'header-line t)

;; 行間
(setq-default line-spacing 0.1)

;; status-barにカーソルのcolumn表示(4,29とか)
(column-number-mode t)

;; ファイル名補完で大文字小文字を区別しない
(setq completion-ignore-case t)

;; バックアップファイルを作らない
(setq make-backup-files nil)

;; ソースコードに色を付ける
(global-font-lock-mode t)

;; 起動時のメッセージを表示しない
(setq inhibit-startup-message t)

;; C-hでBSする
(global-set-key "\C-h" 'delete-backward-char)

;; ファイルを開くときにa.jでa.jsにマッチ
; (partial-completion-mode t)

;; カーソル
(set-cursor-color "orange")
(setq blink-cursor-interval 0.04)
(setq blink-cursor-delay 1.0)
; (blink-cursor-mode 1)
(blink-cursor-mode 0)


;; リージョンをC-hで削除
(delete-selection-mode 1)

;; kill-lineで行末の改行文字も削除
(setq kill-whole-line t)

;; M-xでコマンドを入力するときに候補を表示する
(icomplete-mode nil)

;; M-x補完，高機能なやつ
(require 'mcomplete)
(turn-on-mcomplete-mode)

;; mcomplete 色ましに
(set-face-foreground 'mcomplete-prefix-method-fixed-part-face nil)
(set-face-foreground 'mcomplete-prefix-method-alternative-part-face nil)
(set-face-foreground 'mcomplete-substr-method-alternative-part-face nil)
(set-face-foreground 'mcomplete-substr-method-fixed-part-face nil)

;; regionに色を付ける
(transient-mark-mode t)

;; C-x C-bでelectric-buffer-list
(define-key global-map "\C-x\C-b" 'electric-buffer-list)
(eval-after-load "ebuff-menu"
  '(progn
     (define-key
       electric-buffer-menu-mode-map
       "x" 'Buffer-menu-execute)))

;;カーソルを前回編集していた位置に戻す
(load "saveplace")
(setq-default save-place t)


(when (= emacs-major-version 22)
  ;; find-fileするときにファイル名をハイライトして補完
  (setq hc-ctrl-x-c-is-completion t)
  (require 'highlight-completion)
  (highlight-completion-mode 1)
  (global-set-key "\C-\\" 'toggle-input-method)
)


;; 補完してbuffer切替
(iswitchb-mode 1)

;; 対応する括弧を光らせる
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(set-face-attribute 'show-paren-match-face nil
                    :background "#eee8d5" :foreground nil
                    :underline nil :weight 'normal)

;; 画面チカチカさせない
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;;; status-barに時間表示
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-string-forms
      '(month "/" day " " 24-hours ":" minutes " "))
(display-time-mode 1)

;;; カーソルがある行にアンダーラインを表示
;;(global-hl-line-mode)
;;(setq hl-line-face 'underline)
;;(hl-line-mode 1)

;;; yes-noをy-nに置き換え
(fset 'yes-or-no-p 'y-or-n-p)

;; 画面外の文字は折り返しして表示
(setq truncate-lines t)
(setq truncate-partial-width-windows nil)

;; Shebangがあるとき自動的にchmod +xする
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; C-mで改行してインデント
(global-set-key "\C-m" 'newline-and-indent)

(when nil
  (autoload 'save-current-configuration "revive" "Save status" t)
  (autoload 'resume "revive" "Resume Emacs" t)
  (autoload 'wipe "revive" "Wipe emacs" t)
  (define-key ctl-x-map "R" 'resume)                        ;; C-x R で復元
  (define-key ctl-x-map "K" 'wipe)                          ;; C-x K で kill-emacs
  ;;  (add-hook 'kill-emacs-hook 'save-current-configuration)   ;; 終了時に保存
)


(when nil
  ;; browse-kill-ring
  (require 'browse-kill-ring)
  (global-set-key (kbd "C-c k") 'browse-kill-ring)
)

;; (= emacs-major-version 22)
(global-set-key "\C-x\C-r" 'revert-buffer)

(when nil
  (require 'cute-cursor)
  (setq cute-cursor-interval 1.0)
  (setq cute-cursor-colors '("purple" "orange"))
  (cute-cursor t)

  (require 'cute-region)
  (setq cute-region-interval 1.0)
  (setq cute-region-colors '("FloralWhite" "Azure"))
  (cute-region t)
  )

(require 'auto-install)
(auto-install-update-emacswiki-package-name t)

; (require 'anything-timers)

(when nil
;; develock
  ;; zen-coding..........................
(require 'develock nil t)
(plist-put develock-max-column-plist 'cperl-mode nil)
(setq develock-max-column-plist nil)
)
;; 行末の変なスペース強調
(when (boundp 'show-trailing-whitespace)
  (setq-default show-trailing-whitespace t))

;; emacs終了時に確認メッセージを出す。
;; 誤って終了してしまわないようにするため
;; ref: http://blog.livedoor.jp/techblog/archives/64599359.html
(defadvice save-buffers-kill-emacs
  (before safe-save-buffers-kill-emacs activate)
  "safe-save-buffers-kill-emacs"
  (unless (y-or-n-p "Really exit emacs? ")
    (keyboard-quit)))

(when nil
(add-hook 'txt-mode-hook
          '(lambda ()
             ; 変更した箇所を目立たせる
             (global-highlight-changes 'active)
             ; 保存時にローテート
             (add-hook 'write-file-hooks 'highlight-changes-rotate-faces)
             )
          )
)

;; ignore C-z
;; (global-unset-key "\C-z")

;;; メモを取る
(defun my-autonamed-txt()
  (interactive)
  (find-file
   (concat "~/Dropbox/memo/" (format-time-string "%Y%m%d") (system-name) ".txt"))
  )
(global-set-key (kbd "\C-cf") 'my-autonamed-txt)
(global-set-key [(super f)] 'my-autonamed-txt)

(defun my-insert-time ()
  (interactive)
  (insert (concat "* " (current-time-string) "\n" ))
  )
(global-set-key [(super r)] 'my-insert-time)

(defun my-insert-time2 ()
  (interactive)
  (insert (concat "** " (current-time-string) "\n" ))
  )
(global-set-key [(super R)] 'my-insert-time2)

;; recentf
(setq recentf-auto-cleanup 'never)
(recentf-mode 1)
(setq recentf-max-saved-items 10000000)

;; which-func
(require 'which-func)
(which-func-mode t)
(setq which-func-modes (append which-func-modes '(ruby-mode javascript-mode)))


;; view-mode hjkl
(add-hook 'view-mode-hook
          '(lambda()
             (progn
               (define-key view-mode-map "h" 'backward-char)
               (define-key view-mode-map "j" 'next-line)
               (define-key view-mode-map "k" 'previous-line)
               (define-key view-mode-map "l" 'forward-char)
               )))

(when nil
  ;; jkでview-mode
  (require 'key-chord)
  (setq key-chord-two-keys-delay 0.04)
  (key-chord-mode 1)
  (key-chord-define-global "jk" 'view-mode)
)
;;battery
(display-battery-mode t)

(setq auto-mode-alist
      (append '(("\\.xhtml$" . html-mode)) auto-mode-alist))
(setq auto-mode-alist
      (append '(("\\.tt$" . html-mode)) auto-mode-alist))
(setq auto-mode-alist
      (append '(("\\.erb$" . html-mode)) auto-mode-alist))

;; yank した文字列をハイライト表示
(when window-system
  (defadvice yank (after ys:highlight-string activate)
    (let ((ol (make-overlay (mark t) (point))))
      (overlay-put ol 'face 'highlight)
      (sit-for 0.5)
      (delete-overlay ol)))
(defadvice yank-pop (after ys:highlight-string activate)
  (when (eq last-command 'yank)
    (let ((ol (make-overlay (mark t) (point))))
      (overlay-put ol 'face 'highlight)
      (sit-for 0.5)
      (delete-overlay ol)))))


(auto-compression-mode t)

;; tramp
 (require 'tramp)
 (setq tramp-default-method "ssh")

;; scala-mode
  (add-hook 'scala-mode-hook
            '(lambda ()
               (yas/minor-mode-on)
               ))

;====================================
; セッション
;====================================
;Emacsを終了してもファイルを編集してた位置や
;minibuffer への入力内容を覚えててくれます。
(when (require 'session nil t)
(setq session-initialize '(de-saveplace session keys menus places)
      session-globals-include '((kill-ring 500)
                                (session-file-alist 500 t)
                                (file-name-history 10000)))
;; これがないと file-name-history に500個保存する前に max-string に達する
(setq session-globals-max-string 100000000)
)

;;; マイ.emacs探訪 - I am Cruby! http://d.hatena.ne.jp/authorNari/20091225/1261667956

(defadvice iswitchb-exhibit
  (after
   iswitchb-exhibit-with-display-buffer
   activate)
  "選択している buffer を window に表示してみる。"
  (when (and
         (eq iswitchb-method iswitchb-default-method)
         iswitchb-matches)
    (select-window
     (get-buffer-window (cadr (buffer-list))))
    (let ((iswitchb-method 'samewindow))
      (iswitchb-visit-buffer
       (get-buffer (car iswitchb-matches))))
    (select-window (minibuffer-window))))

;;<1>をディレクトリ名にする
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
;; (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-min-dir-content 1)


;;C-Fで右のバッファ
(setq windmove-wrap-around t)
(define-key global-map [(C shift n)] 'windmove-down)
(define-key global-map [(C shift p)] 'windmove-up)
(define-key global-map [(C shift b)] 'windmove-left)
(define-key global-map [(C shift f)] 'windmove-right)

;; dmacro
;; http://pitecan.com/DynamicMacro/
(defconst *dmacro-key* "\C-t" "dmacro-key")
(global-set-key *dmacro-key* 'dmacro-exec)
(autoload 'dmacro-exec "dmacro" nil t)

;;; undo-tree.el の導入 - とりあえず暇だったし何となく始めたブログ
;;; http://d.hatena.ne.jp/khiker/20100123/undo_tree
(require 'undo-tree)
(global-undo-tree-mode)

;;; http://www.emacswiki.org/emacs-en/minor-mode-hack.el
(require 'minor-mode-hack)


;(require 'haml-mode)

;; ack
;; Emacsからackの検索結果を使う - antipop http://d.hatena.ne.jp/antipop/20080311/1205252552
(defun ack ()
  (interactive)
  (let ((grep-find-command "ack --nocolor --nogroup "))
    (call-interactively 'grep-find)))



(when (require 'magit nil t)
  (global-unset-key "\C-xvd")
  (global-set-key [(super s)] 'magit-status)
  (global-set-key [(super l)] 'magit-log)
  )


(when nil

  (defun scroll-one-line-up ()
"一回に一行のスクロールアップ"
(interactive)
(next-line)
(scroll-up 1))

(define-key global-map [(super n)] 'scroll-one-line-up)

(defun scroll-one-line-down ()
  "一回に一行のスクロールダウン"
  (interactive)
  (previous-line)
  (scroll-down 1))

(define-key global-map [(super p)] 'scroll-one-line-down)

)

;; (define-key global-map [(super g)] 'global-outputz-mode)

(defun my-byte-compile ()
  "byte compileします"
  (interactive)
  (byte-recompile-directory "~/.emacs.d/site-lisp/" nil))

(defun my-open-current-file ()
  (interactive)
  (shell-command (format "open %s" (buffer-file-name (current-buffer)))))


;;
;; open file as root
;;______________________________________________________________________

(defun th-rename-tramp-buffer ()
  (when (file-remote-p (buffer-file-name))
    (rename-buffer
     (format "%s:%s"
             (file-remote-p (buffer-file-name) 'method)
             (buffer-name)))))

(add-hook 'find-file-hook
          'th-rename-tramp-buffer)

(defadvice find-file (around th-find-file activate)
  "Open FILENAME using tramp's sudo method if it's read-only."
  (if (and (not (file-writable-p (ad-get-arg 0)))
           (y-or-n-p (concat "File "
                             (ad-get-arg 0)
                             " is read-only.  Open it as root? ")))
      (th-find-file-sudo (ad-get-arg 0))
    ad-do-it))

(defun th-find-file-sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/sudo::" file))))


;;; カーソル位置のURLをブラウザで開く - tototoshiの日記 http://d.hatena.ne.jp/tototoshi/20100630/1277897703
(defun browse-url-at-point ()
  (interactive)
  (let ((url-region (bounds-of-thing-at-point 'url)))
    (when url-region
      (browse-url (buffer-substring-no-properties (car url-region)
						  (cdr url-region))))))


;; jaunte
(require 'jaunte)
(global-set-key [(super j)] 'jaunte)
(set-face-foreground 'jaunte-hint-face "#fdf6e3")
(set-face-background 'jaunte-hint-face "#d33682")

;; pos-tip
(require 'pos-tip)

;; zlc
(require 'zlc)



(global-set-key [(super m)] 'ns-toggle-fullscreen)

(require 'zizo)

(setq initial-scratch-message nil)



;; gauche
(setq scheme-program-name "gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)


(setq scheme-program-name "gosh")
(require 'cmuscheme)

(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))

(define-key global-map
  "\C-cS" 'scheme-other-window)

;; 1000件覚える
(setq kill-ring-max 1000)

 (autoload 'riece "riece" "Start Riece" t)

(require 'deferred)
(require 'inertial-scroll)
(setq inertias-global-minor-mode-map 
      (inertias-define-keymap
       '(
         ("<next>"  . inertias-up)
         ("<prior>" . inertias-down)
         ("C-v"     . inertias-up)
         ("M-v"     . inertias-down)
         ("s-n"     . inertias-up)
         ("s-p"     . inertias-down)
         ) inertias-prefix-key))
(inertias-global-minor-mode 1)


(defun google (begin end &optional arg)
  (interactive "r\nP")
  (let (
        (str (buffer-substring-no-properties begin end))
        )
    (browse-url (concat "http://www.google.co.jp/search?q=" str))))


(require 'shadow)
(add-hook 'find-file-hooks 'shadow-on-find-file)

(global-auto-revert-mode 1)


(setq shadow-haunting-command-builder
      (lambda (command shadowed-command shadowed unshadowed)
        (format "(%s | %s) > %s 2> %s.err"
                shadowed-command command unshadowed unshadowed)))



(defface hlline-face '((t (:background "#fdf6ee"))) nil)
(set-face-background 'hlline-face "#fef8e5")

(setq hl-line-face 'hlline-face)
; (setq hl-line-face 'underline) ; 下線

; (global-hl-line-mode t)

(setq gc-cons-threshold 4096000)        ; 40M(default: 400K)




;; dropで開く
(define-key global-map [ns-drag-file] 'ns-find-file)


;; うっとおしかった
;; (require 'vline)
;; (require 'col-highlight)
;; (column-highlight-mode 1)


(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:popup-window-height 0.5)



;; (require 'yascroll)
;; (global-yascroll-bar-mode 1)

(require 'popup-hatena-profile-image)
(global-set-key [(super i)] 'popup-hatena-profile-image)

;; compile scroll
(setq compilation-scroll-output t)

(require 'clipboard-to-kill-ring)
(clipboard-to-kill-ring t)

(require 'suggest-restart)
(suggest-restart t)

;; kill-ring に同じ内容の文字列を複数入れない
(defadvice kill-new (before ys:no-kill-new-duplicates activate)
  (setq kill-ring (delete (ad-get-arg 0) kill-ring)))


(setq save-kill-file-name "~/Dropbox/config/kill-ring-saved.el")
(require 'savekill)


;; window分割しない
(setq pop-up-windows nil)



;; (require 'shell-command)
;; (shell-command-completion-mode)

;; (require 'shell-history)
;; (define-key shell-mode-map "\M-m" 'shell-add-to-history)


(setq max-specpdl-size 6000)


;; quickrun
;; http://d.hatena.ne.jp/syohex/20111126/1322291515
(require 'quickrun)
(push '("*quickrun*") popwin:special-display-config)

(global-set-key [(meta q)] 'quickrun)
(global-set-key [(super q)] 'quickrun-with-arg)

;; direx
(require 'direx)


(push '(direx:direx-mode :position left :width 25 :dedicated t)
      popwin:special-display-config)

(global-set-key (kbd "C-c C-j") 'direx:jump-to-directory-other-window)


(defun jump-repository-top ()
  (interactive)
  (let* (
         (repository-top-path (concat default-directory (replace-regexp-in-string "\n$" "" (shell-command-to-string "git rev-parse --show-cdup"))))
         (dot-git-path (concat repository-top-path ".git/"))
         (path (if (file-exists-p dot-git-path) repository-top-path default-directory))
         )
    (switch-to-buffer-other-window (direx:find-directory path))))


(global-set-key (kbd "C-c C-k") 'jump-repository-top)


;; --------- タイマー系 選択時にだけチェックするように -------------
;; ここでやるの見苦しいからアドバイスで処理したい

(defun auto-revert-handler ()
  "Revert current buffer, if appropriate.
This is an internal function used by Auto-Revert Mode."
  (when (and (eq (window-buffer (selected-window)) (current-buffer)) (or auto-revert-tail-mode (not (buffer-modified-p))))
    (let* ((buffer (current-buffer)) size
	   (revert
	    (or (and buffer-file-name
		     (file-readable-p buffer-file-name)
		     (if auto-revert-tail-mode
			 ;; Tramp caches the file attributes.  Setting
			 ;; `tramp-cache-inhibit' forces Tramp to
			 ;; reread the values.
			 (let ((tramp-cache-inhibit-cache t))
			   (/= auto-revert-tail-pos
			       (setq size
				     (nth 7 (file-attributes
					     buffer-file-name)))))
		       (and (not (file-remote-p buffer-file-name))
			    (not (verify-visited-file-modtime buffer)))))
		(and (or auto-revert-mode
			 global-auto-revert-non-file-buffers)
		     revert-buffer-function
		     (boundp 'buffer-stale-function)
		     (functionp buffer-stale-function)
		     (funcall buffer-stale-function t))))
	   eob eoblist)
      (when revert
	(when (and auto-revert-verbose
		   (not (eq revert 'fast)))
	  (message "Reverting buffer `%s'." (buffer-name)))
	;; If point (or a window point) is at the end of the buffer,
	;; we want to keep it at the end after reverting.  This allows
	;; to tail a file.
	(when buffer-file-name
	  (setq eob (eobp))
	  (walk-windows
	   #'(lambda (window)
	       (and (eq (window-buffer window) buffer)
		    (= (window-point window) (point-max))
		    (push window eoblist)))
	   'no-mini t))
	(if auto-revert-tail-mode
	    (auto-revert-tail-handler size)
	  ;; Bind buffer-read-only in case user has done C-x C-q,
	  ;; so as not to forget that.  This gives undesirable results
	  ;; when the file's mode changes, but that is less common.
	  (let ((buffer-read-only buffer-read-only))
	    (revert-buffer 'ignore-auto 'dont-ask 'preserve-modes)))
	(when buffer-file-name
	  (when eob (goto-char (point-max)))
	  (dolist (window eoblist)
	    (set-window-point window (point-max)))))
      ;; `preserve-modes' avoids changing the (minor) modes.  But we
      ;; do want to reset the mode for VC, so we do it manually.
      (when (or revert auto-revert-check-vc-info)
	(vc-find-file-hook)))))

(require 'flymake)
(defun flymake-on-timer-event (buffer)
  "Start a syntax check for buffer BUFFER if necessary."
  (when (and (eq (window-buffer (selected-window)) buffer) (buffer-live-p buffer))
    (with-current-buffer buffer
      (when (and (not flymake-is-running)
		 flymake-last-change-time
		 (> (- (flymake-float-time) flymake-last-change-time)
                    flymake-no-changes-timeout))

	(setq flymake-last-change-time nil)
	(flymake-log 3 "starting syntax check as more than 1 second passed since last change")
	(flymake-start-syntax-check)))))

(require 'expand-region)
(global-set-key (kbd "C-2") 'er/expand-region)
(global-set-key (kbd "C-M-2") 'er/contract-region)
(global-set-key (kbd "C-@") 'er/contract-region)


(defun my-server-detach-buffer ()
  (interactive)
  (server-buffer-done (current-buffer) t)
  (message "Detached")
  )
(global-set-key [(super z)] 'my-server-detach-buffer)


;; 直前の単語を削除
(defun kill-region-or-backward-kill-word ()
  (interactive)
  (if (region-active-p)
      (kill-region (point) (mark))
    (backward-kill-word 1)))

(global-set-key (kbd "C-w") 'kill-region-or-backward-kill-word)

;; クオートを入れ替え
(defvar swap-quotes-list
  '((?\" ?\') (?\' ?\`) (?\` ?\")))

(defun transpose-chars-or-swap-quotes (arg)
  (interactive "p")
  (or (swap-quotes) (transpose-chars arg)))

(defun swap-quotes ()
  (interactive)
  (catch 'break
    (dolist (i swap-quotes-list)
      (let ((target-char (car i))
            (replaced-char (cadr i))
            (prev-pos (point)))
        (if (= (char-after (point)) target-char)
            (save-excursion
              (forward-char 1)
              (let ((next-pos (re-search-forward (char-to-string target-char))))
                (if next-pos
                    (subst-char-in-region prev-pos next-pos target-char replaced-char)
                  (message "The corresponding quote is not found.")))
              (throw 'break t)))))
    nil))

(global-set-key (kbd "C-'") 'swap-quotes)

;; (when (require 'undohist nil t)
;;   (undohist-initialize))

(require 'foreign-regexp)

(custom-set-variables
 '(foreign-regexp/regexp-type 'perl)
 '(reb-re-syntax 'foreign-regexp))

;; (global-unset-key (kbd "M-%") 'foreign-regexp/query-replace)


(require 'edit-server)
(edit-server-start)

(require 'highlight-unique-symbol)
(highlight-unique-symbol t)

(set-face-foreground 'highlight-unique-symbol:face nil)
(set-face-background 'highlight-unique-symbol:face "#f2cdce")
