;; popup-hatena-profile-image.el
;; カーソル位置のはてなユーザーのプロフィール画像をポップアップで表示します．
;; idコールする前に，idが合ってるか確認するのに使えます．

(require 'cl)
(require 'url)
(require 'deferred)
(require 'popwin)

(defun popup-hatena-profile-image ()
  (interactive)
  (lexical-let ((current-word (thing-at-point 'symbol)))
    (when current-word
      (deferred:$
        (deferred:url-retrieve (format "http://www.st-hatena.com/users/%s/%s/profile.gif" (substring current-word 0 2) current-word))
        (deferred:nextc it
          (lambda (buf)
            (let ((image-buf (get-buffer-create "*image*")))
              (progn
                (with-current-buffer image-buf
                  (erase-buffer)
                  (insert-string (concat current-word "\n"))
                  (insert-image
                   (create-image
                    (let ((data (with-current-buffer buf (buffer-string))))
                      (substring data (+ (string-match "\n\n" data) 2)))
                    'gif t)))
                (popwin:popup-buffer image-buf)
                (kill-buffer buf)
                ))))))))

(provide 'popup-hatena-profile-image)