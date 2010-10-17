(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/etc/yasnippet-0.6.1c/snippets/")
(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt))

;;; [2008-03-15]
;;; 複数のディレクトリからスニペットを読み込む。

;; yasnippetのsnippetを置いてあるディレクトリ
(setq yas/root-directory (expand-file-name "~/.emacs.d/etc/yasnippet-0.6.1c/snippets/"))

;; 自分用スニペットディレクトリ(リストで複数指定可)
(defvar my-snippet-directories
  (list (expand-file-name "~/.emacs.d/etc/yasnippet-coderepos/snippets")  ; CodeRepos
        ))

;; yasnippet公式提供のものと、自分用カスタマイズスニペットをロード同名
;; のスニペットが複数ある場合、あとから読みこんだ自分用のものが優先され
;; る。また、スニペットを変更、追加した場合、このコマンドを実行すること
;; で、変更・追加が反映される。

(defun yas/load-all-directories ()
  (interactive)
  (yas/reload-all)
  (mapc 'yas/load-directory-1 my-snippet-directories))

(yas/load-all-directories)
