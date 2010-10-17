;;; drill-instructor.el ---  Enforce key-bind of Emacs.
;; -*- Mode: Emacs-Lisp -*-

;; Copyright (C) 2008 by 101000code/101000LAB
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
;;
;; Version: 1.1.4
;; Author: k1LoW (Kenichirou Oyama), <k1lowxb [at] gmail [dot] com> <k1low [at] 101000lab [dot] org>
;; URL: http://code.101000lab.org, http://trac.codechecki.in

;; Change Log
;; 1.1.4 window-systemでterminalで起動しているかguiで起動しているかを判定。これに伴いdrill-instructor-alert-tab関数を追加。TABキーもC-iに強制
;; 1.1.3 minor-mode-alistに登録されてもkeymapが正常にmapされないバグを修正
;; 1.1.2 drill-instructor-switchを修正.other-window,delete-windowにもdefadviceを設定.pop-to-bufferのdefadviceを削除
;; 1.1.1 pop-to-bufferにもdefadviceを設定
;; 1.0.2 id:tomisima Patch適用。ReturnキーもC-mに強制
;; 1.0.1 delete-backward-charを強制的にC-hに割り当て
;; -.-.- やっぱり鬼軍曹といえば海兵隊なのでdrill instructorに名称変更
;; 1.1.0 drill-instructorを適用させないメジャーモードを設定できるようにした

;;; Code:

;; mode
(defvar drill-instructor nil
  "Enforce key-bind of Emacs.")

(defvar drill-instructor-global nil
  "drill-instructor-global")

(defvar drill-instructor-unset-major-mode-list '(term-mode)
  "Drill instructor unset list")

;; setq minor-mode-alist
(if (not (assq 'drill-instructor minor-mode-alist))
    (setq minor-mode-alist
          (cons '(drill-instructor " Drill")
                minor-mode-alist)))

;; defun drill-instructor
(defun drill-instructor (&optional arg)
  "Enforce key-bind of Emacs."
  (interactive)
  ;; mode variable settings
  (cond
   ((< (prefix-numeric-value arg) 0)
    (setq drill-instructor nil))
   (arg
    (setq drill-instructor t))
   (t
    (setq drill-instructor (not drill-instructor))))
  ;; content
  (if drill-instructor
         (progn
           (if window-system
               (progn
                 (define-key drill-instructor-key-map [return] 'drill-instructor-alert-return)
                 (define-key drill-instructor-key-map [tab] 'drill-instructor-alert-tab)))
           (add-to-list 'minor-mode-map-alist (cons 'drill-instructor drill-instructor-key-map)))
         nil)
    )

(defun drill-instructor-switch ()
  "drill-instructor-switch"
  (if drill-instructor-global
        (if (memq major-mode drill-instructor-unset-major-mode-list)
          (setq drill-instructor nil)
          (drill-instructor t)
          )))

(defadvice switch-to-buffer (after drill-instructor-switch-to-buffer activate)
  "drill-instructor-switch-to-buffer"
  (drill-instructor-switch))

(defadvice kill-buffer (after drill-instructor-kill-buffer activate)
  "drill-instructor-kill-buffer"
  (drill-instructor-switch))

(defadvice other-window (after drill-instructor-other-window activate)
  "drill-instructor-other-window"
  (drill-instructor-switch))

(defadvice delete-window (after drill-instructor-delete-window activate)
  "drill-instructor-delete-window"
  (drill-instructor-switch))

;; key-map
(defvar drill-instructor-key-map
  (let ((map (make-sparse-keymap)))
    (define-key map [up] 'drill-instructor-alert-up)
    (define-key map [down] 'drill-instructor-alert-down)
    (define-key map [right] 'drill-instructor-alert-right)
    (define-key map [left] 'drill-instructor-alert-left)
    (define-key map (kbd "DEL") 'drill-instructor-alert-del)
    (define-key map "\C-h" 'delete-backward-char);C-hをbackspaseに割り当て
    map))

(defun drill-instructor-alert-up ()
  (interactive)
  (message "Don't use up-key!!! Press C-p!! M-p!!!"))

(defun drill-instructor-alert-down ()
  (interactive)
  (message "Don't use down-key!!! Press C-n!! M-n!!!"))

(defun drill-instructor-alert-right ()
  (interactive)
  (message "Don't use right-key!!! Press C-f!! C-f!!!"))

(defun drill-instructor-alert-left ()
  (interactive)
  (message "Don't use left-key!!! Press C-b!! C-b!!!"))

(defun drill-instructor-alert-del ()
  (interactive)
  (message "Don't use DEL!!! Press C-h!! C-h!!!"))

(defun drill-instructor-alert-return ()
  (interactive)
  (message "Don't use RETURN!!! Press C-m!! C-m!!!"))

(defun drill-instructor-alert-tab ()
  (interactive)
  (message "Don't use TAB!!! Press C-i!! C-i!!!"))

;; mode provide
(provide 'drill-instructor)

;;; end
;;; drill-instructor.el ends here
