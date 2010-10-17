;;;;
;;;; nym-anything-tools
;;;;  $Rev: 66 $
;;;;

(defun nym:anything-split-string (string delimiter &optional omit-nulls)
  "STRING を DELIMITER で分割する．

DELIMITER 自体を含めたい場合は，2度繰り返す．

ex.
\"hoge fuga\" => (\"hoge\" \"fuga\")
\"hoge  fuga\" => (\"hoge fuga\")
"
  ;; 煩雑になってしまったので loop を止めた方が良いかも...
   (loop with pos = 0
         with temp = nil
         with elements = nil

         while (string-match delimiter string pos)

         if (condition-case nil
                (equal (substring
                        string (match-beginning 0) (match-end 0))
                       (substring
                        string
                        (match-end 0) (+ (match-end 0)
                                         (- (match-end 0)
                                            (match-beginning 0)))))
              ('args-out-of-range nil))
         do
         (setq temp (concat temp
                            (substring string pos (match-end 0)))
               pos (+ (match-end 0)
                      (- (match-end 0) (match-beginning 0))))
         else
         unless (and omit-nulls (not temp) (= pos
                                              (match-beginning 0)))
         collect (concat temp
                         (substring string pos (match-beginning 0)))
         into elements
         end
         and do (setq pos (match-end 0)
                      temp nil)
        
         finally
         (if (and omit-nulls (not temp) (= pos (length string)))
             (return elements)
           (return (append elements
                           (list (concat temp (substring string pos))))))
         ))

(defun nym:anything-pattern-transformer-hut (pattern)
  "エスケープされていない最初の `^' を先頭に移動する．

元の位置に `^' を残したい場合は `^^' を指定する．
"
  (loop with pos = 0
        while (string-match
               "\\(^\\|[^\\\\]\\)\\(\\\\\\\\\\)*\\(\\^\\(\\^\\)?\\)"
               pattern pos)
        if (match-beginning 4)
        do
        (setq
         pos (1- (match-end 0))
         pattern (replace-match "" nil nil pattern 4))
        else
        do
        (setq pattern (concat "^" (replace-match "" nil nil pattern 3)))
        (return))
  pattern)

(defun nym:anything-pattern-transformer (pattern)
  (mapcar
   (lambda (ptn)
     (nym:anything-pattern-transformer-hut ptn))
   (nym:anything-split-string pattern " \\|\t" t)))

(defun nym:anything-pattern-match (patterns string)
  (if (not patterns) t
    ;; 文字列だったらリストに変換
    (if (stringp patterns) (setq patterns (nym:anything-pattern-transformer patterns)))
    (condition-case nil
        (let ((pos))
          (and
           ;; 1パタン目は通常のマッチ
           (and (string-match (pop patterns) string pos)
                (setq pos (match-end 0)))
           ;; 2パタン目以降は，先頭の "^" を特殊扱い
           (loop for ptn in patterns
                 if (eq ?^ (aref ptn 0))
                 do (progn
                      (setq pos 0)
                      (setq ptn (substring ptn 1)))
                 always (and (string-match ptn string pos)
                             (setq pos (match-end 0))))))
      (invalid-regexp nil)
      )))

(defvar nym:anything-match-pattern-cache nil)
(defun nym:anything-match (candidate)
  "anything でデフォルトの match の代替品"
  (unless (equal (car nym:anything-match-pattern-cache) anything-pattern)
    (setq nym:anything-match-pattern-cache
          (cons anything-pattern
                (nym:anything-pattern-transformer anything-pattern))))
  (nym:anything-pattern-match (cdr nym:anything-match-pattern-cache)
                              candidate))

(provide 'nym-anything-tools)
