  ;; set-perl5lib
  ;; 開いたスクリプトのパスに応じて、@INCにlibを追加してくれる
  ;; 以下からダウンロードする必要あり
  ;; http://svn.coderepos.org/share/lang/elisp/set-perl5lib/set-perl5lib.el
  ;; (require 'set-perl5lib)

(require 'cperl-mode)

;; cperl-modeを適用する
(setq auto-mode-alist
      (append '(("\\.\\([pP][Llm]\\|t\\)$" . cperl-mode))  auto-mode-alist ))

;; インデントにタブを使わない
(add-hook 'cperl-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (setq cperl-close-paren-offset -4)
             (setq cperl-continued-statement-offset 4)
             (setq cperl-indent-level 4)
             (setq cperl-indent-parens-as-block t)
             (setq cperl-tab-always-indent t)
             (setq cperl-indent-parens-as-block t)

             ;; (require 'auto-complete)
             ;; (require 'perl-completion)
             ;; (add-to-list 'ac-sources 'ac-source-perl-completion)
             ;; (perl-completion-mode t)
             ))

;; perl5lib
(require 'set-perl5lib-glob-from-git-root)
;; (add-hook 'cperl-mode-hook
;;           '(lambda ()
;;              (setq indent-tabs-mode nil)
;;              (set-perl5lib-glob-from-git-root "lib")
;;              (set-perl5lib-glob-from-git-root "t/lib")
;;              (set-perl5lib-glob-from-git-root "modules/*/lib")))

(defun setup-perl5lib ()
  (interactive)
  (set-perl5lib-glob-from-git-root "lib")
  (set-perl5lib-glob-from-git-root "t/lib")
  (set-perl5lib-glob-from-git-root "modules/*/lib"))

(defun setup-perl5lib-modules ()
  (interactive)
  (set-perl5lib-glob-from-git-root "../*/lib"))


(setq-default indent-tabs-mode nil)

;; (add-hook 'cperl-mode-hook (lambda ()
;;                              (require 'perl-completion)
;;                              (perl-completion-mode t)))


;; XXX
  ;; (setenv "PERL5LIB"
  ;;         (concat '"/Users/fkd/co/Hatena-UgoMemo/lib:/Users/fkd/co/Hatena-UgoMemo/modules/cap-recipes/lib:/Users/fkd/co/Hatena-UgoMemo/modules/DBIx-MoCo/lib:/Users/fkd/co/Hatena-UgoMemo/modules/Hatedoop/lib:/Users/fkd/co/Hatena-UgoMemo/modules/Hatena-Ads/lib:/Users/fkd/co/Hatena-UgoMemo/modules/Hatena-Emoji/lib:/Users/fkd/co/Hatena-UgoMemo/modules/Hatena-Entity/lib:/Users/fkd/co/Hatena-UgoMemo/modules/Hatena-Message-Core/lib:/Users/fkd/co/Hatena-UgoMemo/modules/Hatena-Message-MailGateway/lib:/Users/fkd/co/Hatena-UgoMemo/modules/Hatena-MobileCharge/lib:/Users/fkd/co/Hatena-UgoMemo/modules/Hatena-Sanitizer/lib:/Users/fkd/co/Hatena-UgoMemo/modules/Hatena-Star-Mobile/lib:/Users/fkd/co/Hatena-UgoMemo/modules/Hatena/lib:/Users/fkd/co/Hatena-UgoMemo/modules/perl-hadoop/lib:/Users/fkd/co/Hatena-UgoMemo/modules/perl-text-jarowinkler/lib:/Users/fkd/co/Hatena-UgoMemo/modules/Ridge/lib:/Users/fkd/co/Hatena-UgoMemo/modules/Updu/lib:/Users/fkd/co/Hatena-UgoMemo/modules/WorkerManager/lib:" (getenv "PERL5LIB")))

(setenv "MODULEBUILDRC" "/Users/fkd/perl5/.modulebuildrc")
(setenv "PERL_MM_OPT" "INSTALL_BASE=/Users/fkd/perl5")
(setenv "PERL5LIB" (concat "/Users/fkd/perl5/lib:/Users/fkd/perl5/lib/perl5:/Users/fkd/perl5/lib/perl5/darwin-2level:" (getenv "PERL5LIB")))
