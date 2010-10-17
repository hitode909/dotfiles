(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode))  auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq dvi2-command "open -a Preview"
      tex-command "~/Library/TeXShop/bin/platex2pdf-utf8"
      YaTeX-kanji-code 4)
(add-hook 'yatex-mode-hook'(lambda ()(setq auto-fill-function nil)))

(when nil
  ;;カーソル位置にverb出す
  (defun my-insert-verb()
    (interactive)
    (insert "\\verb||")
    (backward-char)
    )
  ;(global-set-key "\C-c\C-v" 'my-insert-verb)
  ;;カーソル位置にref出す
  (defun my-insert-ref()
    (interactive)
    (insert "\\ref{}")
    (backward-char)
    )
  ;(global-set-key "\C-c\C-r" 'my-insert-ref)
  ;;カーソル位置にoverline出す
  (defun my-insert-bar()
    (interactive)
    (insert "\\bar{}")
    (backward-char)
    )
  ;(global-set-key "\C-c\C-b" 'my-insert-bar)
)

