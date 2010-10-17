;;; skk-annotation.el --- SKK annotation $B4XO"%W%m%0%i%`(B -*- coding: iso-2022-jp -*-

;; Copyright (C) 2000, 2001 NAKAJIMA Mikio <minakaji@osaka.email.ne.jp>
;; Copyright (C) 2000-2008  SKK Development Team <skk@ring.gr.jp>

;; Author: NAKAJIMA Mikio <minakaji@osaka.email.ne.jp>
;; Maintainer: SKK Development Team <skk@ring.gr.jp>
;; Version: $Id: skk-annotation.el,v 1.138 2008/09/15 14:34:04 skk-cvs Exp $
;; Keywords: japanese, mule, input method
;; Created: Oct. 27, 2000.
;; Last Modified: $Date: 2008/09/15 14:34:04 $

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

;; $B$3$l$O!"(BSKK $B8D?M<-=q$KIU$1$?%"%N%F!<%7%g%s(B ($BCp<a(B) $B$r3hMQ$9$k%W%m%0(B
;; $B%i%`$G$9!#(B
;;
;; <INSTALL>
;;
;; SKK $B$rIaDL$K(B make $B$7$F2<$5$$!#FC$K:n6H$OITMW$G$9!#(B
;;
;;
;; <HOW TO USE>
;;
;;   (setq skk-show-annotation t)
;;
;; $B$H(B ~/.emacs $B$K=q$-$^$7$g$&!#<-=q$N8uJd$K(B `;' $B$+$i;O$^$kJ8;zNs$,$"$l(B
;; $B$P!"$=$N3:Ev$N8uJd$,JQ49$5$l$F%P%C%U%!$K=PNO$5$l$?:]!"(B`;' $B0J9_$r$=(B
;; $B$N8uJd$N%"%N%F!<%7%g%s$H$7$F%(%3!<%(%j%"$KI=<($7$^$9!#(B
;;
;;   (setq skk-annotation-show-as-message nil)
;;
;; $B$H(B ~/.emacs $B$K=q$$$?>l9g$O!"(Bother-window $B$r0l;~E*$K3+$$$F%"%N%F!<%7%g(B
;; $B%s$rI=<($7$^$9!#(Bother-window $B$O$=$N8uJd$K$D$$$F3NDj$9$k$+!"$=$N8uJd(B
;; $B$NA*Br$r;_$a$k(B ($B<!$N8uJd$rA*Br$7$?$j!"(Bquit $B$7$?$j(B) $B$9$k$H<+F0E*$KJD(B
;; $B$8$i$l$^$9!#(B
;;
;; SKK $B$G$O(B 5 $BHVL\$N8uJd0J9_$r%(%3!<%(%j%"$r;H$C$FI=<($7$^$9!#=>$$!"(B5
;; $BHVL\0J9_$N8uJd$K$D$$$F$O!"(Bskk-annotation-show-as-message $B$,(B t $B$G$b(B
;; $B%&%#%s%I%&$r3+$$$F%"%N%F!<%7%g%s$rI=<($7$^$9!#(B
;;
;; $B$"$kC18l$K$D$$$F!"%"%N%F!<%7%g%s$rIU$1$?$$$H$-$O!"3NDj$7$?D>8e$KF1(B
;; $B$8%P%C%U%!$G(B
;;
;;   M-x skk-annotation-add
;;
;; $B$7$^$7$g$&!#%"%N%F!<%7%g%s$rJT=8$9$k%P%C%U%!$,3+$$$F!"%+%l%s%H%P%C(B
;; $B%U%!$K$J$j$^$9$N$G!"$=$3$X%"%N%F!<%7%g%s$rIU$1$^$7$g$&!#(B
;; 1 $B9T$G$"$kI,MW$O$"$j$^$;$s$,!"J#?t9T$N%"%N%F!<%7%g%s$rIU$1$k$H(B echo
;; area $B$XI=<($5$l$?$H$-$KA4BN$,8+$($J$/$J$j$^$9!#(B
;; $B$^$?!"(B`;' $B$NJ8;z<+BN$OF~$l$kI,MW$O$"$j$^$;$s!#(B
;; $B:#$^$G$K4{$KIU$1$F$$$?%"%N%F!<%7%g%s$,$"$l$PJT=8%P%C%U%!$,I=<($5$l(B
;; $B$?$H$-$K$=$N%"%N%F!<%7%g%s$,(B prefix $BE*$K=PNO$5$l$^$9!#4{B8$N%"%N%F!<(B
;; $B%7%g%s$b4^$a$FJT=8$7$F2<$5$$!#%P%C%U%!$N@hF,9T$r=|$$$FA4$F$N9T$,?7(B
;; $B$7$$%"%N%F!<%7%g%s$H$7$F>e=q$-$5$l$^$9!#(B
;; $BJT=8$,=*$o$C$?$i(B C-c C-c $B$7$^$7$g$&!#(B
;;
;; $B>e5-$NF0:n$G%f!<%6$,IU$1$?%"%N%F!<%7%g%s$r!V%f!<%6%"%N%F!<%7%g%s!W(B
;; $B$H8F$S$^$9!#%f!<%6%"%N%F!<%7%g%s$O!"(B
;;
;;   $B!V$-$+$s(B /$B4|4V(B/$B5!4X(B;*$B5!4XEj;q2H(B/$B4p44(B;*$B4p446HL3(B/$B!W(B
;;
;; $B$N$h$&$K(B `;' $B$ND>8e$K(B `*' $B$NJ8;z$,<+F0E*$K?6$i$l$^$9!#$3$l$O%f!<%6(B
;; $B$,FH<+$KIU$1$?%"%N%F!<%7%g%s$G$"$k$3$H$r<($7$^$9(B (`*' $B$NJ8;z$OJQ49(B
;; $B;~$K$OI=<($5$l$^$;$s(B)$B!#(B
;;
;; $B0lJ}!"6&M-<-=q$K85!9IU$1$i$l$F$$$k%"%N%F!<%7%g%s$r!V%7%9%F%`%"%N%F!<(B
;; $B%7%g%s!W$H8F$S!"$3$l$O(B `;' $B$ND>8e$K(B `*' $B$NJ8;z$rH<$J$$$^$;$s!#(B
;; <$BNc(B>
;;    $B!V$$$<$s(B /$B0JA0(B;previous/$B0MA3(B;still/$B!W(B
;;
;; $B%f!<%6%"%N%F!<%7%g%s$H%7%9%F%`%"%N%F!<%7%g%s$r6hJL$9$k$3$H$G!"%f!<(B
;; $B%6%"%N%F!<%7%g%s$@$1$rI=<($7$?$j!"$"$k$$$O$=$N5U$r9T$J$&$3$H$,2DG=(B
;; $B$G$9!#(B`skk-annotation-function' $B$KI=<($7$?$$%"%N%F!<%7%g%s$r(B
;; non-nil $B$HH=Dj$9$k4X?t$r=q$-$^$7$g$&!#$3$s$J46$8$G$9!#(B
;;
;;   (setq skk-annotation-function
;;         (lambda (annotation) (eq (aref annotation 0) ?*)))
;;
;; $B>e5-$NNc$G$O!"%"%N%F!<%7%g%s$N@hF,$,(B `*' $B$G;O$^$k!V%f!<%6%"%N%F!<%7%g(B
;; $B%s!W$N>l9g$K(B t $B$rJV$7$^$9$N$G!"%f!<%6%"%N%F!<%7%g%s$@$1$rI=<($7$^$9!#(B
;;
;; M-x skk-annotation-add $B$7$?$b$N$N!"7k6I%"%N%F!<%7%g%s$rIU$1$:$KCV$-(B
;; $B$?$$$H$-$O!"(B
;;
;;   M-x skk-annotation-kill
;;
;; $B$7$F2<$5$$!#(B
;;
;; $B$^$?!":G8e$K3NDj$7$?8uJd$K$D$$$F$N%"%N%F!<%7%g%s$r<h$j5n$j$?$$$H$-(B
;; $B$O!"(B
;;
;;   M-x skk-annotation-remove
;;
;; $B$7$F2<$5$$!#(B
;;
;; Viper $BBP:v$O$^$@9T$J$C$F$$$^$;$s!#(B~/.viper $B$K<!$N$h$&$K=q$$$F2<$5$$!#(B
;; (viper-harness-minor-mode "skk-annotation")
;;
;; <Wikipedia $B%"%N%F!<%7%g%s(B>
;;
;; $B"'%b!<%I$K$F(B C-i $B$r%?%$%W$9$k$H!"I=<(Cf$N8uJd$r(B Wikipedia/Wiktionary
;; $B$N9`L\$+$iC5$7!$8+$D$+$C$?>l9g$O!"FbMF$NH4?h$r%"%N%F!<%7%g%s$H$7$FI=<((B
;; $B$7$^$9!#$3$N5!G=$O(B Emacs 22 $B$G%F%9%H$5$l$F$$$^$9!#(BXEmacs 21.5 $B$G$O0J2<(B
;; $B$N(B 1 $B$H(B 2 $B$rF3F~$9$kI,MW$,$"$j$^$9!#(BXEmacs 21.4 $B$G$O99$K(B 3 $B$bI,MW$G$9!#(B
;; Emacs 21.4 $B$G$b(B 1, 2, 3 $B$,I,MW$H$J$j$^$9!#(BEmacs 20.7 $B$G$NF0:n$O%5%]!<%H(B
;; $B$7$^$;$s$,!"(BMULE 4.1 $B%Q%C%A$rEv$F$F$$$l$P(B Emacs 21 $B$HF1MM$KF0:n$9$k2DG=(B
;; $B@-$,$"$j$^$9!#(B
;;
;; 1. html2text.el
;;
;;    $B$3$l$OHf3SE*:G6a$N(B gnus $B$K4^$^$l$F$$$^$9!#$7$+$7(B
;;
;;    http://www.ring.gr.jp/archives/elisp/gnus/gnus-5.10.8.tar.gz
;;
;;    $B$K4^$^$l$k%P!<%8%g%s$G$O%(%i!<$rH/@8$9$k2DG=@-$,$"$j$^$9!#(B
;;
;;    $B$b$7(B Wikipedia/Wiktionary $B8!:w$N:]$K%(%i!<$,=P$k$h$&$G$7$?$i!"(B
;;    html2text.el $B$@$13+H/HG(B No Gnus (ngnus) v0.6 $B0J>e$N$b$N$K:9$7BX$($k(B
;;    $BI,MW$,$"$j$^$9!#(B
;;
;;    http://www.ring.gr.jp/archives/elisp/gnus/snapshots/
;;
;;    $B$^$?$O(B CVS $B$h$j:G?7HG$r%$%s%9%H!<%k$7$F$/$@$5$$!#$^$?!"(BEmacs 22.1 $B$K(B
;;    $BIUB0$9$k(B Gnus 5.11 $B$G$O$3$NLdBj$O=$@5$5$l$F$$$^$9!#(B
;;
;; 2. URL $B%Q%C%1!<%8(B
;;
;;    $B$3$l$O(B Emacs/W3 $B$K4^$^$l$F$$$?$b$N$N3HD%$G$9!#Nc$($P(B
;;
;;    http://ftp.debian.org/debian/pool/main/w/w3-url-e21/
;;
;;    $B$J$I$+$i:G?7(B *.orig.tar.gz $B$r<hF@$7$F%$%s%9%H!<%k$7$^$9!#(B
;;
;;    XEmacs $B$N>l9g!"(B xemacs-sumo $BCf$N(B w3 $B$K4^$^$l$k(B url.el $B$,FI$_9~$^$l$F$7$^(B
;;    $B$&$H@5$7$/5!G=$7$J$$$N$G!"Cm0U$7$F$/$@$5$$!#(B
;;
;; 3. Mule-UCS
;;
;;    UTF-8 $B$N<h$j07$$$KI,MW$H$J$j$^$9!#(B
;;
;;    http://www.meadowy.org/~shirai/
;;
;;    $B$+$i:G?7HG$,F~<j$G$-$^$9!#(B
;;
;; <$B5l$$(B SKK $B$+$i$N0\9T(B>
;;
;; $B$3$N9`$O%"%N%F!<%7%g%s5!G=$,$J$$5l$$(B SKK (DDSKK 11.2 $B0JA0$^$?$O(B SKK
;; 10.62 $B0JA0(B) $B$+$i:G?7$N$b$N$K0\9T$9$k>l9g$NCm0U;v9`$G$9!#(B
;;
;; $B%"%N%F!<%7%g%s$O%;%Q%l!<%?$H$7$F(B `;' $B$r;HMQ$7$F$$$k$?$a!"(B`;' $B$NJ8;z(B
;; $B$r4^$s$@8uJd$O!"(Beval $B$9$k$H(B `;' $B$K$J$k(B Lisp $B<0$H$7$F(B quote $B$7<-=q8u(B
;; $BJd$K<}$a$kI,MW$,$"$j$^$9!#(B
;;
;; $B$^$@%"%N%F!<%7%g%s5!G=$r0lEY$b;HMQ$7$F$$$J$$8D?M<-=q$K$D$$$F$O!"0J2<(B
;; $B$N(B S $B<0$rI>2A$7$?8e!"(B
;;
;;   (defun skk-annotation-update-jisyo-format ()
;;     (interactive)
;;     (skk-setup-jisyo-buffer)
;;     (let ((min skk-okuri-ari-min) (max skk-okuri-ari-max))
;;       (skk-annotation-update-jisyo-format-1 min max)
;;       (setq min skk-okuri-nasi-min
;;	     max (point-max))
;;       (skk-annotation-update-jisyo-format-1 min max)))
;;
;;   (defun skk-annotation-update-jisyo-format-1 (min max)
;;     (let (candidate)
;;       (goto-char min)
;;       (while (re-search-forward "\\/\\([^\n/]*;[^\n/]*\\)\\/" max t nil)
;;	 (setq candidate (buffer-substring-no-properties
;;			  (match-beginning 1) (match-end 1)))
;;	 (delete-region (match-beginning 1) (match-end 1))
;;	 (goto-char (match-beginning 1))
;;	 (insert
;;	  (concat "(concat \""
;;		  (mapconcat
;;		   (function
;;		    (lambda (c)
;;		      (if (eq c ?\;)
;;			  "\\073"
;;			(char-to-string c))))
;;		   (append candidate nil) "")
;;		  "\")")))))
;;
;; $B8D?M<-=q$rFI$_$3$_!"<-=q$rFI$_9~$s$@%P%C%U%!$G(B
;;
;;   M-x skk-annotation-update-jisyo-format
;;
;; $B$9$k$3$H$G$3$N:n6H$r9T$J$&$3$H$,$G$-$^$9!#(B
;;
;; $BC"$7!"4{$K%"%N%F!<%7%g%s$,IU$1$i$l$F$$$k>l9g$O!"$3$N%"%N%F!<%7%g%s(B
;; $B<+BN$b8uJd$H6hJL$G$-$:$K(B quote $B$5$l$F$7$^$$$^$9$N$G!"$4Cm0U2<$5$$(B
;; ($B:#$N$H$3$m<j:n6H$G(B quote $B$5$l$J$$$h$&$KB`Hr$9$k$J$I$7$+J}K!$O$"$j(B
;; $B$^$;$s(B)$B!#(B

;;; Code:

(eval-and-compile
  (require 'skk-macs)
  (require 'skk-vars)

  (autoload 'html2text "html2text")
  (autoload 'html2text-delete-tags "html2text")
  (autoload 'url-hexify-string "url-util")
  (autoload 'url-retrieve "url"))

(eval-when-compile
  (require 'static)

  (defvar mule-version)
  (defvar html2text-remove-tag-list)
  (defvar html2text-format-tag-list)

  (when (and (string-match "^GNU" (emacs-version))
	     (= emacs-major-version 20))
    (defalias 'skk-tooltip-show-at-point 'ignore)))

(static-when (eq skk-emacs-type 'xemacs)
  (require 'skk-xemacs))

(unless skk-annotation-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-c\C-c" 'skk-annotation-save-and-quit)
    (define-key map "\C-c\C-k" 'skk-annotation-kill)
    (setq skk-annotation-mode-map map)))

(unless (assq 'skk-annotation-mode minor-mode-alist)
  (setq minor-mode-alist (cons '(skk-annotation-mode " annotation")
			       minor-mode-alist)))

(when (and (boundp 'minor-mode-map-alist)
	   (not (assq 'skk-annotation-mode-map minor-mode-map-alist)))
  (setq minor-mode-map-alist
	(cons (cons 'skk-annotation-mode skk-annotation-mode-map)
	      minor-mode-map-alist)))

;; inline functions.
(defsubst skk-annotation-erase-buffer ()
  (let ((inhibit-read-only t)
	buffer-read-only)
    (static-when
	(fboundp 'set-text-properties)
      (set-text-properties (point-min) (point-max) nil))
    (erase-buffer)))

(defsubst skk-annotation-insert (annotation)
  (with-current-buffer (get-buffer-create skk-annotation-buffer)
    (skk-annotation-erase-buffer)
    (insert annotation)
    (goto-char (point-min))))

;; functions.
;;;###autoload
(defun skk-annotation-get (annotation)
  (if (string= annotation "")
      ""
    (if (eq (aref annotation 0) ?*)
	(substring annotation 1)
      annotation)))

;;;###autoload
(defun skk-annotation-find-and-show (pair)
  ;; $B%_%K%P%C%U%!$K$$$k$H$-M>7W$J%a%C%;!<%8$r%/%j%"$9$k(B
  (when (or skk-isearch-switch
	    (skk-in-minibuffer-p))
    (message nil))
  ;;
  (when (and (car-safe pair)
	     (not (cdr-safe pair)))
    ;; Wikipedia $B$N(B URL $BMxMQ$N>l9g$O$3$3$GCm<a$r@_Dj$9$k!#(B
    (setcdr pair (or (car (skk-annotation-wikipedia-cache (car pair)))
		     (when skk-annotation-show-wikipedia-url
		       (skk-annotation-treat-wikipedia (car pair))))))
  (skk-annotation-show (or (cdr pair) "") (car pair)))

;;;###autoload
(defun skk-annotation-show (annotation &optional word sources)
  (when (and (not skk-kakutei-flag)
	     (or (not skk-annotation-function)
		 (funcall skk-annotation-function annotation)))
    (setq annotation (skk-annotation-get annotation))
    (let ((notes (mapcar #'skk-eval-string (split-string annotation ";")))
	  (inhibit-wait skk-isearch-switch))
      (setq annotation (skk-eval-string annotation))
      (unless (string= annotation "")
	(setq inhibit-wait (skk-annotation-show-2 annotation)))
      ;; $BCm<a$NI=<($O$3$3$^$G$@$,!"$3$3$G%f!<%6$,Cm<a$NFbMF$r%3%T!<$7$?$j(B
      ;; $B$7$FMxMQ$G$-$k$h$&$K$9$k!#(B
      (unless inhibit-wait
	(skk-annotation-wait-for-input annotation notes word sources)))))

(defun skk-annotation-show-2 (annotation)
  (let (inhibit-wait)
    (cond (skk-isearch-switch
	   ;; do nothing
	   (setq inhibit-wait t))
	  ((and (not (skk-annotation-display-p 'minibuf))
		(skk-in-minibuffer-p))
	   ;; do nothing
	   (setq inhibit-wait t))
	  ((and window-system skk-show-tooltip)
	   (skk-tooltip-show-at-point annotation 'annotation))
	  ((and skk-annotation-show-as-message
		(not (or skk-isearch-switch
			 (skk-in-minibuffer-p))))
	   (skk-annotation-show-as-message annotation))
	  (t
	   (skk-annotation-show-buffer annotation)))
    inhibit-wait))

(defun skk-annotation-wait-for-input (annotation notes &optional word sources)
  (let* ((copy-command (key-binding skk-annotation-copy-key))
	 (browse-command (key-binding skk-annotation-browse-key))
	 (list (list copy-command browse-command))
	 event key command urls note cache char digit)
    (while (and list
		(or (eq this-command 'skk-annotation-wikipedia-region)
		    (eq skk-henkan-mode 'active))
		(if digit
		    t
		  (skk-annotation-message (if (and annotation
						   (> (length annotation) 0))
					      'annotation
					    nil)))
		(condition-case nil
		    (progn
		      (setq event (next-command-event)
			    key (skk-event-key event)
			    command (key-binding
				     (static-if (featurep 'xemacs)
					 event
				       key)))
		      ;; Return value of the following expression is important.
		      (or (memq command list)
			  (eq command 'digit-argument)
			  (eq command 'skk-annotation-wikipedia-region)
			  (equal (key-description key)
				 (key-description
				  skk-annotation-wikipedia-key))))
		  (quit
		   (static-when
		       (and (featurep 'xemacs)
			    (= emacs-major-version 21)
			    (<= emacs-minor-version 4))
		     ;; workaround
		     (keyboard-quit)))))
      (cond ((eq command copy-command)
	     (setq list (delq copy-command list))
	     (unless (equal annotation "")
	       (kill-new (substring-no-properties annotation))
	       (skk-message "$B8=:_$NCm<a$r%3%T!<$7$^$7$?(B"
			    "Copying the current note...done")
	       (setq event nil
		     digit nil
		     char  nil)
	       (skk-annotation-show-2 annotation)))
	    ((eq command browse-command)
	     (setq list (delq browse-command list))
	     (setq urls (delq nil (mapcar #'skk-annotation-find-url notes)))
	     (when word
	       (cond ((setq cache
			    (skk-annotation-wikipedia-cache word sources))
		      (setq urls
			    (cons (apply
				   #'skk-annotation-generate-url
				   "http://%s.org/wiki/%s"
				   ;; split-string $B$NHs8_49@-$KG[N8(B
				   (static-if (and (string-match
						    "^GNU"
						    (emacs-version))
						   (<= emacs-major-version 21))
				       (cdr (split-string (cdr cache) " "))
				     (cdr (split-string (cdr cache) " " t))))
				  urls)))
		     (skk-annotation-show-wikipedia-url
		      (add-to-list 'urls
				   (skk-annotation-generate-url
				    "http://ja.wikipedia.org/wiki/%s"
				    word)))))
	     (unless (equal annotation "")
	       (cond
		(urls
		 (dolist (url urls)
		   (browse-url url))
		 (skk-message "$BCm<a$N$?$a$N%5%$%H$r%V%i%&%:$7$F$$$^$9(B..."
			      "Browsing web sites for the current notes..."))
		(t
		 (skk-message "$BCm<a$N$?$a$N%5%$%H$,8+$D$+$j$^$;$s(B"
			      "No web sites found for the current notes")))
	       (setq event nil
		     digit nil
		     char  nil)
	       (skk-annotation-show-2 annotation)))
	    ((eq command 'digit-argument)
	     (setq char  (static-if (featurep 'xemacs)
			     key
			   (if (integerp event)
			       event
			     (get event 'ascii-character)))
		   digit (- (logand char ?\177) ?0)
		   event nil))
	    ((or (equal (key-description key)
			(key-description skk-annotation-wikipedia-key))
		 (eq command 'skk-annotation-wikipedia-region))
	     (setq sources
		   (if (and digit
			    (> digit 0)
			    (<= digit
				(length skk-annotation-wikipedia-sources)))
		       (list (nth (1- digit)
				  skk-annotation-wikipedia-sources))
		     skk-annotation-wikipedia-sources))
	     (setq event nil
		   digit nil
		   char  nil)
	     (when word
	       (let ((skk-annotation-show-wikipedia-url nil))
		 (setq note (skk-annotation-treat-wikipedia word sources))))
	     (cond ((null note)
		    (setq note annotation))
		   (t
		    (setq annotation note)))
	     (unless (equal note "")
	       (add-to-list 'list browse-command)
	       (add-to-list 'list copy-command)
	       (skk-annotation-show-2 (or note annotation))))
	    (t
	     (setq list nil))))
    (when event
      (skk-unread-event event))))

;;;###autoload
(defun skk-annotation-message (&optional situation)
  (when (and skk-verbose
	     (not (or skk-isearch-switch
		      (skk-in-minibuffer-p))))
    (unless skk-annotation-wikipedia-message
      (let* ((key (key-description skk-annotation-wikipedia-key))
	     (string (format "{prefix %s}" (if (equal key "TAB")
					       "C-i"
					     key)))
	     (i 0)
	     source)
	(while (setq source (nth i skk-annotation-wikipedia-sources))
	  (setq string (format "%s[C-%d]%s" string (1+ i) source))
	  (setq i (1+ i)))
	(setq skk-annotation-wikipedia-message string)))
    (unless skk-annotation-message
      (let* ((key-copy (or (key-description skk-annotation-copy-key)
			   "$BL$Dj5A(B"))
	     (key-browse (or (key-description skk-annotation-browse-key)
			     "$BL$Dj5A(B")))
	(setq skk-annotation-message
	      (format "{$B%"%N%F!<%7%g%s(B}[%s]$B%3%T!<(B[%s]URL$B%V%i%&%:(B"
		      key-copy key-browse))))
    (condition-case nil
	(cond ((eq situation 'annotation)
	       (if (skk-sit-for skk-verbose-wait)
		   (let ((i 0))
		     (catch 'loop
		       (while (< i 20)
			 (message "%s" skk-annotation-message)
			 (unless (skk-sit-for 5.5)
			   (throw 'loop nil))
			 (message "%s" skk-annotation-wikipedia-message)
			 (unless (skk-sit-for 5.5)
			   (throw 'loop nil))
			 (setq i (1+ i))))
		     (message nil))
		 nil))
	      (t
	       (when (skk-sit-for skk-verbose-wait)
		 (message "%s" skk-annotation-wikipedia-message))))
      (quit
       (cond
	((eq skk-henkan-mode 'active)
	 (setq skk-henkan-count 0)
	 (skk-unread-event
	  (character-to-event
	   (aref
	    (car (where-is-internal 'skk-previous-candidate skk-j-mode-map))
	    0))))
	(t
	 (keyboard-quit))))))
  ;; $B>o$K(B t $B$rJV$9(B
  t)

(defun skk-annotation-find-url (string)
  (let (url)
    (with-temp-buffer
      (insert string)
      (goto-char (point-min))
      (save-match-data
	(while (and (not url)
		    (re-search-forward "\\." nil t))
	  (backward-char 1)
	  (setq url (thing-at-point 'url))
	  ;; http://foo $B$N$h$&$J(B URL $B$r@8@.$7$F$7$^$&$N$GBP:v(B
	  (when (and url
		     (not (string-match "\\." url)))
	    (setq url nil))
	  (unless url
	    (forward-char 1)))))
    url))

(defun skk-annotation-show-buffer (annotation)
  (condition-case nil
      (save-window-excursion
	(let ((minibuf-p (skk-in-minibuffer-p))
	      event window)
	  (skk-annotation-insert annotation)
	  (cond
	   (minibuf-p
	    (if (setq window (get-buffer-window (skk-minibuffer-origin)))
		(select-window window)
	      (other-window 1))
	    (unless (eq (next-window) (selected-window))
	      (delete-other-windows)))
	   (t
	    (split-window-vertically)))
	  (display-buffer skk-annotation-buffer)
	  (when minibuf-p
	    (select-window (minibuffer-window)))
	  ;;
	  (skk-annotation-message 'annotation)
	  ;;
	  (setq event (next-command-event))
	  (when (skk-key-binding-member
		 (skk-event-key event)
		 '(key-board-quit
		   skk-kanagaki-bs
		   skk-kanagaki-esc)
		 skk-j-mode-map)
	    (signal 'quit nil))
	  (skk-unread-event event)))
    (quit
     ;; skk-previous-candidate $B$X(B
     (setq skk-henkan-count 0)
     (skk-unread-event
      (character-to-event
       (aref
	(car (where-is-internal 'skk-previous-candidate
				skk-j-mode-map))
	0))))))

(defun skk-annotation-show-as-message (annotation)
  (message "%s" annotation))

(defun skk-annotation-setup ()
  (let ((skk-henkan-key (skk-get-last-henkan-datum 'henkan-key))
	(skk-okuri-char (skk-get-last-henkan-datum 'okuri-char))
	(cand (car (skk-get-last-henkan-datum 'henkan-list)))
	word)
    (unless cand
      (setq skk-henkan-key
	    (read-from-minibuffer "Midasi: "))
      (when (string= skk-henkan-key "")
	(skk-error "$B%"%N%F!<%7%g%s$9$kC18l$,$"$j$^$;$s(B"
		   "No word to be annotated"))
      (when (string-match "\\cj\\([a-z]+\\)$"
			  skk-henkan-key)
	(setq skk-okuri-char (match-string 1 skk-henkan-key)
	      ;; $BAw$j$"$jJQ49$r;XDj$9$k$H(B
	      ;; skk-henkan-okurigana $B$N;XDj$K:$$k!#(B
	      skk-henkan-okurigana ""))
      (setq cand
	    (prog1
		(skk-henkan-in-minibuff)
	      (setq skk-kakutei-flag nil))))
    ;; $B$3$N;~E@$G$O(B skk-num-list $B$O4{$K(B nil
    ;; $B%_%K%P%C%U%!$+$iBP>]$r;XDj$7$?>l9g$K$O(B consp $B$K$J$i$J$$(B
    (when (consp cand)
      (setq cand (car cand)))
    (setq word (car (skk-treat-strip-note-from-word cand)))
    (when (and (string-match "[0-9]" skk-henkan-key)
	       (or (string-match "#[0-9]" word)
		   (skk-lisp-prog-p word)))
      (setq skk-henkan-key
	    (skk-num-compute-henkan-key skk-henkan-key)))
    (setq skk-annotation-target-data
	  (list skk-henkan-key
		skk-okuri-char
		cand))
    ;; $B0U?^$rM}2r$7$F$J$$$,!"(Bskk-kakutei-initialize $B$N$[$&$,E,@Z$J5$$b(B
    (skk-kakutei)))

;;;###autoload
(defun skk-annotation-add (&optional no-previous-annotation)
  "$B:G8e$K3NDj$7$?8l$K(B annotation $B$rIU$1$k!#(B
$B4{$KIU$1$i$l$F$$$k(B annotation $B$,$"$l$P$=$l$rJT=8%P%C%U%!$K=PNO$9$k!#(B
no-previous-annotation $B$r;XDj$9$k$H(B \(C-u M-x skk-annotation-add $B$G;XDj2D(B\)
$B4{$KIU$1$i$l$F$$$k(B annotation $B$rJT=8%P%C%U%!$K=PNO$7$J$$!#(B"
  (interactive "P")
  (save-match-data
    (skk-kakutei)
    (skk-annotation-setup)
    (let* ((plist (append
		   '(intangible t read-only t)
		   (static-if (eq skk-emacs-type 'xemacs)
		       '(start-closed t end-open t)
		     '(front-sticky t rear-nonsticky t))))
	   (wholestring (nth 2 skk-annotation-target-data))
	   (realword (if (and wholestring
			      (string-match ";\\*?" wholestring))
			 (substring wholestring 0 (match-beginning 0))
		       wholestring))
	   (annotation (if (and realword
				(string-match ";\\*?" wholestring))
			   (substring wholestring (match-end 0))
			 nil)))
      (setq skk-annotation-original-window-configuration
	    (current-window-configuration))
      (delete-other-windows)
      (split-window-vertically)
      (other-window 1)
      (switch-to-buffer (get-buffer-create skk-annotation-buffer))
      (setq buffer-read-only nil
	    skk-annotation-mode t)
      (skk-annotation-erase-buffer)
      (insert
       (format "\
;; Add a note to word `%s' (this line will not be added to the note.)
"
	       realword))
      (static-if (fboundp 'set-text-properties)
	  (add-text-properties (point-min) (1- (point)) plist))
      (when (and (not no-previous-annotation)
		 annotation)
	(insert annotation))
      (run-hooks 'skk-annotation-mode-hook)
      (message "%s to save edits, %s to just kill this buffer"
	       (mapconcat 'key-description
			  (where-is-internal 'skk-annotation-save-and-quit
					     skk-annotation-mode-map)
			  ", ")

	       (mapconcat 'key-description
			  (where-is-internal 'skk-annotation-kill
					     skk-annotation-mode-map)
			  ", ")))))

(defun skk-annotation-save-and-quit (&optional quiet)
  "$B:G8e$K3NDj$7$?8l$K(B annotation $B$rIU$1$F(B annotation $B%P%C%U%!$rJD$8$k!#(B"
  ;; called in the annotation buffer.
  (interactive "P")
  (let (annotation)
    (save-match-data
      (with-current-buffer (get-buffer-create skk-annotation-buffer)
	(goto-char (point-min))
	(when (looking-at ";; Add a note to word") ; $BCfESH>C<(B
	  (forward-line 1)
	  (beginning-of-line))
	(setq annotation (buffer-substring-no-properties
			  (point) (point-max)))
	(when (string-match "^[\t\n $B!!(B]+" annotation)
	  (setq annotation (substring annotation (match-end 0))))
	(when (string-match "[\t\n $B!!(B]+$" annotation)
	  (setq annotation (substring annotation 0 (match-beginning 0))))
	(when (string= annotation "")
	  (setq annotation nil))
	(setq annotation (skk-quote-char annotation))))
    (if annotation
	(skk-annotation-last-word-1
	 (lambda (beg end)
	   (goto-char beg)
	   (when (re-search-forward ";[^/]*" end t)
	     (delete-region (match-beginning 0) (match-end 0)))
	   (goto-char end)
	   (insert ";*" annotation)))
      ;; $B:o=|$7$?;~(B
      (let ((old-annotation
	     (cdr (skk-treat-strip-note-from-word
		   (nth 2 skk-annotation-target-data)))))
	(when (and old-annotation
		   (yes-or-no-p
		    (format (if skk-japanese-message-and-error
				"$B4{B8$N%"%N%F!<%7%g%s(B `%s' $B$r:o=|$7$^$9$+!)(B "
			      "Delete old annotation `%s' ? ")
			    (skk-annotation-get old-annotation))))
	  (skk-annotation-last-word-1
	   (lambda (beg end)
	     (goto-char beg)
	     (when (re-search-forward ";[^/]*" end t)
	       (delete-region (match-beginning 0) (match-end 0))))))))
    (skk-annotation-erase-buffer)
    (kill-buffer (current-buffer))
    (set-window-configuration
     skk-annotation-original-window-configuration)
    (when annotation
      (unless quiet
	(message "%s" "Added annotation")))))

(defun skk-annotation-kill ()
  "annotation $B$rIU$1$:$K(B annotation $B%P%C%U%!$r(B kill $B$9$k!#(B"
  ;; called in the annotation buffer.
  (interactive)
  (skk-annotation-erase-buffer)
  (kill-buffer (current-buffer))
  (set-window-configuration
   skk-annotation-original-window-configuration))

;;;###autoload
(defun skk-annotation-remove ()
  "$B:G8e$K3NDj$7$?8l$+$i(B annotation $B$r<h$j5n$k!#(B"
  (interactive)
  (save-match-data
    (skk-kakutei)
    (skk-annotation-setup)
    (when (yes-or-no-p
	   (format (if skk-japanese-message-and-error
		       "%s $B$K$D$$$F$N%"%N%F!<%7%g%s$r:o=|$7$^$9$+!)(B "
		     "Really delete annotation for %s? ")
		   (nth 2 skk-annotation-target-data)))
      (skk-annotation-last-word-1
       (lambda (beg end)
	 (goto-char beg)
	 (when (re-search-forward ";[^/]*" end t)
	   (delete-region (match-beginning 0) (match-end 0))))))))

;;;###autoload
(defun skk-annotation-display-p (test)
  ;; $B%_%K%P%C%U%!$K$$$k$H$-M>7W$J%a%C%;!<%8$r%/%j%"$9$k(B
  (when (or skk-isearch-switch
	    (skk-in-minibuffer-p))
    (message nil))
  ;;
  (cond ((eq skk-show-annotation nil)
	 nil)
	((and (listp skk-show-annotation)
	      (eq (car skk-show-annotation) 'not)
	      ;; (not ...)
	      (memq test skk-show-annotation))
	 ;; (not list), (not minibuf) or (not list minibuf)
	 nil)
	(t
	 ;; non-nil
	 t)))

;;;###autoload
(defun skk-annotation-toggle-display-p ()
  (interactive)
  (cond ((eq skk-show-annotation nil)
	 ;; do nothing
	 nil)
	((and (listp skk-show-annotation)
	      (eq (car skk-show-annotation) 'not))
	 ;; (not ...)
	 (cond ((memq 'list skk-show-annotation)
		(if (eq (length skk-show-annotation) 2)
		    ;; (not list) -> t  i.e. turn on
		    (setq skk-show-annotation t)
		  ;; (not list minibuf) -> (not minibuf)
		  (setq skk-show-annotation '(not minibuf))))
	       (t
		;; (not minibuf) -> (not list minibuf)  i.e. turn off
		(setq skk-show-annotation '(not list minibuf)))))
	(t
	 ;; non-nil -> (not list)  i.e. turn off
	 (setq skk-show-annotation '(not list)))))

(defun skk-annotation-last-word-1 (function)
  ;; funcall FUNCTION with BEG and END where BEG and END are markers.
  (let ((inhibit-quit t)
	(jisyo-buffer (skk-get-jisyo-buffer skk-jisyo 'nomsg))
	(word (nth 2 skk-annotation-target-data))
	(beg (make-marker))
	(end (make-marker))
	(eol (make-marker))
	pattern)
    (when (buffer-live-p jisyo-buffer)
      (save-match-data
	(with-current-buffer jisyo-buffer
	  (goto-char (if (nth 1 skk-annotation-target-data)
			 skk-okuri-ari-min
		       skk-okuri-nasi-min))
	  (when (re-search-forward
		    (concat "^\\("
			    (regexp-quote (car skk-annotation-target-data))
			    "\\) /")
		    (if (nth 1 skk-annotation-target-data)
			skk-okuri-ari-max nil)
		    t nil)
	    (goto-char (match-beginning 1))
	    (set-marker eol (skk-save-point (end-of-line) (point)))
	    (when (string-match ";" word)
	      (setq word (substring word 0 (match-beginning 0))))
	    (when (re-search-forward
		   (concat "/\\(" word "\\)\\(;[^/]*\\)*/")
		   eol t nil)
	      (set-marker beg (match-beginning 1))
	      (set-marker end (or (match-end 2) (match-end 1)))
	      (funcall function beg end)
	      (when (nth 1 skk-annotation-target-data)
		(goto-char end)
		;; skip other candidates that has not a okuirigana.
		(search-forward "/[" eol t nil)
		(setq pattern (concat "/\\(" word "\\)\\(;[^/]*\\)*/"))
		(while (re-search-forward pattern eol t nil)
		  (set-marker beg (match-beginning 1))
		  (set-marker end (or (match-end 2)
				      (match-end 1)))
		  (funcall function beg end)))
	      (set-marker beg nil)
	      (set-marker end nil)
	      (set-marker eol nil))))))))

;;;###autoload
(defun skk-annotation-quote (&optional quiet)
  "$B:G8e$K3NDj$7$?8l$K4^$^$l$k(B `;' $B$r8uJd$N0lIt$H$7$F(B quote $B$9$k!#(B"
  (interactive "P")
  (skk-kakutei)
  (skk-annotation-setup)
  (let (candidate)
    (skk-annotation-last-word-1
     (lambda (beg end)
       (goto-char beg)
       (setq candidate (buffer-substring-no-properties beg end))
       (when (string-match ";" candidate)
	 (delete-region beg end)
	 (insert (skk-quote-semicolon candidate))
	 (unless quiet
	   (message "%s" "Quoted")))))))

;;;###autoload
(defun skk-annotation-wikipedia (word &optional sources)
  "Wiktionary/Wikipedia $B$N(B WORD $B$KAjEv$9$k5-;v$+$i%"%N%F!<%7%g%s$r<hF@$9$k!#(B"
  (let ((sources (or sources skk-annotation-wikipedia-sources))
	source
	(string "")
	(note nil))
    ;; sources $B$K;XDj$5$l$?=gHV$K;2>H$9$k(B
    (if (catch 'skk-annotation-wikipedia-suspended
	  (save-match-data
	    (while (and (not note)
			sources)
	      (setq source (car sources))
	      ;; Wiktionary $B$G$O$=$N$^$^!"(BWikipedia $B$G$OBh(B 1 $BJ8;z$N$_(B upcase
	      (setq note (skk-annotation-wikipedia-1 word source
						     (= 1 (length sources))))
	      ;;
	      (when (and (null note)
			 (memq source '(ja.wikipedia
					simple.wikipedia
					en.wikipedia))
			 (skk-ascii-char-p (aref word 0)))
		;; Wikipedia $B$G3F(B initial $B$r(B upcase
		(setq note (skk-annotation-wikipedia-1
			    (upcase-initials word)
			    source
			    (= 1 (length sources)))))
	      ;;
	      (when (and (null note)
			 (memq source '(en.wiktionary ja.wiktionary))
			 (skk-ascii-char-p (aref word 0))
			 (not (skk-lower-case-p (aref word 0))))
		;; Wiktionary $B$G$9$Y$F(B downcase $B$9$k>l9g(B
		(setq note (skk-annotation-wikipedia-1
			    (downcase word)
			    source
			    (= 1 (length sources)))))
	      ;;
	      (setq string (format (if (string= "" string)
				       "%s%s"
				     "%s/%s")
				   string source))
	      (setq sources (cdr sources)))
	    (unless note
	      (message "%s $B$K9`L\$,$"$j$^$;$s(B" string)))
	  nil)
	;; $B%@%&%s%m!<%I$,CfCG$5$l$?$H$-(B
	(progn
	  (message "%s $B$NE>Aw$,CfCG$5$l$^$7$?(B" source)
	  nil)
      ;;
      note)))

(defun skk-annotation-wikipedia-clean-sup (p1 p2 p3 p4)
  (put-text-property p2 p3 'face 'underline)
  (save-excursion
    (goto-char p2)
    (insert "^"))
  (html2text-delete-tags p1 p2 (1+ p3) (1+ p4)))

(defun skk-annotation-wikipedia-clean-sub (p1 p2 p3 p4)
  (put-text-property p2 p3 'face 'underline)
  (save-excursion
    (goto-char p2)
    (insert "_"))
  (html2text-delete-tags p1 p2 (1+ p3) (1+ p4)))

(defun skk-annotation-wikipedia-1 (word source last)
  "Wiktionary/Wikipedia $B$N(B WORD $B$KAjEv$9$k5-;v$r<B:]$K%@%&%s%m!<%I$7$FD4$Y$k!#(B
$B3:Ev%Z!<%8(B (html) $B$r%@%&%s%m!<%I$9$k5!G=$O(B Emacs $B$KIUB0$N(B URL $B%Q%C%1!<%8$K0M(B
$B$k!#E,@Z$J(B URL $B$r@8@.$9$k$?$a$K$O!"(B"
  (require 'html2text)
  (require 'url)
  ;;
  (setq word (skk-annotation-wikipedia-normalize-word word source))
  ;;
  (let ((cache-buffer (format " *skk %s %s" source word))
	;; html2text $B$,@5$7$/07$($J$$(B tag $B$O0J2<$N%j%9%H$K;XDj$9$k(B
	(html2text-remove-tag-list
	 (append '("a" "span" "table" "tr" "td" "h2" "h3" "h4" "h5" "small"
		   "code")
		 html2text-remove-tag-list))
	(html2text-format-tag-list
	 (append '(("sup" . skk-annotation-wikipedia-clean-sup)
		   ("sub" . skk-annotation-wikipedia-clean-sub))
		 html2text-format-tag-list))
	buffer note aimai continue nop point top pt1 pt2 btag etag end)
    (if (get-buffer cache-buffer)
	(with-current-buffer cache-buffer
	  (setq note (buffer-string)))
      ;; $B%-%c%C%7%e$,$J$$>l9g(B
      (setq buffer (url-retrieve (skk-annotation-generate-url
				  "http://%s.org/wiki/%s"
				  source word)
				 #'skk-annotation-wikipedia-retrieved
				 (list (list source))))
      (when (and (setq buffer
		       (catch 'skk-annotation-wikipedia-retrieved
			 (progn
			   (condition-case nil
			       (skk-sit-for 100)
			     (quit
			      ;; C-g $B$5$l$?$H$-$N5sF0$rD4@0$9$k(B
			      ;; $B8=>u$G$O$?$@(B retrieval $B$rCf;_$7$F$*$/$,!"(B
			      ;; $B"'%b!<%I$G$N(B C-g $B$G$O"&%b!<%I$KI|5"$9$k5sF0$b(B
			      ;; $B$"$j$&$k$H;W$o$l$k!#(B
			      nil))
			   (when (buffer-live-p buffer)
			     (kill-buffer buffer))
			   (throw 'skk-annotation-wikipedia-suspended
				  source))))
		 (buffer-live-p buffer))
	(with-current-buffer buffer
	  (set-buffer-multibyte t)
	  (decode-coding-region (point-min) (point-max) 'utf-8)
	  (when (> (buffer-size) 0)
	    (when (get-buffer cache-buffer)
	      (kill-buffer cache-buffer))
	    (rename-buffer cache-buffer)
	    ;; $BMW$i$J$$ItJ,$r>C$9(B
	    (cond
	     ;; ja.wiktionary
	     ((eq source 'ja.wiktionary)
	      (goto-char (point-min))
	      (if (save-excursion
		    (re-search-forward "\
\\(^HTTP/1\\.0 301 Moved Permanently\\|<div class=\"noarticletext\">\
\\|:Badtitle\\)"
				       nil t))
		  ;; $B9`L\$,$J$$>l9g(B
		  (erase-buffer)
		(search-forward "<!-- start content -->" nil t)
		(delete-region (point-min) (point))
		;;
		(goto-char (point-min))
		(when (re-search-forward
		       skk-annotation-ja-wiktionary-lang-regexp
		       nil t)
		  (save-excursion
		    (goto-char (match-end 2))
		    (insert ", "))
		  (delete-region (point-min) (match-beginning 0))
		  (setq top (point))
		  (when (re-search-forward
			 skk-annotation-ja-wiktionary-lang-regexp
			 nil t)
		    (delete-region (setq pt1 (match-beginning 0))
				   (point-max))))
		;;
		(setq point top)
		(goto-char (point-min))
		;; ja.wiktionary $B$N=q<0$,(B en.wiktionary $B$[$I@0$C$F$$$J$$$N$G(B
		;; workaround
		(unless
		    (save-excursion
		       (re-search-forward
			skk-annotation-ja-wiktionary-part-of-speech-regexp
			nil t))
		  (setq point pt1))
		;;
		(while (re-search-forward
			skk-annotation-ja-wiktionary-part-of-speech-regexp
			nil t)
		  (setq nop t)
		  (save-match-data
		    (when (looking-at "</h3>")
		      (delete-region (match-beginning 0) (match-end 0))))
		  (goto-char (match-beginning 0))
		  (delete-region (or point (point-min)) (point))
		  (when (re-search-forward "<\\(ol\\|dl\\)>" nil t)
		    (setq btag (match-string 0)
			  etag (if (string= btag "<ol>")
				   "</ol>"
				 "</dl>")
			  point nil
			  pt1 (point)
			  pt2 nil)
		    (while (and (not point)
				(search-forward etag nil t))
		      (setq pt2 (point))
		      (goto-char pt1)
		      (if (and (search-forward btag nil t)
			       (< (point) pt2))
			  (progn
			    (goto-char pt2)
			    (setq pt1 (point)))
			(setq point pt2)
			(goto-char point)))))
		;;
		;; ja.wiktionary $B$N=q<0$,(B en.wiktionary $B$[$I@0$C$F$$$J$$$N$G(B
		;; $B>C$7$9$.$F$7$^$&4m81@-$"$j!#(B
		(when point
		  (delete-region point (point-max)))
		;; ($BMQNc$J$I$r=|$/(B -- $B=|$+$J$$$[$&$,$$$$!)(B)
		;; ja.wiktionary $B$O(B en.wiktionary $B$HA4$/E}0l$5$l$?=q$-J}$K$O(B
		;; $B$J$C$F$$$J$$$N$G!"(Bul $B$r=|$/$H>pJs$,$[$H$s$I;D$i$J$$>l9g$,(B
		;; $B$"$k(B
		;; (skk-annotation-wikipedia-remove-nested "<ul>" "</ul>")
		(skk-annotation-wikipedia-remove-nested "<dl>" "</dl>")
		(skk-annotation-wikipedia-remove-nested "<table[^<]*>"
							"</table>")
		(skk-annotation-wikipedia-remove-nested "\
<div class=\"\\(infl-table\\|thumb.+\\)\"[^<]*>" "</div>" "<div[^<]*>")
		;;
		(goto-char (point-min))
		(while (re-search-forward
			"<span.*>\\[<a.+>$BJT=8(B</a>\\]</span>"
			nil t)
		  (replace-match ""))))
	     ;; en.wiktionary
	     ((eq source 'en.wiktionary)
	      (goto-char (point-min))
	      (if (save-excursion
		    (re-search-forward "\
\\(^HTTP/1\\.0 301 Moved Permanently\\|<div class=\"noarticletext\">\
\\|:Badtitle\\)"
				       nil t))
		  ;; $B9`L\$,$J$$>l9g(B
		  (erase-buffer)
		(search-forward "<!-- start content -->" nil t)
		(delete-region (point-min) (point))
		;;
		(goto-char (point-min))
		(when (re-search-forward
		       skk-annotation-en-wiktionary-lang-regexp
		       nil t)
		  (save-excursion
		    (goto-char (match-end 2))
		    (insert ", "))
		  (delete-region (point-min) (match-beginning 0))
		  (setq top (point))
		  (when (re-search-forward
			 skk-annotation-en-wiktionary-lang-regexp
			 nil t)
		    (delete-region (match-beginning 0) (point-max))))
		;;
		(setq point top)
		(goto-char (point-min))
		(while (re-search-forward
			 skk-annotation-en-wiktionary-part-of-speech-regexp
			nil t)
		  (setq nop t)
		  (save-match-data
		    (when (looking-at "</h3>")
		      (delete-region (match-beginning 0) (match-end 0))))
		  (goto-char (match-beginning 0))
		  (delete-region (or point (point-min)) (point))
		  (when (re-search-forward "<\\(ol\\|dl\\)>" nil t)
		    (setq btag (match-string 0)
			  etag (if (string= btag "<ol>")
				   "</ol>"
				 "</dl>")
			  point nil
			  pt1 (point)
			  pt2 nil)
		    (while (and (not point)
				(search-forward etag nil t))
		      (setq pt2 (point))
		      (goto-char pt1)
		      (if (and (search-forward btag nil t)
			       (< (point) pt2))
			  (progn
			    (goto-char pt2)
			    (setq pt1 (point)))
			(setq point pt2)
			(goto-char point)))))
		;;
		(when point
		  (delete-region point (point-max)))
		;; ($BMQNc$J$I$r=|$/(B -- $B=|$+$J$$$[$&$,$$$$!)(B)
		(skk-annotation-wikipedia-remove-nested "<ul>" "</ul>")
		(skk-annotation-wikipedia-remove-nested "<dl>" "</dl>")
		(skk-annotation-wikipedia-remove-nested "<table[^<]*>"
							"</table>")
		(skk-annotation-wikipedia-remove-nested "\
<div class=\"\\(infl-table\\|thumb.+\\)\"[^<]*>" "</div>" "<div[^<]*>")
		(skk-annotation-wikipedia-remove-nested "\
<span class=\"interProject\">" "</span>")
		;; Wikipedia $B$X$N0FFb$r=|$/(B
		(goto-char (point-min))
		(while (re-search-forward "\
\\(<a href=\"/wiki/Wikipedia\" title=\"Wikipedia\">\\)?\
Wikipedia\\(</a>\\)? has an article on:$" nil t)
		  (save-excursion
		    (goto-char (match-beginning 0))
		    (beginning-of-line)
		    (setq point (point)))
		  (forward-line 2)
		  (end-of-line)
		  (delete-region point (point)))
		;;
		(goto-char (point-min))
		(while (re-search-forward "\
<span.*>\\(\\[<a.+>edit</a>\\]\\|Inflection\\)</span>"
			nil t)
		  (replace-match ""))))
	     ;; wikipedia
	     ((memq source '(ja.wikipedia simple.wikipedia en.wikipedia))
	      (goto-char (point-min))
	      (if (save-excursion
		    (re-search-forward "\
\\(^HTTP/1\\.0 301 Moved Permanently\\|<div class=\"noarticletext\">\
\\|:Badtitle\\)"
				       nil t))
		  ;; $B9`L\$,$J$$>l9g(B
		  (erase-buffer)
		(setq aimai
		      (save-excursion
			(re-search-forward "<a href=\"/wiki/Wikipedia:\
\\(%E6%9B%96%E6%98%A7%E3%81%95%E5%9B%9E%E9%81%BF\\|Disambiguation\\)\""
					nil t)))
		(search-forward "<!-- start content -->" nil t)
		(delete-region (point-min) (point))
		;; <div> $B$r=|5n$9$k(B
		(skk-annotation-wikipedia-remove-nested "<div.+>" "</div>")
		;; <span> $B$r=|5n$9$k(B
		(setq point nil)
		(goto-char (point-min))
		(while (re-search-forward
			"<span class=\"\\(.+audiolink.+\\)\".*>" nil t)
		  (setq point (match-beginning 0))
		  (goto-char point)
		  (search-forward "</span>" nil t)
		  (delete-region point (point))
		  (goto-char point))
		;; <big> $B$r=|5n$9$k(B
		(goto-char (point-min))
		(while (re-search-forward "<p><big>.+</big></p>" nil t)
		  (replace-match ""))
		;; &#160; $B$r=hM}(B
		(goto-char (point-min))
		(while (re-search-forward "&#160;" nil t)
		  (replace-match " "))
		;; <br /> $B$r=|5n$9$k(B
		(goto-char (point-min))
		(while (re-search-forward "<p>.+\\(<br />\\)$" nil t)
		  (replace-match "" nil nil nil 1))
		;; xxx > xxx > xxx ... $B$r=|5n$9$k(B
		(goto-char (point-min))
		(while (re-search-forward
			"<p>.+</a> &gt; \\(<a.+>\\|<b>\\).+</p>" nil t)
		  (replace-match ""))
		;; <table> $B$r=|5n(B
		(skk-annotation-wikipedia-remove-nested "<table.*>" "</table>")
		;;
		(goto-char (point-min))
		(when (or (when (re-search-forward
				 "<p>\\(<br />\n\\|[^\n]*\\)?\
<b>[^\n]+</b>[^\n]+"
				 nil t)
			    (goto-char (match-beginning 0))
			    (if (and (save-excursion
				       (re-search-forward "</p>" nil t))
				     (string-match
				      (cond
				       ((eq source 'ja.wikipedia)
					"$B!#(B\\|$B!%(B")
				       (t
					"\\."))
				      (buffer-substring (point)
							(match-beginning 0))))
				t
			      (setq point (point)
				    continue t)
			      nil))
			  (when (progn
				  (goto-char (point-min))
				  (re-search-forward "<\\(u\\|o\\)l>" nil t))
			    (goto-char (if continue
					   point
					 (match-beginning 0)))
			    (setq nop t)))
		  (delete-region (point-min) (point))
		  (goto-char (point-min))
		  ;;
		  (cond
		   ((or aimai nop)
		    (setq pt1 (if (re-search-forward "<\\(u\\|o\\)l>" nil t)
				  (match-end 0)
				nil)
			  pt2 nil)
		    (while (and (not end)
				(re-search-forward "</\\(u\\|o\\)l>"
						   nil t))
		      (setq pt2 (match-end 0))
		      (save-excursion
			(goto-char (or pt1 (1+ (point-min))))
			(when (re-search-forward "<\\(u\\|o\\)l>"
						 nil t)
			  (setq pt1 (match-end 0))))
		      (when (or (null pt1)
				(> pt1 pt2))
			(setq end t))))
		   (t
		    (re-search-forward "</p>" nil t)))
		  (delete-region (point) (point-max))))))
	    ;;
	    (setq point nil)
	    (when (> (buffer-size) 0)
	      (html2text)
	      (goto-char (point-min))
	      (cond
	       ((memq source '(ja.wiktionary en.wiktionary))
		;; wiktionary $B$N@07A7k2L$O6u9T$@$i$1$K$J$k(B...
		(goto-char (point-min))
		(while (re-search-forward "\n[\n]+" nil t)
		  (replace-match "\n"))
		(goto-char (point-min))
		(while (not (eobp))
		  (beginning-of-line)
		  (setq point (point))
		  (forward-line 1)
		  (fill-region point (point))))
	       (t
		(while (looking-at "^[ \t]*$")
		  (kill-line 1))
		(cond ((or aimai nop)
		       (while (not (eobp))
			 (beginning-of-line)
			 (setq point (point))
			 (forward-line 1)
			 (fill-region point (point))))
		      (t
		       (fill-paragraph nil)))))
	      ;;
	      (when aimai
		(insert (if (eq source 'ja.wikipedia)
			    "\n($B[#Kf$52sHr$N%Z!<%8(B)"
			  "\n(Disambiguation)")))
	      ;;
	      (goto-char (point-max))
	      (while (and (looking-at "^$")
			  (not (string= "" (buffer-string))))
		(delete-char -1))
	      ;;
	      (when (and (not (equal (buffer-string) ""))
			 (not (get-text-property 1 'face)))
		(put-text-property 1 2 'face 'default))
	      (setq note (buffer-string)))))))
    ;;
    (cond ((stringp note)
	   (if (equal note "")
	       nil
	     note))
	  (t
	   nil))))

(defun skk-annotation-wikipedia-remove-nested (btag etag &optional ibtag)
  "<dl> <ul> <table> $B$J$I$NF~$l;R9=B$$r=|5n$9$k!#(B"
  (unless ibtag
    (setq ibtag btag))
  (let (point pt1 pt2 orig-btag)
    (setq point nil)
    (goto-char (point-min))
    (while (re-search-forward btag nil t)
      (setq point (match-beginning 0))
      (goto-char point)
      (cond
       ((not (search-forward etag nil t))
	(delete-region point (match-end 0))
	(goto-char (point-min)))
       (t
	(setq pt2 (match-end 0))
	(goto-char (1+ point))
	(cond
	 ((not (re-search-forward ibtag nil t))
	  (delete-region point pt2)
	  (when orig-btag
	    (setq btag      orig-btag
		  orig-btag nil))
	  (goto-char (point-min)))
	 (t
	  (setq pt1 (match-beginning 0))
	  (cond
	   ((< pt2 pt1)
	    (delete-region point pt2)
	    (setq point nil)
	    (when orig-btag
	      (setq btag      orig-btag
		    orig-btag nil))
	    (goto-char (point-min)))
	   (t
	    (unless orig-btag
	      (setq orig-btag btag
		    btag      ibtag))
	    (goto-char pt1))))))))))

(defun skk-annotation-wikipedia-retrieved (&rest args)
  (cond ((or (member "deleted\n" (assq 'error (memq :error (car args))))
	     (< (buffer-size) 7)
	     (not (progn
		    (goto-char (point-max))
		    (search-backward "</html>" nil t))))
	 ;; $BIT40A4$J(B retrieval $B$K$*$$$F$b(B STATUS $B$,(B nil $B$H$J$k$3$H$,$"$k$N$G(B
	 ;; $B$3$3$GD4@0$9$k!#(B
	 (kill-buffer (current-buffer))
	 (ignore-errors
	   (throw 'skk-annotation-wikipedia-suspended (cadr args))))
	(t
	 (condition-case nil
	     (throw 'skk-annotation-wikipedia-retrieved (current-buffer))
	   (error (kill-buffer (current-buffer)))))))

;;;###autoload
(defun skk-annotation-treat-wikipedia (word &optional sources)
  "WORD $B$,A^F~$5$l$k$H$-$KI=<($5$l$k$Y$-Cm<a$r@8@.$9$k!#(B
$B@8@.$7$?Cm<a$rJV$9!#(B"
  (save-match-data
    (let* ((string
	    (if skk-annotation-show-wikipedia-url
		;; $B$3$N$H$-$O(B URL $B$rCm<a$H$9$k!#(B
		(concat "$B%@%_!<(B;"
			(skk-quote-char
			 (skk-annotation-generate-url
			  "http://%s.org/wiki/%s"
			  (or (car sources)
			      'ja.wikipedia)
			  word)))
	      nil))
	   (value (if string
		      ;; $B$^$@!VCm<a$NAu>~!W$r<u$1$F$$$J$$$N$G!"$3$3$G(B
		      ;; $BE,MQ$9$k!#(B
		      (if (functionp skk-treat-candidate-appearance-function)
			  (funcall skk-treat-candidate-appearance-function
				   string nil)
			string)
		    nil)))
      ;;
      (cond ((consp value)
	     ;; ($B8uJd(B . $BCm<a(B) $B$@$,!"8uJd$O(B dummy $B$J$N$GGK4~$9$k!#(B
	     (cond
	      ((consp (cdr value))
	       ;; ($B8uJd(B . ($B%;%Q%l!<%?(B . $BCm<a(B))
	       ;; $BCm<a$O4{$K%;%Q%l!<%?H4$-(B
	       (cddr value))
	      ((string-match "^;" (cdr value))
	       ;; ($B8uJd(B . $BCm<a(B)
	       ;; $BCm<a$O$^$@%;%Q%l!<%?$r4^$s$G(B
	       ;; $B$$$k(B
	       (substring (cdr value)
			  (match-end 0)))
	      (t
	       ;; ($B8uJd(B . $BCm<a(B)
	       ;; $BCm<a$O4{$K%;%Q%l!<%?$r=|5n$7$F(B
	       ;; $B$$$k$b$N$HH=CG$9$k(B
	       (cdr value))))
	    ;;
	    ((stringp value)
	     ;; $BJV$jCM$,J8;zNs$@$C$?>l9g(B
	     (if (string-match ";" value)
		 (substring value (match-end 0))
	       nil))
	    (t
	     ;; Wikipedia $B$NFbMF$NI=<($,MW5a$5$l$?>l9g!#(B
	     (skk-annotation-wikipedia word sources))))))

;;;###autoload
(defun skk-annotation-wikipedia-cache (word &optional sources)
  (let ((sources (or sources skk-annotation-wikipedia-sources))
	(word (skk-annotation-wikipedia-normalize-word word 'en.wiktionary))
	(cword (skk-annotation-wikipedia-normalize-word word))
	(ccword (skk-annotation-wikipedia-normalize-word word
							 'upcase-initials)))
    (catch 'found
      (while sources
	(let* ((source (pop sources))
	       (ccache-buffer (if (equal word cword)
				  nil
				(format " *skk %s %s" source cword)))
	       (cccache-buffer (if (or (equal word ccword)
				       (equal cword ccword))
				   nil
				 (format " *skk %s %s" source ccword)))
	       (cache-buffer (format " *skk %s %s" source word))
	       string)
	  (setq string
		(if (and ccache-buffer
			 (get-buffer ccache-buffer))
		    ;; Word word
		    (with-current-buffer (get-buffer ccache-buffer)
		      (buffer-string))
		  ""))
	  (if (> (length string) 0)
	      (throw 'found (cons string ccache-buffer))
	    (setq string
		  (if (and cccache-buffer
			 (get-buffer cccache-buffer))
		      ;; Word Word
		      (with-current-buffer (get-buffer cccache-buffer)
			(buffer-string))
		    ""))
	    (if (> (length string) 0)
		(throw 'found (cons string cccache-buffer))
	      (setq string
		    (if (get-buffer cache-buffer)
			;; word word
			(with-current-buffer (get-buffer cache-buffer)
			  (buffer-string))
		      ""))
	      (if (string= string "")
		  nil
		(throw 'found (cons string cache-buffer))))))))))

;;;###autoload
(defun skk-annotation-wikipedia-region (&optional prefix-arg start end)
  (interactive (cons (prefix-numeric-value current-prefix-arg)
		     (cond
		      ((static-if (featurep 'xemacs)
			   (region-active-p)
			 (and transient-mark-mode mark-active))
		       (list (region-beginning) (region-end)))
		      ((eq skk-henkan-mode 'on)
		       (list (marker-position skk-henkan-start-point)
			     (point)))
		      (t
		       ;; dummy
		       (list 1 1)))))
  ;; $B%_%K%P%C%U%!$K$$$k$H$-M>7W$J%a%C%;!<%8$r%/%j%"$9$k(B
  (when (or skk-isearch-switch
	    (skk-in-minibuffer-p))
    (message nil))
  ;;
  (let ((word (if (and (= start 1) (= end 1))
		  ;; region $B$,(B active $B$G$J$$$H$-$O!$%]%$%s%H$K$"$k(B
		  ;; $BC18l$r?dB,$9$k(B
		  (thing-at-point 'word)
		(buffer-substring-no-properties start end)))
	(sources
	 (if (and current-prefix-arg
		  (> prefix-arg 0)
		  (<= prefix-arg (length skk-annotation-wikipedia-sources)))
	     (list (nth (1- prefix-arg) skk-annotation-wikipedia-sources))
	   skk-annotation-wikipedia-sources))
	note)
    (when (and word
	       (> (length word) 0))
      (setq note (or (car (skk-annotation-wikipedia-cache word sources))
		     (skk-annotation-wikipedia word sources)))
      (skk-annotation-show (or note "") word sources))))

(defun skk-annotation-generate-url (format-string &rest args)
  (condition-case nil
      (require 'url-util)
    (error
     (error "%s" "$B?7$7$$(B URL $B%Q%C%1!<%8$,I,MW$G$9(B")))
  (if (skk-annotation-url-package-available-p)
      (apply #'format format-string
	     (mapcar #'(lambda (element)
			 (if (stringp element)
			     (url-hexify-string element)
			   element))
		     args))
    (error "%s" "URL $B%Q%C%1!<%8$^$?$O(B Mule-UCS $B$,MxMQ$G$-$^$;$s(B")))

(defun skk-annotation-wikipedia-normalize-word (word &optional method)
  ;; $B%9%Z!<%9$O(B %20 $B$G$O$J$/!"%"%s%@!<%9%3%"$KJQ49$9$k(B
  (replace-regexp-in-string " "
			    "_"
			    (cond
			     ((memq method '(ja.wiktionary en.wiktionary))
			      (if (and (> (length word) 1)
				       (skk-ascii-char-p (aref word 0))
				       (skk-lower-case-p (aref word 1)))
				  ;; $BFsJ8;z$a$,(B lower case $B$J$i(B downcase
				  (downcase word)
				;; $B0lJ8;z$@$C$?$i85$N(B case
				;; $BFsJ8;z$a$,(B upper case $B$J$i85$N(B case
				;; $B1Q8l0J30$OL$BP1~(B
				word))
			      ((eq method 'upcase-initials)
			       (upcase-initials word))
			      (t
			       (concat (vector (upcase (aref word 0)))
				       (substring word 1))))))

(defun skk-annotation-url-package-available-p ()
  (when (eq skk-annotation-url-package-available-p 'untested)
    ;; Emacs 22 $B0J9_0J30$G(B URL $B%Q%C%1!<%8$r%F%9%H$9$k(B
    (cond
     ((or (and (eq skk-emacs-type 'mule4)
	       (string-lessp mule-version "4.1"))
	  (and (not (and (featurep 'xemacs)
			 (string< "21.5" emacs-version)))
	       (not (ignore-errors
		      (require 'un-define)))))
      ;; Emacs 20.7 (MULE 4.0) $B$G$O%5%]!<%H$7$J$$(B
      (setq skk-annotation-url-package-available-p nil))
     (t
      ;; Emacs 21 $B$H(B XEmacs
      (defadvice url-hexify-string (around multibyte-char activate)
	(setq ad-return-value
	      (mapconcat (lambda (byte)
			   (if (memq byte url-unreserved-chars)
			       (char-to-string byte)
			     (format "%%%02x" byte)))
			 (if (multibyte-string-p (ad-get-arg 0))
			     (encode-coding-string (ad-get-arg 0) 'utf-8)
			   (ad-get-arg 0))
			 "")))
      ;;
      (setq skk-annotation-url-package-available-p t))))
  ;;
  skk-annotation-url-package-available-p)

(require 'product)
(product-provide
    (provide 'skk-annotation)
  (require 'skk-version))

;;; skk-annotation.el ends here
