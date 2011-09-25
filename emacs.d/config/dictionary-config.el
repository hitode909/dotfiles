;; Dictionary.app を Emacs から引いてファイルに書き出す
;; (+ "http://d.hatena.ne.jp/a666666/20100529/1275138722"
;;    "http://sakito.jp/mac/dictionary.html"
;;    "http://d.hatena.ne.jp/tomoya/20091218/1261138091"
;;    "http://d.hatena.ne.jp/tomoya/20100103/1262482873")

;; (defvar dict-bin "~/bin/dict.py"
;;   "dict 実行ファイルのパス")
(defvar dict-bin "~/bin/dict"
  "dict 実行ファイルのパス")



;; (defvar dict-log-file "~/Dropbox/memo/english.txt"
;;   "dict ログを書き出すファイル")

;; (defun my-dictionary ()
;;   (interactive)
;;   (let ((pt (save-excursion (mouse-set-point last-nonmenu-event)))
;;         (old-buf (current-buffer))
;;         (dict-buf (get-buffer-create "*dictionary.app*"))
;;         (log-buf (find-file-noselect dict-log-file))
;;         beg end)
;;     (if (and mark-active
;;              (<= (region-beginning) pt) (<= pt (region-end)))
;;         (setq beg (region-beginning)
;;               end (region-end))
;;       (save-excursion
;;         (goto-char pt)
;;         (setq end (progn (forward-word) (point)))
;;         (setq beg (progn (backward-word) (point)))
;;         ))
;;     (setq word (buffer-substring-no-properties beg end))
;;     (set-buffer dict-buf)
;;     (erase-buffer)
;;     (call-process dict-bin
;;                   nil "*dictionary.app*" t word
;;                   "Japanese-English" "Japanese" "Japanese Synonyms")
;;     (setq dict (buffer-string))
;;     (set-buffer log-buf)
;;     (goto-char (point-max))
;;     (insert (concat (current-time-string) "\n" word "\n"))
;;     (insert-buffer dict-buf)
;;     (save-current-buffer)
;;     (set-buffer old-buf)
;;     (when (not (eq (length dict) 0))
;;       (popup-tip dict :margin t :scroll-bar t) t)
;;     ))

(defun my-dictionary ()
  (interactive)
  (lexical-let ((current-word (thing-at-point 'word)))
    (when current-word
        (deferred:$
          (deferred:process dict-bin current-word)
          (deferred:nextc it
            (lambda (res) (popup-tip (concat current-word "\n" res))))))))

;(defvar dict-timer nil)
;(defvar dict-delay 1.0)
;(defun dict-timer ()
;  (when (and (not (minibufferp))
;             (and mark-active transient-mark-mode))
;    (ns-popup-dictionary)))
;(setq dict-timer (run-with-idle-timer dict-delay dict-delay 'dict-timer))
(global-set-key [(super d)] 'my-dictionary)
