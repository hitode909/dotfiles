(when (require 'actionscript-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))

  (add-hook 'actionscript-mode-hook
            '(lambda ()
               (font-lock-mode 0)))
  )
