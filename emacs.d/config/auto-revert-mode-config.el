;; 勝手にrevertする
(global-auto-revert-mode t)

;; ↓こいつをnon-nilにしておくと、vcsによる変更もチェックしてくれる
(setq auto-revert-check-vc-info t)

;; こちらは変更する必要ないけど、早いほうがいいので1とかしてみた
(setq auto-revert-interval 1)

(add-hook 'find-file-hook
          '(lambda ()
             (when
                 (and buffer-file-name
                      (vc-backend buffer-file-name))
               (auto-revert-mode))))

