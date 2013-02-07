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

(when (require 'magit nil t)
  (require 'anything-git-grep)
  (defun anything-git-grep ()
    (interactive)
    (anything-other-buffer 'anything-c-source-git-grep "*anything find-file*"))

  (global-set-key  [(super o)] 'anything-git-grep)
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





;; http://shibayu36.hatenablog.com/#20121222135157

(defun chomp (str)
  (replace-regexp-in-string "[\n\r]+$" "" str))

(defun anything-git-project-project-dir ()
  (chomp
   (shell-command-to-string "git rev-parse --show-toplevel")))

(defun anything-c-sources-git-project-for ()
  (loop for elt in
        '(("Modified files (%s)" . "--modified")
          ("Untracked files (%s)" . "--others --exclude-standard")
          ("All controlled files in this project (%s)" . ""))
        collect
        `((name . ,(format (car elt) (anything-git-project-project-dir)))
          (init . (lambda ()
                    (unless (and ,(string= (cdr elt) "") ;update candidate buffer every time except for that of all project files
                                 (anything-candidate-buffer))
                      (with-current-buffer
                          (anything-candidate-buffer 'global)
                        (insert
                         (shell-command-to-string
                          ,(format "git ls-files --full-name $(git rev-parse --show-cdup) %s"
                                   (cdr elt))))))))
          (candidates-in-buffer)
          (display-to-real . (lambda (name)
                               (format "%s/%s"
                                       (anything-git-project-project-dir) name)))
          (type . file))))

(defun anything-git-project ()
  (interactive)
  (let* ((sources (anything-c-sources-git-project-for)))
    (anything-other-buffer sources
                           (format "*Anything git project in %s*"
                                   (anything-git-project-project-dir)))))

(global-set-key (kbd "M-p") 'anything-git-project)


(when (require 'anything nil t)
  (require 'anything-exuberant-ctags)
  (define-key global-map (kbd "C-#") 'anything-exuberant-ctags-select-from-here)
  )


;; -------------------------old -------------------------
(when nil

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

(setq anything-kill-ring-threshold 0)



;;; キーバインドの割当(好みに合わせて設定してください)
(global-set-key (kbd "C-o") 'anything-c-moccur-occur-by-moccur) ;バッファ内検索
(global-set-key (kbd "M-o") 'anything-c-moccur-buffer-list) ;moccur
(global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur) ;ディレクトリ
(add-hook 'dired-mode-hook ;dired
          '(lambda ()
             (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))


(global-set-key (kbd "C-;") 'anything)
(global-set-key (kbd "s-;") 'anything-resume)
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
;; (require 'anything-project)
  ;; drill-instructor
  ;;   (require  'drill-instructor)
  ;;   (drill-instructor t)


(defun anything-man-pages ()
  (interactive)
  (anything-other-buffer 'anything-c-source-man-pages "*anything manual*"))

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
  )



)