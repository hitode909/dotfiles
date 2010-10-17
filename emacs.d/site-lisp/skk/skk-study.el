;;; skk-study.el --- SKK $B3X=,8z2LDs6!%W%m%0%i%`(B -*- coding: iso-2022-jp -*-
;; Copyright (C) 1999, 2000, 2002, 2003 NAKAJIMA Mikio <minakaji@namazu.org>

;; Author: NAKAJIMA Mikio <minakaji@namazu.org>
;; Maintainer: SKK Development Team <skk@ring.gr.jp>
;; Version: $Id: skk-study.el,v 1.53 2007/04/22 02:38:26 skk-cvs Exp $
;; Keywords: japanese
;; Created: Apr. 11, 1999
;; Last Modified: $Date: 2007/04/22 02:38:26 $

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

;; $B$"$k8l(B A' $B$r3NDj$7$?>l9g$K!"(BA' $B5Z$S$=$N8+=P$78l(B A $B$KBP$7$F!"D>A0$K(B
;; $BJQ49$7$?8l(B B' $B$H$=$N8+=P$78l(B B $B$r4XO"8l$H$7$FEPO?$7$F$*$-!":FEY(B A
;; $B$NJQ49$r9T$C$?$H$-$K!"(BB $B5Z$S(B B' $B$N%Z%"$,D>A0$N2?2s$+$K3NDj$7$?8l$N(B
;; $BCf$K8+$D$+$l$P!"$rM%@h$7$F=PNO$9$kC1=c$J3X=,8z2L$rDs6!$9$k%W%m%0%i(B
;; $B%`$G$9!#(B
;;
;; $B@N(B SKK ML $B$GOCBj$K$J$C$?C18l$NB0@-$NJ]B8$N$?$a$K!"(Bskk-attr.el $B$r:n(B
;; $B$j$^$7$?$,!"5!G=$rM_D%$j$9$.$F$b$N$K$J$j$^$;$s$G$7$?!#D>A0$NJQ49$H(B
;; $B$N4XO"@-$rJ]B8$9$k$?$a$@$1$K5!G=$r9J$C$F:F9=@.$7$?$N$,$3$N%W%m%0%i(B
;; $B%`$G$9!#(B

;; <How to install>
;;
;; ~/.skk $B$K(B
;;
;;   (require 'skk-study)
;;
;; $B$H=q$$$F2<$5$$!#(B

;; <DATA STRUCTURE (SKK-STUDY-ALIST)>
;;
;; ((okuri-ari .  ((A . (((B . B') . (A' ...))
;;                                       ...))))
;;  (okuri-nasi . ((A . (((B . B') . (A' ...))
;;                                       ...)))))
;;
;;  o examples
;;
;; ((okuri-ari .
;;           (("$B$-(Br" . ((("$B$U$/(B" . "$BI~(B") . ("$BCe(B"))
;;                      (("$B$-(B" . "$BLZ(B") . ("$B@Z(B"))
;;                      (("$B$($s(B" . "$B1o(B") . ("$B@Z(B"))))
;;            ("$B$J(Bk" . ((("$B$3$I$b(B" . "$B;R6!(B") . ("$B5c(B"))
;;                      (("$B$3$H$j(B" . "$B>.D;(B") . ("$BLD(B"))))
;;            ("$B$+(Bk" . ((("$B$+$_(B" . "$B;f(B") . ("$B=q(B")) (("$B$R$s$+$/(B" . "$BIJ3J(B") . ("$B7g(B")))))
;;           ...)
;;  (okuri-nasi .
;;            (("$B$+$_(B" . ((("$B$-(Br" . "$B@Z(B") . ("$B;f(B"))))
;;             ...)))
;;
;; <TODO>
;; $B2J3X!"K!N'$J$I$H%F!<%^$r7h$a$F!"%P%C%U%!Kh$K3X=,%G!<%?$r@Z$jBX$($G(B
;; $B$-$k$HJXMx$+$b!#(B-> experimental/skk-study.el $B$G<B8=$5$l$F$$$^$9!#(B


;;; Code:

(eval-when-compile
  (require 'cl))

(require 'pym)
(require 'skk-macs)
(require 'skk-vars)
(require 'ring)

(defun-maybe ring-elements (ring)
  "Return a list of the elements of RING."
  ;; ring.el of Emacs 20 does not have ring-elements.
  (mapcar #'identity (cddr ring)))

;;;; inline functions.
(defsubst skk-study-get-last-henkan-data (index)
  (and (> (ring-length skk-study-data-ring) index)
       (ring-ref skk-study-data-ring index)))

(add-to-list 'skk-search-end-function 'skk-study-search)
(add-to-list 'skk-update-end-function 'skk-study-update)

;;;###autoload
(defun skk-study-search (henkan-buffer midasi okurigana entry)
  "$B3X=,%G!<%?$r;2>H$7$F(B ENTRY $B$r2C9)$7!"4XO"@-$N$"$k8l$NM%@h=g0L$r>e$2$FJV$9!#(B"
  (or skk-study-data-ring
      (setq skk-study-data-ring (make-ring skk-study-search-times)))
  (when (and entry (cdr entry))
    (or skk-study-alist (skk-study-read))
    (with-current-buffer henkan-buffer
      ;; (("$B$-(Br" . ((("$B$U$/(B" . "$BI~(B") . ("$BCe(B")) (("$B$-(B" . "$BLZ(B") . ("$B@Z(B"))))
      ;;  ("$B$J(Bk" . ((("$B$3$I$b(B" . "$B;R6!(B") . ("$B5c(B")))))
      (let ((alist
	     (cdr
	      (assoc
	       midasi
	       (cdr (assq (cond ((or skk-okuri-char skk-henkan-okurigana)
				 'okuri-ari)
				(t 'okuri-nasi))
			  skk-study-alist))))))
	(when alist
	  (setq entry (skk-study-search-1 alist midasi okurigana entry))))))
  entry)

(defun skk-study-search-1 (target-alist midasi okurigana entry)
  (do ((index 0 (1+ index))
       (times skk-study-search-times (1- times))
       last-data associates e exit)
      ((or exit (= times 0)) entry)
    (and
     (setq last-data (skk-study-get-last-henkan-data index))
     ;; ((("$B$U$/(B" . "$BI~(B") . ("$BCe(B")) (("$B$-(B" . "$BLZ(B") . ("$B@Z(B")))
     ;; ("$BCe(B")
     (setq associates (cdr (assoc last-data target-alist)))
     (setq associates (reverse associates))
     (setq exit t)
     (while (setq e (car associates))
       ;;uniq
       (setq entry (cons e (delete e entry))
	     associates (cdr associates))))))

;;;###autoload
(defun skk-study-update (henkan-buffer midasi okurigana word purge)
  "MIDASI $B$H(B WORD $B$K$D$$$F(B `skk-study-data-ring' $B$N:G=i$N4XO"8l$r4XO"IU$1$F3X=,$9$k!#(B"
  (or skk-study-data-ring
      (setq skk-study-data-ring (make-ring skk-study-search-times)))
  (let ((inhibit-quit t)
	last-data diff grandpa papa baby)
    (with-current-buffer henkan-buffer
      (when (and
	     ;; $BBh0l8uJd$G3NDj$7$?$+$I$&$+(B
	     (or skk-study-first-candidate
		 (not (string= word (car skk-henkan-list))))
	     ;; $BJQ49%P%C%U%!$,JQ$o$C$F$$$J$$$+$I$&$+(B
	     (eq (skk-get-last-henkan-datum 'henkan-buffer) henkan-buffer)
	     (or (not skk-study-max-distance)
		 (and (setq diff
			    (- (point)
			       (skk-get-last-henkan-datum 'henkan-point)))
		      ;; $BD>A0$NJQ49$h$j%]%$%s%H$,A0$X0\F0$7$F$$$J$$$+$I$&$+(B
		      (> diff 0)
		      ;; skk-study-max-distance $B$rD6$($FD>A0$NJQ49$H%]%$%s(B
		      ;; $B%H$,N%$l$F$$$J$$$+$I$&$+!#(B
		      (> skk-study-max-distance diff)))
	     midasi word
	     (setq last-data (if (not (ring-empty-p skk-study-data-ring))
				 (ring-ref skk-study-data-ring 0)))
	     (not (or (string= midasi "") (string= word "")
		      (and (string= midasi (car last-data))
			   (string= word (cdr last-data))))))
	(or skk-study-alist (skk-study-read))
	(setq grandpa (assq (cond ((or skk-okuri-char skk-henkan-okurigana)
				   'okuri-ari)
				  (t 'okuri-nasi))
			    skk-study-alist)
	      ;; ((("$B$U$/(B" . "$BI~(B") . ("$BCe(B")) (("$B$-(B" . "$BLZ(B") . ("$B@Z(B")))
	      papa (assoc midasi (cdr grandpa)))
	(cond (
	       ;; car $B$K8+=P$78l$r;}$D(B cell $B$,$J$$(B
	       (not (or papa purge))
	       (setcdr grandpa
		       (nconc
			(list (cons midasi (list (cons last-data (list word)))))
			(cdr grandpa))))
	      ;; $B8+=P$78l$+$i;O$^$k(B cell $B$O$"$k$,!"(Bcdr $B$K(B (last-key . last-word) $B$r(B
	      ;; $B%-!<$K$7$?(B cell $B$,$J$$!#(B
	      ((not (or
		     ;; (("$B$U$/(B" . "$BI~(B") . ("$BCe(B"))
		     (setq baby (assoc last-data (cdr papa)))
		     purge))
	       (setcdr papa (cons (cons last-data (list word)) (cdr papa))))
	      ;; $B8+=P$78l$r%-!<$H$7$?4{B8$N(B cell $B9=B$$,$G$-$"$,$C$F$$$k$N$G!"4XO"8l$@$1(B
	      ;; $B%"%C%W%G!<%H$9$k!#(B
	      ((not purge)
	       ;; ring $B%G!<%?$NJ}$,$b$C$H8zN(E*$+!)(B  $B$G$b$3$3$NItJ,$N%G!<%?$N%"%C%W%G!<%H(B
	       ;; $B$,8zN(NI$/$G$-$J$$!#(B
	       (setcdr baby (cons word (delete word (cdr baby))))
	       (if (> (1- (length (cdr baby))) skk-study-associates-number)
		   (skk-study-chomp (cdr baby) (1- skk-study-associates-number))))
	      (t (setcdr grandpa (delq baby (cdr grandpa)))))))))

;;;###autoload
(defun skk-study-save (&optional nomsg)
  "`skk-study-file' $B$K3X=,7k2L$rJ]B8$9$k!#(B
$B%*%W%7%g%J%k0z?t$N(B NOMSG $B$,(B non-nil $B$G$"$l$P!"J]B8%a%C%;!<%8$r=PNO$7$J$$!#(B"
  (interactive "P")
  (let ((inhibit-quit t)
	(last-time
	 (nth 5 (file-attributes (expand-file-name skk-study-file))))
	e)
    (if (or (and (null skk-study-alist) (not nomsg))
	    (not skk-study-last-read)
	    (and skk-study-last-save
		 (skk-study-time-lessp
		  skk-study-last-save skk-study-last-read)))
	(progn
	  (skk-message "SKK $B$N3X=,7k2L$r%;!<%V$9$kI,MW$O$"$j$^$;$s(B"
		       "No SKK study need saving")
	  (sit-for 1))
      (when (not nomsg)
	(skk-message "%s $B$K(B SKK $B$N3X=,7k2L$r%;!<%V$7$F$$$^$9(B..."
		     "Saving SKK study to %s..." skk-study-file))
      (and skk-study-backup-file
	   (file-exists-p (expand-file-name skk-study-file))
	   (cond ((eq system-type 'ms-dos)
		  (with-temp-file skk-study-backup-file
		    (erase-buffer)
		    (insert-file-contents skk-study-file)))
		 (t
		  (copy-file (expand-file-name skk-study-file)
			     (expand-file-name skk-study-backup-file)
			     'ok-if-already-exists 'keep-date))))
      (with-temp-buffer
	(insert
	 (format ";;; skk-study-file format version %s\n"
		 skk-study-file-format-version))
	(when skk-study-sort-saving
	  ;; sort is not necessary, but make an alist rather readable.
	  (setq e (assq 'okuri-ari skk-study-alist))
	  (setcdr e (sort (cdr e)
			  (function (lambda (a b)
				      (skk-string< (car a) (car b))))))
	  (setq e (assq 'okuri-nasi skk-study-alist))
	  (setcdr e (sort (cdr e)
			  (function (lambda (a b)
				      (skk-string< (car a) (car b)))))))
	(skk-study-prin1 skk-study-alist (current-buffer))
	(write-region-as-coding-system
	 (skk-find-coding-system skk-jisyo-code)
	 (point-min) (point-max) skk-study-file))
      (setq skk-study-last-save (current-time))
      (when (not nomsg)
	(skk-message "%s $B$K(B SKK $B$N3X=,7k2L$r%;!<%V$7$F$$$^$9(B...$B40N;!*(B"
		     "Saving SKK study to %s...done" skk-study-file)
	(sit-for 1)
	(message "")))))

;;;###autoload
(defun skk-study-read (&optional nomsg force)
  "`skk-study-file' $B$+$i3X=,7k2L$rFI$_9~$`!#(B
$B%*%W%7%g%J%k0z?t$N(B FORCE $B$,(B non-nil $B$G$"$l$P!"GK4~$N3NG'$r$7$J$$!#(B"
  (interactive "P")
  (skk-create-file
   skk-study-file
   (if (not nomsg)
       (if skk-japanese-message-and-error
	   "SKK $B$N3X=,7k2L%U%!%$%k$r:n$j$^$7$?(B"
	 "I have created an SKK study file for you")))
  (when (or (null skk-study-alist)
	    force
	    (skk-yes-or-no-p
	     (format "%s $B$r:FFI$_9~$_$7$^$9$+!)(B" skk-study-file)
	     (format "Reread %s?" skk-study-file)))
    (unless nomsg
      (skk-message "%s $B$N(B SKK $B3X=,7k2L$rE83+$7$F$$$^$9(B..."
		   "Expanding SKK study of %s ..."
		   (file-name-nondirectory skk-study-file)))
    (when skk-study-check-alist-format
      (skk-study-check-alist-format skk-study-file))
    (setq skk-study-alist (skk-study-read-1 skk-study-file))
    (setq skk-study-last-read (current-time))
    (when (and skk-study-alist (not nomsg))
      (skk-message
       "%s $B$N(B SKK $B3X=,7k2L$rE83+$7$F$$$^$9(B...$B40N;!*(B"
       "Expanding SKK study of %s ...done"
       (file-name-nondirectory skk-study-file))
      (sit-for 1)
      (message ""))))

(defun skk-study-read-1 (file)
  ;; read FILE and return alist.
  (with-temp-buffer
    (let ((version-string
	   (format ";;; skk-study-file format version %s\n"
		   skk-study-file-format-version)))
      (insert-file-contents-as-coding-system
       (skk-find-coding-system skk-jisyo-code) file)
      (when (= (buffer-size) 0)
	;; bare alist
	(insert version-string "((okuri-ari) (okuri-nasi))"))
      (goto-char (point-min))
      (if (looking-at (regexp-quote version-string))
	  (read (current-buffer))
	(skk-error
	 "skk-study-file $B%U%)!<%^%C%H$N%P!<%8%g%s$,0lCW$7$^$;$s(B"
	 "skk-study-file format version is inconsistent")))))

(defun skk-study-check-alist-format (alist-file)
  "ALIST-FILE $B$NO"A[%j%9%H$N%U%)!<%^%C%H$r%A%'%C%/$9$k!#(B"
  (interactive
   (list (read-file-name
	  (format "Alist file to check: (default: %s) " skk-study-file)
	  default-directory skk-study-file)))
  (skk-message "%s $B%U%!%$%k$NO"A[%j%9%H$N%U%)!<%^%C%H%A%'%C%/$r9T$J$C$F$$$^$9(B..."
	       "Checking %s file alist format..." alist-file)
  (or (skk-study-check-alist-format-1 (skk-study-read-1 alist-file))
      (skk-error "%s $B$NO"A[%j%9%H$N%U%)!<%^%C%H$O2u$l$F$$$^$9(B"
		 "%s alist format is corrupt" alist-file))
  (skk-message
   "%s $B%U%!%$%k$NO"A[%j%9%H$N%U%)!<%^%C%H%A%'%C%/$r9T$J$C$F$$$^$9(B...$B40N;(B!"
   "Checking %s file alist format... done" alist-file)
  (sit-for 1)
  (message ""))

(defun skk-study-check-alist-format-1 (alist)
  (when (and (= (length alist) 2)
	     (assq 'okuri-ari alist)
	     (assq 'okuri-nasi alist))
    (catch 'exit
      (let ((index '(okuri-ari okuri-nasi))
	    (func (function
		   (lambda (str)
		     (let ((len (length str)))
		       (and
			(> len 1)
			(skk-ascii-char-p (aref str (1- len))))))))
	    alist2 e f)
	(while index
	  (and (eq (car index) 'okuri-nasi)
	       (setq func
		     (function
		      (lambda (str)
			(let ((len (length str)))
			  (cond ((= len 1))
				((not (skk-ascii-char-p (aref str (1- len)))))
				((skk-ascii-char-p (aref str (- len 2))))))))))
	  (setq alist2 (cdr (assq (car index) alist)))
	  (while alist2
	    (setq e (car alist2))
	    (or (funcall func (car e))
		;; $B8+=P$78l$N%A%'%C%/(B
		(throw 'exit nil))
	    (setq f (cdr e))
	    (while f
	      (if (not (and
			;; $BD>A0$NJQ49$N>pJs(B
			(consp (car (car f)))
			;; $B4XO"8l%j%9%H(B
			(listp (cdr (car f)))))
		  (throw 'exit nil))
	      (setq f (cdr f)))
	    (setq alist2 (cdr alist2)))
	  (setq index (cdr index)))
	t))))

(defun skk-study-prin1 (form &optional stream)
  (let ((print-readably t)
	print-level print-length print-quoted)
    (prin1 form stream)))

(defun skk-study-chomp (nth list)
  ;; LIST := '(A B C D), NTH := 1
  ;; -> '(A B)
  (and (> nth -1) (setcdr (nthcdr nth list) nil))
  list)

(defadvice skk-kakutei-initialize (before skk-study-ad activate)
  (let ((kakutei-word (ad-get-arg 0)))
    (when kakutei-word
      (ring-insert
       skk-study-data-ring (cons skk-henkan-key kakutei-word)))))

(defadvice skk-undo-kakutei (after skk-study-ad activate)
  (let ((last (ring-ref skk-study-data-ring 0))
	(last2 (ring-ref skk-study-data-ring 1))
	target)
    (when (and last last2)
      (setq target (assoc (car last)
			  (assq (cond ((skk-get-last-henkan-datum 'okuri-char)
				       'okuri-ari)
				      (t 'okuri-nasi))
				skk-study-alist)))
      (setq target (delq (assoc last2 (cdr target)) target)))))

;; time utilities...
;;  from ls-lisp.el.  Welcome!
(defun skk-study-time-lessp (time0 time1)
  (let ((hi0 (car time0))
	(hi1 (car time1))
	(lo0 (nth 1 time0))
	(lo1 (nth 1 time1)))
    (or (< hi0 hi1) (and (= hi0 hi1) (< lo0 lo1)))))

(add-hook 'kill-emacs-hook 'skk-study-save)

(require 'product)
(product-provide (provide 'skk-study) (require 'skk-version))
;;; skk-study.el ends here
