;; ruby-mode
;; http://www.ruby-lang.org/ja/
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))

(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("simplecov$" . ruby-mode))

(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)
             ))

(add-hook 'ruby-mode-hook
          (lambda()
            (require 'ruby-electric)
            (ruby-electric-mode t)
            ))
;; ruby-electric-modeにてSKKで日本語入力できるようにする。
(when nil
(add-hook 'ruby-mode-hook
          (lambda ()
            (define-key ruby-mode-map “\C-x\C-j” 'my-ruby-skk)
            (define-key ruby-mode-map “\C-xj” 'my-ruby-skk)
            (defun my-ruby-skk ()
              (interactive)
              (if (skk-mode)
                  (ruby-electric-mode t)
                (ruby-electric-mode nil)))))
)

(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

(defun ruby-insert-magic-comment-if-needed ()
  "バッファのcoding-systemをもとにmagic commentをつける。"
  (when (and (eq major-mode 'ruby-mode)
             (find-multibyte-characters (point-min) (point-max) 1))
    (save-excursion
      (goto-char 1)
      (when (looking-at "^#!")
        (forward-line 1))
      (if (re-search-forward "^#.+coding" (point-at-eol) t)
          (delete-region (point-at-bol) (point-at-eol))
        (open-line 1))
      (let* ((coding-system (symbol-name buffer-file-coding-system))
             (encoding (cond ((string-match "japanese-iso-8bit\\|euc-j" coding-system)
                              "euc-jp")
                             ((string-match "shift.jis\\|sjis\\|cp932" coding-system)
                              "shift_jis")
                             ((string-match "utf-8" coding-system)
                              "utf-8"))))
        (insert (format "# encoding: %s" encoding))))))

(add-hook 'before-save-hook 'ruby-insert-magic-comment-if-needed)

;; インデントをtermtter標準に
(setq ruby-deep-indent-paren-style nil)


(when nil
  ;; rcodetools
  (setq ri-ruby-script "/opt/local/bin/ri-emacs")
  (require 'rcodetools)
  (setq rct-find-tag-if-available nil)
  (defun make-ruby-scratch-buffer ()
    (with-current-buffer (get-buffer-create "*ruby scratch*")
      (ruby-mode)
      (current-buffer)))
  (defun ruby-scratch ()
    (interactive)
    (pop-to-buffer (make-ruby-scratch-buffer)))
  (defun ruby-mode-hook-rcodetools ()
    (define-key ruby-mode-map "\M-\C-i" 'rct-complete-symbol)
    (define-key ruby-mode-map "\C-c\C-t" 'ruby-toggle-buffer)
    (define-key ruby-mode-map "\C-c\C-d" 'xmp)
    ;(define-key ruby-mode-map "\C-c\C-f" 'rct-ri)
    )
  (add-hook 'ruby-mode-hook 'ruby-mode-hook-rcodetools)
)
;; (require 'anything-rcodetools)
;; Command to get all RI entries.
; (setq rct-get-all-methods-command "PAGER=cat fri -l")
(setq rct-get-all-methods-command "refe -l")
;; See docs
;(define-key anything-map "\C-e" 'anything-execute-persistent-action)


;;;;  flymake for ruby
(require 'flymake)
;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))
(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)


(add-hook
 'ruby-mode-hook
 '(lambda ()
    ;; Don't want flymake mode for ruby regions in rhtml files
    (if (not (null buffer-file-name)) (flymake-mode))))


(setq ruby-indent-level 4)

(require 'rvm)
(rvm-use-default)