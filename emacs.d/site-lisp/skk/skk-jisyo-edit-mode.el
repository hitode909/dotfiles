;;; skk-jisyo-edit-mode.el --- major mode for editing SKK dictionaries -*- coding: euc-jp -*-

;; Copyright (C) 2001-2007 SKK Development Team

;; Maintainer: SKK Development Team <skk@ring.gr.jp>
;; Keywords: japanese, mule, input method

;; This file is part of Daredevil SKK.

;; Daredevil SKK is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.

;; Daredevil SKK is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with Daredevil SKK, see the file COPYING.  If not, write to
;; the Free Software Foundation Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; This is a major mode for editing SKK dictionaries.

;;; Code:

(eval-when-compile
  (require 'poe)
  (require 'static)
  (defvar font-lock-defaults))

(defvar skk-jisyo-edit-map nil
  "Keymap for SKK JISYO Edit mode.")

(defvar skk-jisyo-edit-mode-hook nil
  "Hook run on entry in `skk-jisyo-edit-mode'.")

(defvar skk-jisyo-edit-syntax-table nil)

(unless skk-jisyo-edit-map
  (setq skk-jisyo-edit-map (make-sparse-keymap 'skk-jisyo-edit-map)))

(defvar skk-jisyo-edit-font-lock-keywords
 '(("\\(\\[[^]]*/\\]\\)" 1 font-lock-constant-face)
   ("^\\([^; ]+ \\)/" 1 font-lock-function-name-face)
   ("/[^;\n]+\\(;[^/\n]*\\)" 1 font-lock-type-face t)
   ("^\\(;.+\\)$" 1 font-lock-comment-face t)
   ("^\\(;; okuri-ari entries\\.\\)$" 1 font-lock-keyword-face t)
   ("^\\(;; okuri-nasi entries\\.\\)$" 1 font-lock-keyword-face t)
   ("/\\([^/\n]+\\)$" 1 highlight)
   ("\\(/\\)" 1 font-lock-warning-face))
 "Additional expressions to highlight in SKK JISYO edit mode.")

(put 'skk-jisyo-edit-mode
     'font-lock-defaults
     '(skk-jisyo-edit-font-lock-keywords))

(defvar skk-jisyo-edit-original-window-configuration nil)

;;;###autoload
(defun skk-jisyo-edit-mode ()
  "Major mode for editing SKK JISYO."
  (interactive)
  (kill-all-local-variables)
  (setq mode-name "SKK JISYO Edit")
  (setq major-mode #'skk-jisyo-edit-mode)
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults '(skk-jisyo-edit-font-lock-keywords))
  (make-local-variable 'skk-jisyo-edit-syntax-table)
  (setq skk-jisyo-edit-syntax-table (make-syntax-table))
  (set-syntax-table skk-jisyo-edit-syntax-table)
  (let ((map (make-sparse-keymap)))
    (static-cond
     ((featurep 'xemacs)
      (set-keymap-parents map (list skk-jisyo-edit-map))
      (use-local-map map))
     (t
      (use-local-map (nconc map skk-jisyo-edit-map)))))
  (modify-syntax-entry ?\" "w" skk-jisyo-edit-syntax-table)
  (modify-syntax-entry ?/ "w" skk-jisyo-edit-syntax-table)
  (run-hooks 'skk-jisyo-edit-mode-hook))

;;;###autoload
(add-to-list 'auto-mode-alist '("SKK-JISYO" . skk-jisyo-edit-mode))
;;;###autoload
(add-to-list 'auto-mode-alist '("\\.skk-jisyo\\(\\.BAK\\|\\.bak\\|~\\)?$"
				. skk-jisyo-edit-mode))
;;;###autoload
(add-to-list 'auto-mode-alist '("\\..*skk/jisyo\\(\\.BAK\\|\\.bak\\|~\\)?$"
				. skk-jisyo-edit-mode))

;;;###autoload
(defun skk-edit-private-jisyo (&optional coding-system)
  (interactive "P")
  (when coding-system
    (setq coding-system (read-coding-system
			 "�Ŀͼ���Υ����ɷϤ����: "
			 (skk-find-coding-system skk-jisyo-code))))
  (unless coding-system
    (setq coding-system (skk-find-coding-system skk-jisyo-code)))
  ;;
  (when (skk-y-or-n-p "����򥻡��֤��ޤ����� "
		      "Save jisyo? ")
    (skk-save-jisyo))
  (message nil)
  (setq skk-jisyo-edit-original-window-configuration
	(current-window-configuration))
  ;; SKK ����Υ����ɤϸ�Ƚ�꤬���ꤦ�뤿�ᡢ��դ���
  (let ((coding-system-for-read coding-system))
    (find-file skk-jisyo))
  (unless (eq major-mode 'skk-jisyo-edit-mode)
    (skk-jisyo-edit-mode))
  (static-when (or (featurep 'xemacs)
		   (< emacs-major-version 21))
    (make-local-hook 'kill-buffer-hook))
  ;; �Խ���˺��ټ¹Ԥ��Ƥ⡢
  ;; �� �Τ褦�ˤʤ뤫�� skk-update-jisyo-function ����������롣
  ;; '((lambda nil
  ;;     (setq skk-update-jisyo-function #'ignore))
  ;;   (lambda nil
  ;;     (setq skk-update-jisyo-function #'skk-update-jisyo-original))
  ;;   t)
  (add-hook 'kill-buffer-hook
	    `(lambda ()
	       (setq skk-update-jisyo-function
		     #',skk-update-jisyo-function)
	       (ad-disable-advice 'skk-henkan-in-minibuff 'before 'notify-no-effect)
	       (ad-disable-advice 'skk-purge-from-jisyo 'around 'notify-no-effect)
	       (ad-activate 'skk-henkan-in-minibuff)
	       (ad-activate 'skk-purge-from-jisyo))
	    nil t)
  (setq skk-update-jisyo-function #'ignore)
  (ad-enable-advice 'skk-henkan-in-minibuff 'before 'notify-no-effect)
  (ad-enable-advice 'skk-purge-from-jisyo 'around 'notify-no-effect)
  (ad-activate 'skk-henkan-in-minibuff)
  (ad-activate 'skk-purge-from-jisyo)
  (local-set-key "\C-c\C-c"
		 #'(lambda ()
		     (interactive)
		     (when (skk-y-or-n-p "�Խ���λ���ޤ����� "
					 "Finish editing jisyo? ")
		       (save-buffer)
		       (kill-buffer (current-buffer))
		       (skk-reread-private-jisyo t)
		       (set-window-configuration
			skk-jisyo-edit-original-window-configuration))
		     (message nil)))
  (local-set-key "\C-c\C-k"
		 #'(lambda ()
		     (interactive)
		     (when (skk-y-or-n-p "�Խ�����ߤ��ޤ����� "
					 "Abort editing jisyo? ")
		       (set-buffer-modified-p nil)
		       (kill-buffer (current-buffer))
		       (set-window-configuration
			skk-jisyo-edit-original-window-configuration))
		     (message nil))))

(defadvice skk-henkan-in-minibuff (before notify-no-effect disable)
  (ding)
  (skk-message "�Ŀͼ�����Խ���Ǥ�����Ͽ��ȿ�Ǥ���ޤ���"
	       "You are editing private jisyo.  This registration has no effect.")
  (sit-for 1.5))

(defadvice skk-purge-from-jisyo (around notify-no-effect disable)
  (if (eq skk-henkan-mode 'active)
      (progn
	(ding)
	(skk-message "�Ŀͼ�����Խ���Ǥ�������Ǥ��ޤ���"
		     "You are editing private jisyo.  Can't purge."))
    ad-do-it))

(require 'product)
(product-provide
    (provide 'skk-jisyo-edit)
  (require 'skk-version))

;;; skk-jisyo-edit.el ends here
