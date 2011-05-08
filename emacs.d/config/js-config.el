(when nil
  ;;js2-mode
  (setq-default c-basic-offset 4)
  (autoload 'js2-mode "js2" nil t)
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
  (add-hook 'js2-mode-hook
            '(lambda ()
               (setq js2-cleanup-whitespace nil
                     js2-mirror-mode nil
                     js2-bounce-indent-flag t)

               (defun indent-and-back-to-indentation ()
                 (interactive)
                 (indent-for-tab-command)
                 (let ((point-of-indentation
                        (save-excursion
                          (back-to-indentation)
                          (point))))
                   (skip-chars-forward "\s " point-of-indentation)))
               (define-key js2-mode-map "\C-i" 'indent-and-back-to-indentation)
               (define-key js2-mode-map "\C-m" nil)
               (define-key js2-mode-map "\C-cm" 'next-error)
               ))

  )

(when nil
  ;; espesso-mode
  ;; http://www.nongnu.org/espresso/
  (autoload 'espresso-mode "espresso" "Start espresso-mode" t)
  (add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
  (add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))
  )

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook
          '(lambda ()
               (define-key js2-mode-map "\C-m" nil)
               (define-key js2-mode-map "\C-cm" 'next-error)
               ))

;;moz-plus
(autoload 'run-mozilla "moz" "run inferior moz" t)
(add-hook 'inferior-moz-mode-hook (lambda ()
                                    (require 'moz-plus)
                                    (moz-plus 1)
                                    ))


(when nil
  (require 'actionscript-mode)
  (setq auto-mode-alist
        (append '(("\\.as$" . actionscript-mode))
                auto-mode-alist))
  )


(require 'coffee-mode)
(defun coffee-custom ()
  "coffee-mode-hook"
 (set (make-local-variable 'tab-width) 2)
 (setq coffee-cleanup-whitespace nil)
 (define-key coffee-mode-map [(meta R)] 'coffee-compile-region)
 )

(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

(add-to-list 'auto-mode-alist '("\\.js.shd$" . coffee-mode))
