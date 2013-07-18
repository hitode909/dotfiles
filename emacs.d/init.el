(load-file "~/.emacs.d/config/load-path-config.el")
(load-file "~/.emacs.d/config/utils.el")

(load-file "~/.emacs.d/config/basic-config.el")
(load-file "~/.emacs.d/config/zencoding-mode-config.el")

(load-file "~/.emacs.d/config/migemo-config.el")
(load-file "~/.emacs.d/config/auto-complete-config.el")
(load-file "~/.emacs.d/config/skk-config.el")
(load-file "~/.emacs.d/config/server-config.el")
(load-file "~/.emacs.d/config/window-config.el")
(load-file "~/.emacs.d/config/anything-config.el")
(load-file "~/.emacs.d/config/yasnippet-config.el")
;; (load-file "~/.emacs.d/config/auto-revert-mode-config.el")
(load-file "~/.emacs.d/config/carbon-config.el")
(load-file "~/.emacs.d/config/perl-config.el")
(load-file "~/.emacs.d/config/html-config.el")
(load-file "~/.emacs.d/config/css-config.el")
(load-file "~/.emacs.d/config/flymake-config.el") ;; XXXXXXXX
;; (load-file "~/.emacs.d/site-lisp/flymake-growl.el")
(load-file "~/.emacs.d/config/js-config.el")
(load-file "~/.emacs.d/config/as-config.el")
;; (load-file "~/.emacs.d/config/outputz-config.el")
(load-file "~/.emacs.d/config/ruby-config.el")
(load-file "~/.emacs.d/config/ruby-refe-config.el")
(load-file "~/.emacs.d/config/shell-config.el")
(load-file "~/.emacs.d/config/smartchr-config.el")
(load-file "~/.emacs.d/config/tex-config.el")
(load-file "~/.emacs.d/config/yaml-config.el")
;; (load-file "~/.emacs.d/config/rsense-config.el")
(load-file "~/.emacs.d/config/auto-save-buffers-config.el")
(load-file "~/.emacs.d/config/dictionary-config.el")
(load-file "~/.emacs.d/config/git-config.el")


(message "hi")
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(desktop-load-locked-desktop t)
 '(desktop-path (quote ("~/.emacs.d/")))
 '(desktop-save t)
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ja")
 '(magit-default-tracking-name-function (quote magit-default-tracking-name-branch-only)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow")))))
