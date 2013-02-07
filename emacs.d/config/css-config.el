(add-hook 'css-mode-hook
          '(lambda ()
             (require 'rainbow-mode)
             (rainbow-mode 1)
             ))


(add-to-list 'auto-mode-alist '("\\.less$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))

