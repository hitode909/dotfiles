;;outputz
(require 'outputz)
(setq outputz-key "XXXXXXXXX")      ;; 復活の呪文
(setq outputz-uri "http://emacs.com/%s") ;; 適当なURL。%sにmajor-modeの名前が入るので、major-modeごとのURLで投稿できます。
(global-outputz-mode t)

(defun outputz-buffers ()
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (outputz))))

(run-with-idle-timer 3 t 'outputz-buffers)
(remove-hook 'after-save-hook 'outputz)
