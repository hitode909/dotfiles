(when (require 'skk-autoloads nil t)
  ;;; skk用の設定
  
  (setq default-input-method "japanese-skk")
  ;;(require 'skk-autoloads)
  (global-set-key "\C-j" 'skk-mode)
  (global-set-key "\C-x\C-j" 'skk-mode)

  ;; 辞書ファイルから読む
  ;;  (setq skk-large-jisyo "~/.emacs.d/etc/skk/SKK-JISYO.L")
  ;; 辞書サーバー
  (setq skk-server-host "localhost")
  (setq skk-server-portnum 1178)
  (setq skk-jisyo-code 'utf-8-unix)

  ;; isearch時にSKKをオフ
  (setq skk-isearch-start-mode 'latin)
  ;; 勝手に括弧閉じる
  (setq-default skk-auto-insert-paren t)
  ;; 送り仮名の何か
  (setq-default skk-process-okuri-early t)
  ;; 自動的に確定する
  (setq-default skk-kakutei-when-unique-candidate t)
  ;; デフォルトで，と．を出す
  (setq-default skk-kutouten-type 'en)
  ;; lookup
  (setq-default skk-use-look  t)
  (setq-default skk-look-use-ispell  t)

  ;; 変換候補インライン
  ;; (setq skk-show-inline t)

  ;; 日本語補完
  ;; (setq skk-dcomp-activate t)

  ;; 変換候補インライン
  ;; (setq skk-show-inline t)

  (setq skk-show-candidates-always-pop-to-buffer t) ; 変換候補の表示位置
  (setq skk-henkan-show-candidates-rows 2) ; 候補表示件数を2列に
  (setq skk-dcomp-multiple-activate nil)
  (setq skk-dcomp-activate nil) ; 動的補完
  (setq skk-dcomp-multiple-activate t) ; 動的補完の複数候補表示
  (setq skk-dcomp-multiple-rows 10) ; 動的補完の候補表示件数
  (setq skk-show-annotation t)  ; Annotation
  (setq skk-annotation-show-wikipedia-url t) ; Annotation で Wikipedia を
)