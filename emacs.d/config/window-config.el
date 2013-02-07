(when window-system
  ;; スクロールバーを隠す
  (scroll-bar-mode -1)
  ;; ツールバーを隠す
  (tool-bar-mode 0)
  ;; 左右の余白消す
  (fringe-mode 0)

  ;;(when (=  emacs-major-version 22)
  ;; (require 'elscreen-color-theme)
  (setq elscreen-tab-display-kill-screen nil)
  (setq elscreen-display-screen-number nil)
  (setq elscreen-tab-display-control nil)
  (load "elscreen" "ElScreen" t)
  (require 'elscreen-server)
  (set-face-background  'elscreen-tab-background-face "#fdf6e3")
  (set-face-background  'elscreen-tab-other-screen-face "#fdf6e3")
  (set-face-foreground  'elscreen-tab-other-screen-face "#586e75")
  (set-face-underline-p 'elscreen-tab-other-screen-face nil)
  (set-face-background  'elscreen-tab-current-screen-face "#fdf6e3")
  (set-face-foreground  'elscreen-tab-current-screen-face "#d33682")
  (set-face-underline-p 'elscreen-tab-current-screen-face nil)
  (set-face-bold-p      'elscreen-tab-current-screen-face t)

  (set-face-background 'ac-candidate-face "#eee8d5")
  (set-face-foreground 'ac-candidate-face "#657b83")
  (set-face-background 'ac-selection-face "#657b83")
  (set-face-foreground 'ac-selection-face "#fdf6e3")
  ;;)

  (when (= emacs-major-version 23)
    (set-face-attribute 'default nil
                        :family "Monaco"
                        :height 120)
    (set-fontset-font "fontset-default"
                      'japanese-jisx0208
                      '("Osaka" . "iso10646-1"))
    (set-fontset-font "fontset-default"
                      'katakana-jisx0201
                      '("Osaka" . "iso10646-1"))
    (setq face-font-rescale-alist
          '((".*Monaco-bold.*" . 1.0)
            (".*Monaco-medium.*" . 1.0)
            (".*Osaka-bold.*" . 1.2)
            (".*Osaka-medium.*" . 1.2)
            ("-cdac$" . 1.4)))
    )

  )