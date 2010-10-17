;;; skk-gadget.el --- $B<B9TJQ49$N$?$a$N%W%m%0%i%`(B -*- coding: iso-2022-jp -*-

;; Copyright (C) 1995, 1996, 1997, 1998, 1999, 2000, 2001
;;   Masahiko Sato <masahiko@kuis.kyoto-u.ac.jp>

;; Author: Masahiko Sato <masahiko@kuis.kyoto-u.ac.jp>
;; Maintainer: SKK Development Team <skk@ring.gr.jp>
;; Version: $Id: skk-gadget.el,v 1.36 2007/04/22 02:38:26 skk-cvs Exp $
;; Keywords: japanese, mule, input method
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

;; $B%W%m%0%i%`<B9TJQ49$H$O(B
;; ======================
;; $BAw$j2>L>$N$J$$<-=q$NJQ49$N8uJd$K(B Emacs Lisp $B$N%3!<%I$,=q$$$F$"$l$P!"(BSKK
;; $B$O$=$N%3!<%I$r(B Lisp $B$N%W%m%0%i%`$H$7$F<B9T$7!"$=$N7k2L$NJ8;zNs$r2hLL$KA^(B
;; $BF~$9$k!#Nc$($P!"<-=q$K(B
;;
;;         now /(current-time-string)/
;;
;; $B$H$$$&9T$,$"$k$H$-!"(B`/now ' $B$H%?%$%W$9$l$P2hLL$K$O8=:_$N;~9o$,I=<($5$l!"(B
;; `$B"'(BFri Apr 10 11:41:43 1992' $B$N$h$&$K$J$k!#(B
;;
;; $B$3$3$G;H$($k(B Lisp $B$N%3!<%I$O2~9T$r4^$s$G$$$J$$$b$N$K8B$i$l$k!#$^$?$3$N%3!<(B
;; $B%I$O7k2L$H$7$FJ8;zNs$rJV$9$b$N$G$J$1$l$P$J$i$J$$!#(B
;;
;; $B$3$N%U%!%$%k$O<B9TJQ49%W%m%0%i%`$r=8$a$?$b$N$G$"$k!#(B
;;
;; skk-gadget.el $B$N(B `gadget' $B$O!V>e<j$/9)IW$7$?F;6q!W$N0UL#!#!V?'!9Ht$S=P$9(B
;; $B5$$N$-$$$?$*$b$A$cH"!W$H$$$&$h$&$J0UL#$GL>IU$1$i$l$?!#(B
;; $BM>CL$@$,!"(BX Window $B$G;HMQ$5$l$k(B `Widget' $B$H$$$&8@MU$O!"(B`window'+`gadget'
;; $B$+$i:n$i$l$?B$8l$i$7$$!#(B

;;; Code:

(eval-when-compile
  (require 'skk-macs)
  (require 'skk-vars)
  (require 'static))

;; -- programs
;;;###autoload
(defun skk-current-date (&optional pp-function format and-time)
  "`current-time-string' $B$N=PNO$r2C9)$7!"8=:_$NF|;~(B \(string\)$B$rJV$9!#(B
$B%*%W%7%g%J%k0z?t$N(B PP-FUNCTION $B$r;XDj$9$k$H!"(B`skk-current-date-1'
$B$NJV$jCM!"(BFORMAT $B$H(B AND-TIME $B$r0z?t$K$7$F(B `funcall' $B$9$k!#(B
PP-FUNCTION $B$N;XDj$,$J$$>l9g$O(B `skk-default-current-date-function' $B$r(B
`funcall' $B$9$k!#(B
FORMAT $B$O(B `format' $B$NBh0l0z?t$NMM<0(B \(string\)$B$K$h$k=PNO;XDj%F%s%W%l!<%H!#(B
AND-TIME \(boolean\) $B$r;XDj$9$k$H;~9o$bJV$9!#(B
`skk-today' $B$H(B `skk-clock' $B$N%5%V%k!<%A%s!#(B"
  (unless pp-function
    (setq pp-function skk-default-current-date-function))
  (funcall pp-function
	   (skk-current-date-1) format (not skk-date-ad) and-time))

(defun skk-current-date-1 (&optional specified-time)
  "`current-time-string' $B$N=PNO$r2C9)$7!"F|IU!&;~9o>pJs$r%j%9%H$K$7$FJV$9!#(B
\(year month day day-of-week hour minute second\)"
  (let* ((str (current-time-string specified-time))
	 (date (substring str 8 10)))
    (when (eq (aref date 0) ?\040)
      (setq date (substring date 1)))
    (list
     (substring str 20 24)
     (substring str 4 7)
     date
     (substring str 0 3)
     (substring str 11 13)
     (substring str 14 16)
     (substring str 17 19))))

;;;###autoload
(defun skk-default-current-date
  (date-information
   format num-type gengo gengo-index month-alist-index dayofweek-alist-index
   &optional and-time)
  "\
$BF|IU>pJs$NI8=`E*$J=PNO$r$9$kB>!"%f!<%6$K$"$kDxEY$N%+%9%?%^%$%:5!G=$rDs6!$9$k!#(B
$B$3$N4X?t$N0z?t$G%+%9%?%^%$%:$G$-$J$$=PNO$r4uK>$9$k>l9g$O!"(B
`skk-default-current-date-function' $B$K<+A0$N4X?t$r;XDj$9$k!#(B

DATE-INFORMATION $B$O(B `current-time-string' $B$,JV$7$?J8;zNs$r(B

  \(year month day day-of-week hour minute second\)

$B$N7A<0$GJQ49$7$?%j%9%H(B \($B3FMWAG$OJ8;zNs(B\)$B!#(B
FORMAT $B$O(B `format' $B$NBh0l0z?t$NMM<0$K$h$k=PNO7ABV$r;XDj$9$kJ8;zNs!#(B
  nil $B$G$"$l$P(B \"%s$BG/(B%s$B7n(B%s$BF|(B\(%s\)%s$B;~(B%s$BJ,(B%s$BIC(B\" \($B$b$7$/$O(B
  \"%s$BG/(B%s$B7n(B%s$BF|(B\(%s\)\" $B$,;H$o$l$k!#(B
NUM-TYPE \(number\) $B$O(B
  0 -> $BL5JQ49(B,
  1 -> $BA43Q?t;z$XJQ49(B,
  2 -> $B4A?t;z$XJQ49(B \($B0L<h$j$J$7(B\),
  3 -> $B4A?t;z$XJQ49(B \($B0L<h$j$r$9$k(B\),
  4 -> $B$=$N?t;z$=$N$b$N$r%-!<$K$7$F<-=q$r:F8!:w(B,
  5 -> $B4A?t;z(B \($B<j7A$J$I$G;HMQ$9$kJ8;z$r;HMQ(B\)$B$XJQ49(B \($B0L<h$j$r$9$k(B\),
  9 -> $B>-4}$G;HMQ$9$k?t;z(B \(\"$B#3;M(B\" $B$J$I(B\) $B$KJQ49(B
GENGO $B$O859fI=<($9$k$+$I$&$+(B \(boolean\)$B!#(B
GENGO-INDEX $B$O(B `skk-gengo-alist' $B$N3FMWAG$N(B cadr $B$r(B 0 $B$H$9$k(B index
 \(number\)$B!#(Bnil $B$G$"$l$P(B `current-time-string' $B$N=PNO$N$^$^L5JQ49!#(B
MONTH-ALIST-INDEX $B$O(B `skk-month-alist' $B$N3FMWAG$N(B cadr $B$r(B 0 $B$H$9$k(B
 index \(number\)$B!#(Bnil $B$G$"$l$P(B `current-time-string' $B$N=PNO$N$^$^L5JQ49!#(B
DAYOFWEEK-ALIST-INDEX $B$O(B `skk-day-of-week-alist' $B$N3FMWAG$N(B cadr $B$r(B
 0 $B$H$9$k(B index \(number\)$B!#(Bnil $B$G$"$l$P(B `current-time-string' $B$N=PNO$N$^(B
$B$^L5JQ49!#(B
AND-TIME $B$O;~9o$bI=<($9$k$+$I$&$+(B \(boolean\)$B!#(B"
  (let ((year (car date-information))
	(month (nth 1 date-information))
	(day (nth 2 date-information))
	(day-of-week (nth 3 date-information))
	(hour (nth 4 date-information))
	(minute (nth 5 date-information))
	(second (nth 6 date-information))
	v)
    (when gengo
      (setq v (skk-ad-to-gengo-1 (string-to-number year))))
    (setq year (if gengo
		   (concat (if gengo-index
			       (nth gengo-index (car v))
			     (car (car v)))
			   (skk-num-exp (number-to-string (cdr v))
					num-type))
		 (skk-num-exp year num-type)))
    (when month-alist-index
      (setq month (skk-num-exp (nth month-alist-index
				    (cdr (assoc month skk-month-alist)))
			       num-type)))
    (setq day (skk-num-exp day num-type))
    (when dayofweek-alist-index
      (setq day-of-week (nth dayofweek-alist-index
			     (cdr (assoc day-of-week skk-day-of-week-alist)))))
    (when and-time
      (setq hour (skk-num-exp hour num-type))
      (setq minute (skk-num-exp minute num-type))
      (setq second (skk-num-exp second num-type)))
    (if and-time
	(format (or format "%s$BG/(B%s$B7n(B%s$BF|(B(%s)%s$B;~(B%s$BJ,(B%s$BIC(B")
		year month day day-of-week hour minute second)
      (format (or format "%s$BG/(B%s$B7n(B%s$BF|(B(%s)") year month day day-of-week))))

;;;###autoload
(defun skk-today (arg)
  "\
`current-time-string' $B$N=PNO$r2C9)$7!"8=:_$NF|;~$rI=$9J8;zNs$r:n$j!"A^F~$9$k!#(B
$B<B<AE*$K(B today $B%(%s%H%j$N8F=P$7$J$N$G!"8D?M<-=q$N(B today $B%(%s%H%j$K$h$j%+%9%?%^(B
$B%$%:$9$k$3$H$,$G$-$k!#(B"
  (interactive "p")
  (unless skk-mode
    (skk-mode 1))
  (skk-set-henkan-point-subr)
  (insert "today")
  (skk-start-henkan arg))

;;;###autoload
(defun skk-clock (&optional kakutei-when-quit time-signal)
  "$B%G%8%?%k;~7W$r%_%K%P%C%U%!$KI=<($9$k!#(B
quit $B$9$k$H$=$N;~E@$NF|;~$r8uJd$H$7$FA^F~$9$k!#(B
quit $B$7$?$H$-$K5/F0$7$F$+$i$N7P2a;~4V$r%_%K%P%C%U%!$KI=<($9$k!#(B
interactive $B$K5/F0$9$kB>!"(B\"clock /(skk-clock)/\" $B$J$I$N%(%s%H%j$r(B SKK $B$N<-=q(B
$B$K2C$(!"(B\"/clock\"+ SPC $B$GJQ49$9$k$3$H$K$h$C$F$b5/F02D!#(BC-g $B$G;_$^$k!#(B
$B<B9TJQ49$G5/F0$7$?>l9g$O!"(BC-g $B$7$?;~E@$N;~E@$NF|;~$rA^F~$9$k!#(B
$B%*%W%7%g%J%k0z?t$N(B KAKUTEI-WHEN-QUIT $B$,(B non-nil $B$G$"$l$P(B C-g $B$7$?$H$-$K3N(B
$BDj$9$k!#(B
$B%*%W%7%g%J%k0z?t$N(B TIME-SIGNAL $B$,(B non-nil $B$G$"$l$P!"(BNTT $B$N;~JsIw$K(B ding $B$9$k!#(B
$B$=$l$>$l(B \"clock /(skk-clock nil t)/\" $B$N$h$&$J%(%s%H%j$r<-=q$KA^F~$9$l$PNI$$!#(B
skk-date-ad $B$H(B skk-number-style $B$K$h$C$FI=<(J}K!$N%+%9%?%^%$%:$,2DG=!#(B"
  (interactive "*")
  (let ((start (current-time))
	end
	mes
	expr1 expr2
	sec
	snd)
    (cond
     ((or (not skk-number-style)
	  (eq skk-number-style 0))
      (setq expr1 "[789]$BIC(B"
	    expr2 "0$BIC(B"))
     ((or (eq skk-number-style t)
	  ;; skk-number-style $B$K(B $B?t;z$H(B t $B0J30$N(B non-nil $BCM$rF~$l$F$$$k>l(B
	  ;; $B9g!"(B= $B$r;H$&$H(B Wrong type argument: number-or-marker-p, xxxx
	  ;; $B$K$J$C$F$7$^$&!#(B
	  (eq skk-number-style 1))
      (setq expr1 "[$B#7#8#9(B]$BIC(B"
	    expr2 "$B#0IC(B"))
     (t
      (setq expr1 "[$B<7H,6e(B]$BIC(B"
	    expr2 "$B!;IC(B")))
    ;;
    (static-when (eq skk-emacs-type 'xemacs)
      ;; XEmacs $B$G(B sound $B$,%m!<%I$5$l$F$$$k$+$I$&$+!#(B
      (when (setq snd
		  (and (boundp 'sound-alist)
		       (eq t (catch 'tag
			       (mapc
				#'(lambda (list)
				    (when (eq 'drum (cadr (memq :sound list)))
				      (throw 'tag t)))
				sound-alist)))))
	(unless (assq 'clink sound-alist)
	  (load-sound-file "clink" 'clink))))
    ;;
    (save-match-data
      (condition-case nil
	  (let (case-fold-search
		inhibit-quit
		visible-bell)
	    (while (not quit-flag)
	      (setq mes (skk-current-date nil nil t)
		    sec 0)
	      (message "%s    Hit any key to quit" mes)
	      (when time-signal
		(cond
		 ((string-match expr1 mes)
		  ;; [7890] $B$N$h$&$K@55,I=8=$r;H$o$:!"(B7 $B$@$1$GA4$F$N%^%7%s$,(B
		  ;; $BCe$$$F$f$1$PNI$$$N$@$,(B...$B!#CzEY$3$N4X?t<B9T;~$K(B Garbage
		  ;; collection $B$,8F$P$l$F$bI=<($5$l$k?t;z$,Ht$V>l9g$,$"$k!#(B
		  (skk-ding nil 'drum))
		 ((string-match expr2 mes)
		  ;; 0 $B$@$1!V%]!A%s!W$H$$$-$?$$$H$3$m$G$9$,!"%^%7%s$K$h$C(B
		  ;; $B$F:9$,$"$k!#(B
		  ;; 386SX 25Mhz + Mule-2.x $B$@$H!V%T%C!"%T%C!W$H$$$&46$8!#(B
		  ;; $BIU$$$F$f$/$N$,Hs>o$K?I$$!#(B68LC040 33Mhz + NEmacs $B$@$H(B
		  ;; $B!V%T%T%C!W$H$J$j!"2;$N%?%$%_%s%0$ONI$$$N$@$,!"$H$-(B
		  ;; $B$I$-(B 1 $BICJ,$D$$$F$$$1$J$/$J$k!#(BPentium 90Mhz +
		  ;; Mule-2.x$B$@$H!V%T%C!W$H$$$&C12;$K$J$C$F$7$^$&(B... (;_;)$B!#(B
		  (if snd
		      (skk-ding nil 'clink)
		    (ding)
		    (unless (skk-sit-for (setq sec (+ sec 0.16))
					 'nodisplay)
		      (next-command-event)
		      (signal 'quit nil))
		    (ding)))))
	      (unless (skk-sit-for (- 1 sec) 'nodisplay)
		(next-command-event)
		(signal 'quit nil))))
	(quit
	 (prog2
	     (setq end (current-time))
	     (skk-current-date nil nil t)
	   (when kakutei-when-quit
	     (setq skk-kakutei-flag t))
	   (message "$B7P2a;~4V(B: %s $BIC(B"
		    (skk-time-difference start end))))))))

;;;###autoload
(defun skk-ad-to-gengo (gengo-index &optional divider tail not-gannen)
  ;; $B@>Nq$r859f$KJQ49$9$k!#%*%W%7%g%s0z?t$N(B divider $B$,;XDj$5$l$F$$$l$P!"G/9f$H(B
  ;; $B?t;z$N4V$K!"(Btail $B$,;XDj$5$l$F$$$l$P!"?t;z$NKvHx$K!"$=$l$>$l$NJ8;zNs$rO"7k(B
  ;; $B$9$k!#(B
  ;; $B<-=q8+=P$7Nc(B;
  ;; $B$;$$$l$-(B#$B$M$s(B /(skk-ad-to-gengo 0 nil "$BG/(B")/(skk-ad-to-gengo 0 " " " $BG/(B")/
  (let ((v (skk-ad-to-gengo-1 (string-to-number
			       (car skk-num-list))
			      not-gannen)))
    (concat (nth gengo-index (car v))
	    divider
	    (if (not (stringp (cdr v)))
		(number-to-string (cdr v))
	      (cdr v))
	    tail)))

;;;###autoload
(defun skk-ad-to-gengo-1 (ad &optional not-gannen)
  ;; AD is a number and NOT-GANNEN is a boolean optional
  ;; arg.
  ;; return a cons cell of which car is a Gengo list
  ;; gotten from `skk-gengo-alist', and cdr is a number
  ;; of year.
  ;; if NOT-GANNEN is non-nil and calculated year is 1,
  ;; return a value of which cdr is "$B85(B" (string).
  (when (>= 1866 ad)
    (skk-error "$BJ,$j$^$;$s(B" "Unkown year"))
  (cons (cond ((>= 1911 ad)
	       (setq ad (- ad 1867))
	       (cdr (assq 'meiji skk-gengo-alist)))
	      ((>= 1925 ad)
	       (setq ad (- ad 1911))
	       (cdr (assq 'taisho skk-gengo-alist)))
	      ((>= 1988 ad)
	       (setq ad (- ad 1925))
	       (cdr (assq 'showa skk-gengo-alist)))
	      (t
	       (setq ad (- ad 1988))
	       (cdr (assq 'heisei skk-gengo-alist))))
	(cond (not-gannen ad)
	      ((= ad 1) "$B85(B")
	      (t ad))))

;;;###autoload
(defun skk-gengo-to-ad (&optional head tail)
  ;; $B859f$r@>Nq$KJQ49$9$k!#%*%W%7%g%s0z?t$N(B HEAD, TAIL $B$,;XDj$5$l$F$$(B
  ;; $B$l$P!"$=$NJ8;zNs$r@hF,!"KvHx$KO"7k$9$k!#(B
  ;; $B<-=q8+=P$7Nc(B;
  ;;   $B$7$g$&$o(B#$B$M$s(B /(skk-gengo-to-ad "" "$BG/(B")/(skk-gengo-to-ad "" " $BG/(B")/\
  ;;   (skk-gengo-to-ad "$B@>Nq(B" "$BG/(B")/(skk-gengo-to-ad "$B@>Nq(B" " $BG/(B")/
  (save-match-data
    (when (string-match (car skk-num-list)
			skk-henkan-key)
      (let ((v (skk-gengo-to-ad-1
		(substring skk-henkan-key 0 (match-beginning 0))
		(string-to-number (car skk-num-list)))))
	(when v
	  (concat head
		  (number-to-string v)
		  tail))))))

;;;###autoload
(defun skk-gengo-to-ad-1 (gengo number)
  ;; GENGO is a string and NUMBER is a number.
  ;; return a year (number) equal to GENGO-NUMBER.
  (+ number
     (cond
      ((eq number 0)
       (skk-error "0 $BG/$O$"$jF@$J$$(B"
		  "Cannot convert 0 year"))
      ((member gengo '("$B$X$$$;$$(B" "$BJ?@.(B"))
       1988)
      ((member gengo '("$B$7$g$&$o(B" "$B><OB(B"))
       (if (> 64 number)
	   1925
	 (skk-error "$B><OB$O(B 63 $BG/$^$G$G$9(B"
		    "The last year of Showa is 63")))
      ((member gengo '("$B$?$$$7$g$&(B" "$BBg@5(B"))
       (if (> 15 number)
	   1911
	 (skk-error "$BBg@5$O(B 14 $BG/$^$G$G$9(B"
		    "The last year of Taisyo is 14")))
      ((member gengo '("$B$a$$$8(B" "$BL@<#(B"))
       (if (> 45 number)
	   1867
	 (skk-error "$BL@<#$O(B 44 $BG/$^$G$G$9(B"
		    "The last year of Meiji is 44")))
      (t
       (skk-error "$BH=JLITG=$J859f$G$9!*(B"
		  "Unknown Gengo!")))))

;;;###autoload
(defun skk-calc (operator)
  ;; 2 $B$D$N0z?t$r<h$C$F(B operator $B$N7W;;$r$9$k!#(B
  ;; $BCm0U(B: '/ $B$O0z?t$H$7$FEO$;$J$$$N$G(B (defalias 'div '/) $B$J$I$H$7!"JL$N7A$G(B
  ;; skk-calc $B$KEO$9!#(B
  ;; $B<-=q8+=P$7Nc(B; #*# /(skk-calc '*)/
  (number-to-string (apply operator
			   (mapcar 'string-to-number
				   skk-num-list))))

;;;###autoload
(defun skk-plus ()
  ;; $B<-=q8+=P$7Nc(B; #+#+# /(skk-plus)/
  (skk-calc '+))

;;;###autoload
(defun skk-minus ()
  (skk-calc '-))

;;;###autoload
(defun skk-times ()
  (skk-calc '*))

;;;###autoload
(defun skk-ignore-dic-word (&rest no-show-list)
  ;; $B6&MQ<-=q$KEPO?$5$l$F$$$k!"0c$C$F$$$k(B/$B5$$KF~$i$J$$JQ49$r=P$5$J$$$h$&$K$9(B
  ;; $B$k!#(B
  ;; $B<-=q8+=P$7Nc(B;
  ;;   $B$k$9$P$s(B /$BN1<iHV(B/(skk-ignore-dic-word "$BN1<iEE(B")/
  ;;   $B$+$/$F$$(B /(skk-ignore-dic-word "$B3NDj(B")/
  (let (new-word save-okurigana)
    ;; skk-ignore-dic-word $B<+?H$N%(%s%H%j$r>C$9!#>C$9$Y$-8uJd$O(B
    ;; skk-henkan-list $B$+$iD>@\Cj=P$7$F$$$k$N$G(B delete $B$G$O$J$/(B delq $B$G==J,!#(B
    (setq skk-henkan-list (delq (nth skk-henkan-count skk-henkan-list)
				skk-henkan-list))
    ;; $BA48uJd$r(B skk-henkan-list $B$KF~$l$k!#(B
    (while skk-current-search-prog-list
      (setq skk-henkan-list (skk-nunion skk-henkan-list (skk-search))))
    ;; $BITMW$J8uJd$r<N$F$k!#(B
    (while no-show-list
      (setq skk-henkan-list (delete (car no-show-list) skk-henkan-list)
	    no-show-list (cdr no-show-list)))
    ;; $B%+%l%s%H$N8uJd(B (skk-ignore-dic-word $B<+?H$N%(%s%H%j(B) $B$r>C$7$?$N$G!"(B
    ;; skk-henkan-count $B$O<!$N8uJd$r;X$7$F$$$k!#(B
    (setq new-word (or (nth skk-henkan-count skk-henkan-list)
		       (progn
			 (setq save-okurigana skk-okuri-char)
			 (skk-henkan-in-minibuff))))
    ;; $B8uJd$,$J$$$H$-!#(B
    (unless new-word
      ;; $B6uJ8;zNs$,EPO?$5$l$?$i<-=qEPO?$NA0$N>uBV$KLa$9!#(B
      ;; (nth -1 '(A B C)) $B$O!"(BA $B$rJV$9$N$G!"(Bn $B$,Ii$N?t$G$J$$$3$H$r%A%'%C%/(B
      ;; $B$7$F$*$/I,MW$,$"$k!#(B
      (if (> skk-henkan-count 0)
	  (setq skk-henkan-count (- skk-henkan-count 1)
		new-word (nth skk-henkan-count skk-henkan-list))
	;; (1- skk-henkan-count) == -1 $B$K$J$k!#"&%b!<%I$KLa$9!#(B
	(throw 'next-word 'none)))
    ;;
    (throw 'next-word new-word)))

;;;###autoload
(defun skk-henkan-face-off-and-remove-itself ()
  ;; skk-insert-new-word-function $B$K%;%C%H$9$k$?$a$N4X?t!#%+%l%s%H%P%C%U%!$N(B
  ;; $BJQ49ItJ,$,(B Overlay $B$N(B face $BB0@-$K$h$C$FI=<($,JQ99$5$l$F$$$k$N$rLa$7!"$=$N(B
  ;; $B8e<+J,<+?H$r(B skk-insert-new-word-function $B$+$i<h$j=|$/<+Gz4X?t!#(B
  (skk-henkan-face-off)
  (setq skk-insert-new-word-function nil))

;;;###autoload
(defun skk-gadget-units-conversion (unit-from number unit-to)
  "`skk-units-alist'$B$r;2>H$7!"49;;$r9T$J$&!#(B
NUMBER $B$K$D$$$F(B UNIT-FROM $B$+$i(B UNIT-TO $B$X$N49;;$r9T$J$&!#(B"
  (let ((v (assoc unit-to
		  (cdr (assoc unit-from skk-units-alist)))))
    (when v
      (concat (number-to-string (* number (cdr v)))
	      (car v)))))

(run-hooks 'skk-gadget-load-hook)

(require 'product)
(product-provide
    (provide 'skk-gadget)
  (require 'skk-version))

;;; skk-gadget.el ends here
