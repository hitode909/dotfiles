;; refe.indexへのパス
(setq anything-refe-index-file-path "~/Dropbox/data/rubyrefm/bitclust/refe.index")
;; メモ付き辞書おきば
(setq anything-refe-private-dict-path "~/Dropbox/data/rubyrefm/mydict") ;最後にスラッシュは付けない

(require 'anything)

(defvar anything-c-source-refe
      `((name . "refe")
        (candidates-file . ,anything-refe-index-file-path)
        (action ("Insert" . anything-refe-action))))

(defvar anything-c-source-create-refe-item
  '((name . "Create Item")
    (dummy)
    (action . anything-c-source-create-refe-item-action)))

(defun anything-c-source-create-refe-item-action (word)
  (find-file (concat anything-refe-private-dict-path "/" word))
  (with-temp-buffer
    (insert word)
    (let ((buf-str (concat "\n" (buffer-substring-no-properties (point-min) (point-max)))))
      (with-temp-buffer
        (insert buf-str)
        (append-to-file (point-min) (point-max) anything-refe-index-file-path)))))

(defun anything-refe-action (word)
  (if (member word (directory-files anything-refe-private-dict-path))
      (anything-refe-find-file-action word)
    (anything-refe-create-file-action word)))

(defun anything-refe-find-file-action (word)
 (find-file (concat anything-refe-private-dict-path "/" word)))

(defun anything-refe-create-file-action (word)
  (let ((file-path (concat anything-refe-private-dict-path "/" word)))
    (with-temp-buffer
      (call-process "refe" nil t t word)
      (write-region (point-min) (point-max) file-path))
    (find-file file-path)))

(defun anything-refe ()
  (interactive)
  (anything (list anything-c-source-refe anything-c-source-create-refe-item)))

;;キーバインドの設定例
(add-hook 'ruby-mode-hook
  (lambda()
    (define-key ruby-mode-map [(super r)] 'anything-refe)))