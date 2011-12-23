;; suggest-restart.el

;; Emacsのメモリ使用量をチェックして，上限を越えていたら再起動をおすすめする
;; デフォルト設定では閾値は500MBを越えているかを，60秒ごとにチェック
;; 変えたければsuggest-restart:threshold，suggest-restart:intervalを変える
;; (suggest-restart t) で開始

(require 'deferred)

(defvar suggest-restart:threshold 500000)

(defvar suggest-restart:interval 60)
(defvar suggest-restart:timer nil)

(defun suggest-restart:observe ()
  (deferred:$
    (deferred:process "ps" "-p" (format "%d" (emacs-pid)) "-o" "rss")
    (deferred:nextc it
      (lambda (res)
        (when (> (string-to-number (car (cdr (split-string res "\n")))) suggest-restart:threshold)
          (message "そろそろ再起動しましょう"))
        ))))

(defun suggest-restart (enable)
  (if (and enable suggest-restart:timer)
      (suggest-restart nil))
  (if enable
      (setq suggest-restart:timer (run-with-timer
                                   suggest-restart:interval
                                   suggest-restart:interval
                                   'suggest-restart:observe))
    (when suggest-restart:timer
      (cancel-timer suggest-restart:timer)
      (setq suggest-restart:timer nil))))

(provide 'suggest-restart)
