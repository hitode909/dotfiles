  ;; migemo
  (load "migemo.el")
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs" "-i" "¥a"))
  (setq migemo-dictionary "/Users/hitode909/homebrew/share/migemo/euc-jp/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)

  ;; 複数の検索語や、特定のフェイスのみマッチ等の機能を有効にする
  ;; 詳細は http://www.bookshelf.jp/soft/meadow_50.html#SEC751
  (require 'color-moccur)
  (setq dmoccur-exclusion-mask
        (append '("\\~$" "\\.svn\\/\*" "\\.git\\/\*" "\\.pdf$") dmoccur-exclusion-mask))
  (setq moccur-split-word t)
  ;; migemoがrequireできる環境ならmigemoを使う
  (when (require 'migemo nil t) ;第三引数がnon-nilだとloadできなかった場合にエラーではなくnilを返す
    (setq moccur-use-migemo t))
