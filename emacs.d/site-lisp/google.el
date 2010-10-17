(require 'browse-url)
(require 'thingatpt)
;; w3m-url-encode-string の rename 版 (w3m.el を入れてないから)
(defun my-url-encode-string (str &optional coding)
  (apply (function concat)
         (mapcar
          (lambda (ch)
            (cond
             ((eq ch ?\n)               ; newline
              "%0D%0A")
             ((string-match "[-a-zA-Z0-9_:/]" (char-to-string ch)) ; xxx?
              (char-to-string ch))      ; printable
             ((char-equal ch ?\x20)     ; space
              "+")
             (t
              (format "%%%02X" ch))))   ; escape
          ;; Coerce a string to a list of chars.
          (append (encode-coding-string (or str "") (or coding 'iso-2022-jp))
                  nil))))

;; google で検索。引数無しだと mini-buffer で編集できる。
(defun google (str &optional flag)
  "google で検索。引数無しだと mini-buffer で編集できる。"
  (interactive
   (list (cond ((or
                 ;; mouse drag の後で呼び出された場合
                 (eq last-command 'mouse-drag-region) ; for emacs
                 (and (eq last-command 'mouse-track) ; for xemacs
                      (boundp 'primary-selection-extent)
                      primary-selection-extent)
                 ;; region が活性
                 (and (boundp 'transient-mark-mode) transient-mark-mode
                      (boundp 'mark-active) mark-active) ; for emacs
                 (and (fboundp 'region-active-p)
                      (region-active-p)) ; for xemacs
                 ;; point と mark を入れ替えた後
                 (eq last-command 'exchange-point-and-mark))
                (buffer-substring-no-properties
                 (region-beginning) (region-end)))
               (t (thing-at-point 'word)))
         current-prefix-arg))
  (if flag
      nil
    (setq str (read-from-minibuffer "Search word: " str)))
  (browse-url
   (concat
    "http://www.google.com/search?q="
    (my-url-encode-string str 'shift_jis)
    "&hl=ja&ie=Shift_JIS&lr=lang_ja")))