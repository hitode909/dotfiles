(defun _zizo (begin end format)
  (let (
        (str (buffer-substring-no-properties begin end))
        (rules '((" " "+") ("|" "%7C") ("\n" "|") ("?" "%3F") ("&" "%26")))
        (rule nil))
    (while rules
      (setq rule (car rules))
      (setq rules (cdr rules))
            (let (
                  (a (car rule))
                  (b (car (cdr rule))))
              (while (string-match a str)
                (substring str (match-beginning 0) (match-end 0))
                (setq str (replace-match b nil nil str)))))
    (browse-url (concat format str))))

(defun zizo (begin end &optional arg)
  (interactive "r\nP")
  (_zizo begin end "http://chart.apis.google.com/chart?chst=d_text_outline&chld=000000|12|l|_|_|"))

(defun hotoke (begin end &optional arg)
  (interactive "r\nP")
  (_zizo begin end "http://chart.apis.google.com/chart?chst=d_text_outline&chld=ff0000|150|l|ffff00|b|"))

(provide 'zizo)
