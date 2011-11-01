;;; ac-ja.el --- auto-complete-mode source for Japanese 

;; Filename: ac-ja.el
;; Description: auto-complete-mode source for Japanese
;; Author: myuhe <yuhei.maeda_at_gmail.com>
;; Maintainer: myuhe
;; Copyright (C)  2011, myuhe , all rights reserved.
;; Created: 2011-10-10 
;; Version: 0.0.1
;; Keywords: convenience, auto-complete
;; URL: https://github.com/myuhe/ac-ja.el

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING. If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 0:110-1301, USA.

;;; Commentary:
;;
;; It is necessary to auto-complete.el Configurations.
;; heavily borrowed from dabbrev.el and skk-kakutei-extra.el.
;; http://d.hatena.ne.jp/lisp_interaction/20101226

;; Installation:
;; ============================================= 

;; Put the ac-ja.el to your
;; load-path.

;; or

;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;; M-x package-install ac-ja
;; Add to .emacs:
;; (require 'ac-ja.el)
;;
;;; Changelog:
;;

(require 'dabbrev)
(require 'auto-complete)

(defvar ac-skk-alist nil)
(defvar ac-skk-alist-file "~/ac-skk-alist.el")
(defvar ac-skk-jisyo-file nil)
(defvar ac-skk-buffer " *ac-skk*")

(defun ac-dabbrev-ja-expand (arg)
  (interactive "*P")
  ;;(flet ((message () nil))
  (let (abbrev
        record-case-pattern
        expansion
        old
        direction
        (orig-point (point))
        (dabbrev-abbrev-char-regexp
         (let ((c (char-category-set (char-before))))
           (cond
            ((aref c ?a) "[-_A-Za-z0-9]") ; ASCII
            ((aref c ?j)	; Japanese
             (cond
              ((aref c ?K) "\\cK") ; katakana
              ((aref c ?A) "\\cA") ; 2byte alphanumeric
              ((aref c ?H) "\\cH") ; hiragana
              ((aref c ?C) "\\cC") ; kanji
              (t "\\cj")))
            ((aref c ?k) "\\ck") ; hankaku-kana
            ((aref c ?r) "\\cr") ; Japanese roman ?
            (t dabbrev-abbrev-char-regexp)))))
    ;; abbrev -- the abbrev to expand
    ;; expansion -- the expansion found (eventually) or nil until then
    (save-excursion
      ;; If the user inserts a space after expanding
      ;; and then asks to expand again, always fetch the next word.
      (if (and (eq (preceding-char) ?\s)
               (markerp dabbrev--last-abbrev-location)
               (marker-position dabbrev--last-abbrev-location)
               (= (point) (1+ dabbrev--last-abbrev-location)))
          (progn
            ;; The "abbrev" to expand is just the space.
            (setq abbrev " ")
            (save-excursion
              (save-restriction
                (widen)
                (if dabbrev--last-buffer
                    (set-buffer dabbrev--last-buffer))
                (goto-char dabbrev--last-expansion-location)
                ;; Take the following word, with intermediate separators,
                ;; as our expansion this time.
                (re-search-forward
                 (concat "\\(?:" dabbrev--abbrev-char-regexp "\\)+"))
                (setq expansion (buffer-substring-no-properties
                                 dabbrev--last-expansion-location (point)))
                ;; Record the end of this expansion, in case we repeat this.
                (setq dabbrev--last-expansion-location (point))))
            ;; Indicate that dabbrev--last-expansion-location is
            ;; at the end of the expansion.
            (setq dabbrev--last-direction -1))

        ;; We have a different abbrev to expand.
        (dabbrev--reset-global-variables)
        (setq direction (if (null arg)
                            (if dabbrev-backward-only 1 0)
                          (prefix-numeric-value arg)))
        (setq abbrev (dabbrev--abbrev-at-point))
        (setq record-case-pattern t)
        (setq old nil))
      ;;--------------------------------
      ;; Find the expansion
      ;;--------------------------------
      (or expansion
          (setq expansion
                (dabbrev--find-expansion 
                 abbrev direction
                 (and (if (eq dabbrev-case-fold-search 'case-fold-search)
                          case-fold-search
                        dabbrev-case-fold-search)
                      (or (not dabbrev-upcase-means-case-search)
                          (string= abbrev (downcase abbrev))))))))
    (cond
     ((not expansion)
      (dabbrev--reset-global-variables))
     (t
      (if (not (or (eq dabbrev--last-buffer dabbrev--last-buffer-found)
                   (minibuffer-window-active-p (selected-window))))
          (progn
            (message "Expansion found in '%s'"
                     (buffer-name dabbrev--last-buffer))
            (setq dabbrev--last-buffer-found dabbrev--last-buffer))
        (message nil))
      (if (and (or (eq (current-buffer) dabbrev--last-buffer)
                   (null dabbrev--last-buffer))
               (numberp dabbrev--last-expansion-location)
               (and (> dabbrev--last-expansion-location (point))))
          (setq dabbrev--last-expansion-location
                (copy-marker dabbrev--last-expansion-location)))
      ;; Success: stick it in and return.
      (setq buffer-undo-list (cons orig-point buffer-undo-list))
      expansion))))

(defun ac-ja-at-point (&optional str)
  "Extract the symbol at point to serve as abbreviation."
  ;; Check for error
  (let ((dabbrev-abbrev-char-regexp
		 (let ((c (char-category-set (char-before))))
		   (cond
		    ((aref c ?a) "[-_A-Za-z0-9]") ; ASCII
		    ((aref c ?j)	; Japanese
		     (cond
		      ((aref c ?K) "\\cK") ; katakana
		      ((aref c ?A) "\\cA") ; 2byte alphanumeric
		      ((aref c ?H) "\\cH") ; hiragana
		      ((aref c ?C) "\\cC") ; kanji
		      (t "\\cj")))
		    ((aref c ?k) "\\ck") ; hankaku-kana
		    ((aref c ?r) "\\cr") ; Japanese roman ?
		    (t dabbrev-abbrev-char-regexp)))))
    (if (bobp)
        (error "No possible abbreviation preceding point"))
    (save-excursion
      ;; Record the end of the abbreviation.
      (setq dabbrev--last-abbrev-location (point))
      ;; If we aren't right after an abbreviation,
      ;; move point back to just after one.
      ;; This is so the user can get successive words
      ;; by typing the punctuation followed by M-/.
      (forward-char -1)
      (not (looking-at (or dabbrev-abbrev-char-regexp
                           "\\sw\\|\\s_")))
      (if (re-search-backward
           (or dabbrev-abbrev-char-regexp
               "\\sw\\|\\s_")
           nil t)
          (forward-char 1))
      ;; Now find the beginning of that one.
      (save-match-data
        (when (> (point) (minibuffer-prompt-end))
          (forward-char -1)
          (when dabbrev-abbrev-char-regexp
            (while (and (looking-at dabbrev-abbrev-char-regexp)
                        (> (point) (minibuffer-prompt-end))
                        (not (= (point) (field-beginning (point) nil
                                                         (1- (point))))))
              (forward-char -1))
            (or (looking-at dabbrev-abbrev-char-regexp)
                (forward-char 1))))
        (and dabbrev-abbrev-skip-leading-regexp
             (while (looking-at dabbrev-abbrev-skip-leading-regexp)
               (forward-char 1))))
      (if str
          (buffer-substring-no-properties
           dabbrev--last-abbrev-location (point))
        (point)))))

(defun ac-dabbrev-ja-candidate()
  (when (stringp (ac-dabbrev-ja-expand 1))
    (loop for i from 1 to 10
          collect (ac-dabbrev-ja-expand i))))

(defvar ac-source-dabbrev-ja
  '((candidates . ac-dabbrev-ja-candidate)
    (prefix . ac-ja-at-point)))

(defun ac-skk-make-alist ()
  (let ((count 0)
        (countt 0)
        alist word)
    (with-temp-buffer
      (insert-file-contents "~/SKK-JISYO.L") 
      (goto-char (point-min))
      (search-forward ";; okuri-nasi entries.")
      (while (re-search-forward "/\\(.[^/]*\\)" nil t)
        (setq word (car (skk-treat-strip-note-from-word
                         (buffer-substring (match-beginning 1)
                                           (match-end 1)))))
        ;; (unless (member word alist)
        (setq alist (append (list word) alist))
        (setq count (1+ count))
        (setq countt (1+ countt))
        (and (= countt 2000)
             (message "%d %%" (floor (* (/ count 217000.0) 100)))
             (setq countt 0))
        ;; )
        ))
    (setq ac-skk-alist alist)
    (message "ac-skk-alist: %d" count)
    (sit-for 1)
    (ac-skk-save-alist)
    (message "ac-skk-source initialization...done")))

(defun ac-skk-save-alist ()
  (interactive)
  (set-buffer (find-file-noselect ac-skk-alist-file))
  (erase-buffer)
  (prin1 ac-skk-alist (current-buffer))
  (basic-save-buffer)
  (kill-buffer nil))

(defun ac-skk-read-alist ()
  (set-buffer (find-file-noselect ac-skk-alist-file))
  (widen)
  (goto-char (point-min))
  (condition-case err
      (setq ac-skk-alist (read (current-buffer)))
    (error
     (error "ERROR")))
  (kill-buffer nil))

(defun ac-skk-candidate ()
  (all-completions
   (car (skk-treat-strip-note-from-word 
         (nth 1 (car skk-kakutei-history))))
   ac-skk-alist))

(defun ac-skk-init ()
  (if (file-exists-p ac-skk-alist-file)
      (ac-skk-read-alist)
    (ac-skk-make-alist)))

(defvar ac-source-skk
  '((init . ac-skk-init)
    (candidates . ac-skk-candidate)
    (prefix . ac-ja-at-point)))

(provide 'ac-ja)

;;; ac-ja.el ends here.
