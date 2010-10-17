;; find-file for anything
;;   $Rev: 64 $
;;
;; usage: (add-to-list 'anything-sources nym:anything-find-file)
;;
;; 概要:
;; some/where/file/name を s/w/f/n のようなパタンで検索する
;;
;; 注意事項:
;;   * パタンのディレクトリ部は，それぞれ最初にマッチするディレクトリ
;;     が採用される．
;;   * パタンの規則がちょっと変態的．
;;     * nym:anything-pattern-transformer
;;     * nym:anything-split-string
;;     * nym:anything-pattern-transformer-hut
;;
;; 制限事項:
;;   * ホームディレクトリのチルダ展開は完全一致のみ対応
;; TODO:
;;   * 整理
;;   * action:
;;     * view
;; DONE:
;;   * パタンマスク
;;     * "#" とか "~" とか要らん
;;   * 先頭一致

(require 'nym-anything-tools)

(defvar nym:anything-find-file-ignore-patterns
  (list 
   (concat "^" (regexp-opt  '(".svn" "CVS") t) "$")
   "^[.]?#" "~$")
  "候補から除外するファイル名のパターンリスト")

(defun nym:anything-find-file-directory (path)
  "path のファイルリストを構築する

ディレクトリはリスト，それ以外は文字列で表現される．

; ((\"dir_a\") \"file_a\" ...)
"
  (let ((entries nil)
        (directories (condition-case nil
                         (directory-files path)
                       (file-error nil)))
        )
    (dolist (elm directories)
      (condition-case nil
          (or (assoc-default elm nym:anything-find-file-ignore-patterns
                             'string-match t)
              (cond ((file-directory-p (concat path elm))
                     (push (list elm) entries))
                    (t
                     (push elm entries))))
        (file-error nil)))
    (nreverse entries)))

(defun nym:anything-find-file-search (patterns files &optional allowfile multi)
  "files から patterns にマッチする最初の要素を返す

allowfile が nil であれば，ファイルは対象としない．
multi が non-nil であれば，マッチする要素のリストを返す．
"
  (condition-case nil
      (loop for entry in files
            with name
            if (or allowfile (consp entry))
            do (setq name (or (car-safe entry) entry))
            and if (nym:anything-pattern-match patterns name)
            if multi collect entry
            else return entry)
    (invalid-regexp nil)
    (file-error nil)))

(defun nym:anything-find-file-resolve-pattern (patterns path cache)
  "キャッシュの検索と構築"
  ;; ちょっと大袈裟だけど気にしない．やってみたかっただけ．
  (let* ((entries
         (or
          ;; entries がある場合
          (assq 'entries cache)
          ;; entries がない場合 -> 構築
          (car (push (cons 'entries
                           (nym:anything-find-file-directory path))
                     (cdr cache)))))
        (alias (or (assoc 'alias cache)
                   (car (push (cons 'alias nil)
                              (cdr cache))))))
    (cond
     ;; 未解決パタンが残っている場合
     (patterns                          
      (let* ((ptn (car patterns))
             (newcache (cdr (assoc ptn alias))))
        (cond (newcache)
              (t                        ;キャッシュなし
               (setq newcache (nym:anything-find-file-search
                               (nym:anything-pattern-transformer ptn)
                               (cdr entries)))
               (when newcache
                 (push (cons ptn newcache) (cdr alias)))))
        (and newcache
             (nym:anything-find-file-resolve-pattern
              (cdr patterns) (concat path (car newcache) "/") newcache))))
     ;; すべてのパタン解決済み
     (t
      (list path (cdr entries))))))

(defun nym:anything-find-file (candidates source)
  (let* ((patterns (split-string anything-pattern "/"))
         (fileptn
          (let ((rptns (nreverse patterns)))
            (prog1 (pop rptns) (setq patterns (nreverse rptns)))))
          ;;(prog2 (nreverse patterns) (pop patterns) (nreverse patterns)))
         (basepath
          (cond
           ;; 絶対パス
           ((and (car patterns)
                 (= (length (car patterns)) 0))
            (pop patterns)
            "/")
           ;; ホーム
           ((string-match "^~" anything-pattern)
            (concat (or (pop patterns)
                        (prog1 (car (push fileptn patterns))
                          (setq fileptn "")))
                    "/"))
           (t nym:anything-find-file-base-directory)))
         (cache (nym:anything-find-file-resolve-pattern
                 patterns
                 basepath
                 (or (assoc basepath nym:anything-find-file-cache)
                     (car
                      (push (list basepath) nym:anything-find-file-cache)))))
         (path (car cache))
         (entries (cadr cache)))
    ;; タイトル設定
    (setcdr
     (assq 'name source)
     (concat
      "Find File : "
      (expand-file-name (or path nym:anything-find-file-base-directory))))
    (mapcar
     (lambda (entry)
       (cons (if (consp entry) (concat (car entry) "/") entry)
             (concat path (if (consp entry) (concat (car entry) "/") entry))))
     (nym:anything-find-file-search
      (nym:anything-pattern-transformer fileptn)
      entries t t)
     )))

(setq
 nym:anything-find-file
 '((name . "Find File")
   (init . (lambda ()
             (setq nym:anything-find-file-base-directory
                   default-directory
                   nym:anything-find-file-cache
                   nil
                   )))
   (candidates . nil)
   (filtered-candidate-transformer . nym:anything-find-file)
   (volatile)
   (type . file)))
