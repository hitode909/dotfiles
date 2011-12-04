;; cperl-modeを適用する
(setq auto-mode-alist
      (append '(("\\.\\([pP][Llm]\\|t\\)$" . cperl-mode))  auto-mode-alist ))

(defun run-perl-test ()
  "test実行します"
  (interactive)
  (compile (format "cd  %s; %s -MProject::Libs %s" (replace-regexp-in-string "\n+$" "" (shell-command-to-string "git rev-parse --show-cdup")) (expand-file-name "~/perl5/perlbrew/perls/current/bin/perl") (buffer-file-name (current-buffer)))))


(defun run-perl-method-test ()
  (interactive)
  (let (
        (command compile-command)
        (test-method nil))
    (save-excursion
      (when (or
             (re-search-backward "\\bsub\s+\\([_[:alpha:]]+\\)\s*:\s*Test" nil t)
             (re-search-forward "\\bsub\s+\\([_[:alpha:]]+\\)\s*:\s*Test" nil t))
        (setq test-method (match-string 1))))
    (if test-method
        (compile (format "cd  %s; TEST_METHOD=%s %s -MProject::Libs %s" (replace-regexp-in-string "\n+$" "" (shell-command-to-string "git rev-parse --show-cdup")) test-method (expand-file-name "~/perl5/perlbrew/perls/current/bin/perl") (buffer-file-name (current-buffer))))
        (compile (format "cd  %s; %s -MProject::Libs %s" (replace-regexp-in-string "\n+$" "" (shell-command-to-string "git rev-parse --show-cdup")) (expand-file-name "~/perl5/perlbrew/perls/current/bin/perl") (buffer-file-name (current-buffer)))))))



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

             (define-key cperl-mode-map [(super T)] 'run-perl-test)
             (define-key cperl-mode-map [(super t)] 'run-perl-method-test)
             ))

(setq-default indent-tabs-mode nil)

;; (add-hook 'cperl-mode-hook (lambda ()
;;                              (require 'perl-completion)
;;                              (perl-completion-mode t)))


(setenv "MODULEBUILDRC" "/Users/fkd/perl5/.modulebuildrc")
(setenv "PERL_MM_OPT" "INSTALL_BASE=/Users/fkd/perl5")
(setenv "PERL5LIB" (concat "/Users/fkd/perl5/lib:/Users/fkd/perl5/lib/perl5:/Users/fkd/perl5/lib/perl5/darwin-2level:" (getenv "PERL5LIB")))


