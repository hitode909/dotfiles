;; ~/.emacs.d/site-lisp/以下をload-pathに追加
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d/site-lisp/")
           (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

;; ~/.emacs.d/site-lisp/以下をload-pathに追加
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d/auto-install/")
           (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

;; Dropboxにプライベートな設定を置いとける
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/Dropbox/dotfiles/emacs.d/site-lisp/")
           (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

(if (file-exists-p "~/Dropbox/dotfiles/emacs.d/private_init.el")
    (load-file "~/Dropbox/dotfiles/emacs.d/private_init.el"))

;; localな設定ファイルがあるときロードする


(if (file-exists-p "~/.emacs.el.local")
    (load-file "~/.emacs.el.local"))





(setenv "XDG_DATA_HOME" "/usr/local/Cellar/shared-mime-info/0.70/share")
(setenv "XDG_DIRS" "/usr/local/Cellar/shared-mime-info/0.70/share")

(setenv "DYLD_LIBRARY_PATH" "/usr/local/mysql/lib")

(setenv "PATH" (concat '"/usr/local/bin:" (getenv "PATH")))
(setq exec-path (cons "/usr/local/bin" exec-path))

(setenv "PATH" (concat '"/usr/local/share/npm/bin:" (getenv "PATH")))
(setq exec-path (cons "/usr/local/share/npm/bin" exec-path))

(setenv "PATH" (concat '"/Users/hitode909/homebrew/bin:" (getenv "PATH")))
(setq exec-path (cons "/Users/hitode909/homebrew/bin" exec-path))

(setenv "PATH" (concat '"/Users/hitode909/bin:" (getenv "PATH")))
(setq exec-path (cons "/Users/hitode909/bin" exec-path))

(setenv "PATH" (concat '"/Users/hitode909/perl5/perlbrew/bin:" (getenv "PATH")))
(setq exec-path (cons "/Users/hitode909/perl5/perlbrew/bin" exec-path))

(setenv "PATH" (concat '"/Users/hitode909/perl5/perlbrew/perls/current/bin:" (getenv "PATH")))
(setq exec-path (cons "/Users/hitode909/perl5/perlbrew/perls/current/bin" exec-path))


(setenv "LANG" "en_US.UTF-8")

