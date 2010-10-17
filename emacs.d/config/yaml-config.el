;; yaml-mode
;; http://yaml-mode.clouder.jp/
(autoload 'yaml-mode "yaml-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.yaml$" . yaml-mode)) auto-mode-alist))
