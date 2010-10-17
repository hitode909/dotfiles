;; ~/.emacs.d/site-lisp/以下をload-pathに追加
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d/site-lisp/")
           (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

;; localな設定ファイルがあるときロードする


(if (file-exists-p "~/.emacs.el.local")
    (load-file "~/.emacs.el.local"))


  (setq exec-path (cons "/usr/local/bin" exec-path))
  (setenv "PATH"
          (concat '"/usr/local/bin:" (getenv "PATH")))




