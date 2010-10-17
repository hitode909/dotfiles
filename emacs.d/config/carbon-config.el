(when (featurep 'carbon-emacs-package)
  (setq grep-find-use-xargs 'bsd)

  (require 'carbon-font)

  (defun font-size(size)
    (fixed-width-set-fontset "osaka" size))

  (defun font-very-small()
    (interactive)
    (font-size 7))

  (defun font-small()
    (interactive)
    (font-size 10))

  (defun font-normal()
    (interactive)
    (font-size 12))

  (defun font-big()
    (interactive)
    (font-size 18))

    (defun font-very-big()
    (interactive)
    (font-size 24))

  ;; フルスクリーン化
  ;; (mac-toggle-max-window)
  ;; フルスクリーン時にメニューバーを表示する
  ;;(setq mac-autohide-menubar-on-maximize nil)
  ;; OSXの日本語入力メソッドを有効にする
  ;; (setq default-input-method "MacOSX")
  ;; optionキーをMetaキーとして利用
  (setq mac-option-modifier 'meta)
  (setq mac-command-key-is-meta t)
  (setq mac-command-modifier-meta t)
  (setq grep-find-use-xargs 'bsd)

  ;; fullscreenのときメニューバー隠す
  (setq mac-autohide-menubar-on-maximize t)

  ;;コメントアウトすると起動時に最大化とかする
  (add-hook 'window-setup-hook
            (lambda ()
              (progn
                ;; (set-frame-parameter nil 'alpha 100)
                ;; (set-frame-parameter nil 'fullscreen  nil)
                ;; (set-frame-parameter nil 'fullscreen 'fullboth)
                ;; (set-frame-parameter nil 'fullscreen 'fullwidth)
                ;; (set-frame-parameter nil 'fullscreen 'fullheight)
                )
              ))

  ;; toggle
  (defun my-toggle-frame-size ()
    (interactive)
    (if (frame-parameter nil 'fullscreen)
        (set-frame-parameter nil 'fullscreen nil)
      (set-frame-parameter nil 'fullscreen 'fullboth)
      (message "Full-screen changed")
      ))
  (global-set-key "\C-cm" 'my-toggle-frame-size)

  ;;; コントロールキーをシステムに取られないようにする
  (setq mac-pass-control-to-system nil)
  (setq mac-pass-command-to-system nil)
  (setq mac-pass-option-to-system nil)
)