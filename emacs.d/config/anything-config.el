(require 'anything-startup)

(require 'anything-kyr-config)

(defun my-anything ()
  (interactive)
  (anything-other-buffer
   '(anything-c-source-ffap-line
     anything-c-source-ffap-guesser
     anything-c-source-buffers+
     anything-c-source-recentf
     anything-c-source-kyr
     anything-c-source-bookmarks
     anything-c-source-file-cache
     anything-c-source-filelist
     anything-c-source-emacs-commands
     anything-c-source-mac-spotlight
     anything-c-source-emacs-functions
     )
   "*anything file list*"))

(global-set-key (kbd "C-;") 'my-anything)
(global-set-key (kbd "s-;") 'anything-resume)

(global-set-key (kbd "C-x C-b") 'anything-buffers+)

(global-set-key (kbd "M-x") 'anything-M-x)

(global-set-key (kbd "M-y") 'anything-show-kill-ring)


(defun my-anything-command (program)
  (interactive (list
                (anything-comp-read
                 "RunProgram: "
                 (anything-c-external-commands-list-1 'sort)
;;                 :must-match t
                 :name "External Commands"
                 :history anything-external-command-history)))
  (shell-command program)
  (setq anything-external-command-history
        (cons program (delete program
                              (loop for i in anything-external-command-history
                                    when (executable-find i) collect i))))
  )

  ;; 動かない，残念
  ;; (deferred:$
  ;;   (deferred:process (car (split-string program " ")) (apply (function concat) '(cdr (split-string program " +"))))
  ;;   (deferred:nextc it
  ;;     (lambda (res)
  ;;       (let ((image-buf (get-buffer-create "*image*")))
  ;;         (with-current-buffer image-buf
  ;;           (erase-buffer)
  ;;           (insert res))
  ;;         (popwin:popup-buffer image-buf :noselect t)))))

(global-set-key (kbd "M-1") 'my-anything-command)

;; ;; anything-project
;; (require 'anything-project)
;; (global-set-key (kbd "M-p") 'anything-project)

;;; anything-c-moccur
(require 'anything-c-moccur)
(setq anything-c-moccur-anything-idle-delay 0.1 ;`anything-idle-delay'
      anything-c-moccur-higligt-info-line-flag t ; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
      anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
      anything-c-moccur-enable-initial-pattern t
      anything-c-moccur-enable-auto-look-flag t ; 選択中の候補を他のバッファにリアルタイムに表示する
      ) ; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする
(global-set-key (kbd "C-o") 'anything-c-moccur-occur-by-moccur) ;バッファ内検索
(global-set-key (kbd "M-o") 'anything-c-moccur-buffer-list) ;moccur
(global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur) ;ディレクトリ

(global-set-key (kbd "M-i") 'anything-imenu)
(require 'anything-dabbrev-expand)
(global-set-key "\M-/" 'anything-dabbrev-expand)
(define-key anything-dabbrev-map "\M-/" 'anything-dabbrev-find-all-buffers)
(setq dabbrev-case-fold-search nil)  ;; dabbrev時に、大文字・小文字を区別しない。

(defun anything-find-etags ()
  (interactive)
  (anything-other-buffer 'anything-c-source-etags-select "*anything etags*"))

(global-set-key  [(super a)] 'anything-find-etags)

(when (eq system-type 'darwin)
  (require 'anything-mac-itunes)
  (global-set-key (kbd "C-c m") 'anything-mac-itunes)
  (global-set-key (kbd "C-c b") 'anything-mac-itunes-back-track)
  (global-set-key (kbd "C-c n") 'anything-mac-itunes-next-track)
  (global-set-key (kbd "C-c p") 'anything-mac-itunes-playpause-track)
  (global-set-key (kbd "C-c c") 'anything-mac-itunes-show-current-track-info)
  )

(when (require 'popwin nil t)
  (setq anything-samewindow nil)
  (push '("anything" :regexp t :height 0.5) popwin:special-display-config)
  (push '("*magit-edit-log*" :height 0.5) popwin:special-display-config)
  (push '("*Backtrace*" :noselect t :height 0.5) popwin:special-display-config)
  (push '("*undo-tree*" :height 0.5) popwin:special-display-config)
  (push '("*Shell Command Output*" :noselect t :height 0.5) popwin:special-display-config)
  )

;; https://gist.github.com/1026506
(anything-c-arrange-type-attribute 'buffer
  '((candidate-transformer REST
                           anything-c-highlight-buffers)
    (display-to-real anything-my-get-buffer REST)))
(defun anything-my-get-buffer (buffer-or-filename)
  (if (bufferp buffer-or-filename)
      buffer-or-filename
    (get-file-buffer buffer-or-filename)))
;; override anything-config.el
(defun anything-c-highlight-buffers (buffers)
  (require 'dired)
  (loop for i in buffers
        if (rassoc (get-buffer i) dired-buffers)
        collect (propertize i
                            'face anything-c-buffers-face1
                            'help-echo (car (rassoc (get-buffer i) dired-buffers)))
        if (buffer-file-name (get-buffer i))
        collect (propertize (buffer-file-name (get-buffer i))
                            'face anything-c-buffers-face2
                            'help-echo (buffer-file-name (get-buffer i)))
        if (and (not (rassoc (get-buffer i) dired-buffers))
                (not (buffer-file-name (get-buffer i))))
        collect (propertize i
                            'face anything-c-buffers-face3)))

(defun anything-google ()
  (interactive)
  (anything-other-buffer 'anything-c-source-google-suggest "*anything google-suggest*"))

  (global-set-key  [(super G)] 'anything-google)


;; faces
(set-face-inherit 'anything-match 'isearch nil)
(set-face-inherit 'anything-isearch-match 'isearch nil)

(global-set-key (kbd "C-:") 'anything-filelist+)
(setq anything-c-filelist-file-name "/tmp/all.filelist")

(require 'anything-git-files)
(global-set-key (kbd "M-p") 'anything-git-files)
