;;; skk-hint.el --- SKK conversion with hints -*- coding: euc-jp -*-
;; Copyright (C) 2001, 2003 Yoshiki Hayashi <yoshiki@xemacs.org>

;; Author: Yoshiki Hayashi <yoshiki@xemacs.org>
;; Keywords: japanese

;; This file is part of Daredevil SKK.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with Daredevil SKK, see the file COPYING.  If not, write to the
;; Free Software Foundation Inc., 51 Franklin Street, Fifth Floor, Boston,
;; MA 02110-1301, USA.

;;; Commentary

;; ����Ϣ��⡼�ɤȢ��⡼�ɤ��ɤߤ��ѽ��� (�ߤ����ʤ��) ���뤳�Ȥ�
;; ��äƸ���ιʤ���ߤ�Ԥ��ץ����Ǥ���
;;
;; ���󥹥ȡ���� ~/.skk �˰ʲ��������ޤ���
;;
;; (require 'skk-hint)
;;
;; �㤨�С�������ɤ� �ȤʤäƤ���Ȥ��ˡ�; michi SPC �����Ϥ���ȡ�
;; ����ƻ�Ȥ������֤ˤʤ�ޤ���
;;
;; ��̩���ѽ�����äƤ���櫓�ǤϤʤ���������ɤ� �� ; doubutsu SPC
;; �����Ϥ���Ȣ���ư�Ȥ������֤ˤʤ�ޤ���
;;
;; �Ĥޤꡢ�̾���Ѵ�����Τʤ��ǡ��ҥ�ȤȤ���Ϳ����줿�ɤߤ�ޤ��
;; ��������Ĥ�Τ˸����ʤ�ޤ���
;;
;; -- Tips --
;;
;; skk-hint.el ��ñ�����θ��䤬�������󤢤���ˡ�������������ʤ�
;; ������ʤȤ�������ͭ���Ǥ����㤨��
;;
;; ����
;;
;; ���Ѵ�����ȡ��㡢�����ġ���������...�Ȳ̤Ƥ��ʤ����䤬�ФƤ��ޤ���
;; �����椫��ֲߡפ�Ȥ��˽Ф������Ȥ��ޤ������̤��Ѵ����Ƥ⤽�Τ���
;; �ФƤ��ޤ��������
;;
;; ����;kahei
;;
;; �Τ褦�����Ϥ��Ƥ��� SPC �򲡤����Ѵ��򳫻Ϥ���ȡ��֤��ؤ��פθ���
;; �Ǥ���ֲ�ʾ�פ˴ޤޤ��
;;
;; ����
;;
;; ����̤˸���ޤ���

;;;Code

(eval-when-compile
  (require 'skk-macs))

(require 'skk-vars)

;; is this necessary?
(require 'skk-comp)

(defadvice skk-search (around skk-hint-ad activate)
  ;; skk-current-search-prog-list �����ǤˤʤäƤ���ץ�����ɾ�����ơ�
  ;; skk-henkan-key�򥭡��ˤ��Ƹ�����Ԥ���
  (if (null skk-hint-henkan-hint)
      ad-do-it
    (let (l kouho hint)
      (while (and (null l) skk-current-search-prog-list)
	(setq l (eval (car skk-current-search-prog-list)))
	(let ((skk-henkan-key (nth 0 skk-hint-henkan-hint))
	      (skk-henkan-okurigana (nth 1 skk-hint-henkan-hint))
	      (skk-okuri-char (nth 2 skk-hint-henkan-hint)))
	  (setq hint (skk-nunion hint (eval (car skk-current-search-prog-list)))))
	(setq kouho (skk-nunion kouho l))
	(setq l (skk-hint-limit kouho hint))
	(setq skk-current-search-prog-list (cdr skk-current-search-prog-list)))
      (setq ad-return-value l))))

(defun skk-hint-setup-hint ()
  (cond ((eq skk-hint-state 'kana)
	 (skk-kana-cleanup t)
	 (let ((hint (buffer-substring-no-properties
		      skk-hint-start-point (point))))
	   (unless (string= hint "")
	     (setq skk-hint-henkan-hint
		   (list (if skk-katakana
			     (skk-katakana-to-hiragana hint)
			   hint))))))
	((eq skk-hint-state 'okuri)
	 (let ((henkan-key (buffer-substring-no-properties
			    skk-hint-start-point skk-hint-end-point))
	       (okurigana (buffer-substring-no-properties
			   skk-hint-end-point (point))))
	   (unless (or (string= henkan-key "")
		       (string= okurigana ""))
	     (when skk-katakana
	       (setq henkan-key (skk-katakana-to-hiragana henkan-key)
		     okurigana (skk-katakana-to-hiragana okurigana)))
	     (setq skk-hint-henkan-hint
		  (list (concat henkan-key skk-hint-okuri-char)
			okurigana skk-hint-okuri-char)))))
	(t (skk-error "ͽ�����ʤ����֤� skk-hint-setup-hint ���ƤФ�ޤ���"
		       "skk-hint-setup-hint is called from unexpected place")))
  (setq skk-hint-inhibit-kakutei nil))

(defadvice skk-insert (around skk-hint-ad activate)
  (cond ((and skk-henkan-mode
	      (eq last-command-char skk-hint-start-char)
	      (not skk-hint-state))
	 (skk-with-point-move
	  (when (featurep 'skk-dcomp)
	    (skk-dcomp-before-kakutei))
	  (setq skk-hint-inhibit-dcomp t)
	  (skk-set-marker skk-hint-start-point (point))
	  (setq skk-hint-state 'kana
		skk-hint-inhibit-kakutei t)))
	((and (eq skk-hint-state 'kana)
	      (eq last-command-char skk-start-henkan-char))
	 (skk-with-point-move
	  (skk-hint-setup-hint)
	  (delete-region skk-hint-start-point (point))
	  (setq skk-hint-state 'henkan)
	  (setq skk-henkan-count -1)
	  (setq skk-henkan-list nil)
	  (skk-start-henkan arg)))
	((and (eq skk-hint-state 'kana)
	      (memq last-command-char skk-set-henkan-point-key))
	 (skk-with-point-move
	  (setq skk-hint-end-point (point))
	  (setq skk-hint-state 'okuri)
	  (setq last-command-char (skk-downcase last-command-char))
	  (setq skk-hint-okuri-char (char-to-string last-command-char))
	  (skk-kana-input arg)
	  (when (skk-jisx0208-p (char-before))
	    (skk-hint-setup-hint)
	    (delete-region skk-hint-start-point (point))
	    (setq skk-hint-state 'henkan)
	    (setq skk-henkan-count -1)
	    (setq skk-henkan-list nil)
	    (skk-start-henkan arg))))
	((eq skk-hint-state 'okuri)
	 (skk-with-point-move
	  (skk-kana-input arg)
	  (skk-hint-setup-hint)
	  (delete-region skk-hint-start-point (point))
	  (setq skk-hint-state 'henkan)
	  (setq skk-henkan-count -1)
	  (setq skk-henkan-list nil)
	  (skk-start-henkan arg)))
	(t ad-do-it)))

(defadvice keyboard-quit (before skk-hint-ad activate)
  (setq skk-hint-inhibit-kakutei nil))

(defadvice abort-recursive-edit (before skk-hint-ad activate)
  (setq skk-hint-inhibit-kakutei nil))

(defadvice skk-previous-candidate (before skk-hint-ad activate)
  (when (and (eq skk-henkan-mode 'active)
	     (not (string= skk-henkan-key ""))
	     (= skk-henkan-count 0))
    (setq skk-hint-henkan-hint nil
	  skk-hint-state nil))
  (setq skk-hint-inhibit-kakutei nil))

(defadvice skk-kakutei (around skk-hint-ad activate)
  (unless skk-hint-inhibit-kakutei
    ad-do-it))

(defadvice skk-kakutei-initialize (after skk-hint-ad activate)
  (setq skk-hint-henkan-hint nil
	skk-hint-start-point nil
	skk-hint-state nil
	skk-hint-inhibit-dcomp nil
	skk-hint-inhibit-kakutei nil))

(defadvice skk-delete-backward-char (before skk-hint-ad activate)
  (when (and (markerp skk-hint-start-point)
	     (or (eq (1+ skk-hint-start-point) (point))
		 (eq skk-hint-start-point (point))))
    (setq skk-hint-state nil
	  skk-hint-inhibit-kakutei nil)))

(defun skk-hint-member (char kouho)
  ;; ʸ����Υꥹ�� KOUHO �����ʸ�� CHAR ��ޤ��Τ�����С�����ʸ������֤�
  (catch 'found
    (dolist (word kouho)
      (let ((length (length word)))
	(dotimes (i length)
	  (if (eq char (aref word i))
	      (throw 'found word)))))))

(defun skk-hint-limit (kouho hint)
  ;; �Ѵ����� KOUHO ��ʸ����Υꥹ�� HINT ����Τɤ줫��ʸ����
  ;; �ޤޤ�Ƥ����ΤΤߤ����¤��롣
  (let ((kouho (copy-sequence kouho))
	result)
    (dolist (string hint)
      (let ((length (length string)))
	(dotimes (i length)
	  (let (ret)
	    (when (setq ret (skk-hint-member (aref string i) kouho))
	      (unless (eq (aref string i) ?\;)
		(setq result (cons ret result))
		(delete ret kouho)))))))
    (nreverse result)))

(require 'product)
(product-provide (provide 'skk-hint) (require 'skk-version))
;;; Local Variables:
;;; End:
;;; skk-hint.el ends here
