;;; skk-autoloads.el --- autoload settings for SKK.

;; This file was generated automatically by SKK-MK at Thu Jul 18 22:02:59 2013.

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
;; along with Daredevil SKK, see the file COPYING.  If not, write to the
;; Free Software Foundation Inc., 51 Franklin Street, Fifth Floor, Boston,
;; MA 02110-1301, USA.

;;; Code:


;;;### (autoloads nil "skk-viper" "skk-viper.el" (20242 31010 0 0))
;;; Generated autoloads from skk-viper.el

(autoload 'skk-viper-normalize-map "skk-viper" "\


\(fn)" nil nil)

;;;***

;;;### (autoloads nil "skk-jisx0213" "skk-jisx0213.el" (19542 57953
;;;;;;  0 0))
;;; Generated autoloads from skk-jisx0213.el

(autoload 'skk-jisx0213-henkan-list-filter "skk-jisx0213" "\


\(fn)" nil nil)

;;;***

;;;### (autoloads nil "skk-emacs" "skk-emacs.el" (20522 65470 0 0))
;;; Generated autoloads from skk-emacs.el

(autoload 'skk-emacs-prepare-menu "skk-emacs" "\


\(fn)" nil nil)

(autoload 'skk-emacs-prepare-modeline-properties "skk-emacs" "\


\(fn)" nil nil)

(autoload 'skk-search-ja-dic "skk-emacs" "\
GNU Emacs $B$KIUB0$9$k$+$J4A;zJQ49<-=q$rMQ$$$F8!:w$9$k!#(B
$B8=:_$N(B Emacs $B$K$O(B SKK-JISYO.L $B$r4p$KJQ49$5$l$?(B ja-dic.el $B$,IUB0$7$F$$$k!#(B
$B$3$N<-=q%G!<%?$rMQ$$$FAw$j$"$j!"Aw$j$J$7!"@\F,<-!"@\Hx<-$NJQ49$r9T$&!#(B
$B$?$@$7!"(BSKK-JISYO.L $B$N$h$&$J1Q?tJQ49!"?tCMJQ49$J$I$O$G$-$J$$!#(B

\(fn)" nil nil)

(autoload 'skk-jis2sjis2 "skk-emacs" "\


\(fn CHAR1 CHAR2)" nil nil)

;;;***

;;;### (autoloads nil "ccc" "ccc.el" (20611 49971 0 0))
;;; Generated autoloads from ccc.el

(autoload 'ccc-setup "ccc" "\


\(fn)" nil nil)

(autoload 'update-buffer-local-frame-params "ccc" "\


\(fn &optional BUFFER)" nil nil)

(add-hook 'after-init-hook (lambda nil (when window-system (ccc-setup))))

;;;***

;;;### (autoloads nil "context-skk" "context-skk.el" (20722 33356
;;;;;;  0 0))
;;; Generated autoloads from context-skk.el

(let ((loads (get 'context-skk 'custom-loads))) (if (member '"context-skk" loads) nil (put 'context-skk 'custom-loads (cons '"context-skk" loads))))

(defvar context-skk-context-check-hook '(context-skk-out-of-string-or-comment-in-programming-mode-p context-skk-on-keymap-defined-area-p context-skk-in-read-only-p) "\
*$BF|K\8lF~NO$r<+F0E*$K(B off $B$K$7$?$$!V%3%s%F%-%9%H!W$K$$$l$P(B t $B$rJV$9(B
$B4X?t$rEPO?$9$k!#(B")

(custom-autoload 'context-skk-context-check-hook "context-skk" t)

(defvar context-skk-custumize-functions '(context-skk-customize-kutouten) "\
*skk $B$K$h$kF~NO3+;OD>A0$K!"F~NO$r%+%9%?%^%$%:$9$k4X?t$rEPO?$9$k!#(B
$B4X?t$O0J2<$N7A<0$N%G!<%?$rMWAG$H$9$k%j%9%H$rJV$9$b$N$H$9$k(B: 

  (VARIABLE VALUE)

`skk-insert' $B$r0O$`(B `let' $B$K$h$C$F(B VARIABLE $B$O(B VALUE $B$KB+G{$5$l$k!#(B
$BFC$K$=$N>l$G%+%9%?%^%$%:$9$Y$-JQ?t$,$J$$>l9g(B `nil' $B$rJV$;$PNI$$!#(B
$B4X?t$K$O2?$b0z?t$,EO$5$l$J$$!#(B")

(custom-autoload 'context-skk-custumize-functions "context-skk" t)

(defvar context-skk-programming-mode '(ada-mode antlr-mode asm-mode autoconf-mode awk-mode c-mode objc-mode java-mode idl-mode pike-mode cperl-mode delphi-mode f90-mode fortran-mode icon-mode idlwave-mode inferior-lisp-mode lisp-mode m4-mode makefile-mode metafont-mode modula-2-mode octave-mode pascal-mode perl-mode prolog-mode ps-mode postscript-mode ruby-mode scheme-mode sh-mode simula-mode tcl-mode vhdl-mode emacs-lisp-mode) "\
*context-skk $B$K$F!V%W%m%0%i%_%s%0%b!<%I!W$H8+Pv$9%b!<%I$N%j%9%H(B")

(custom-autoload 'context-skk-programming-mode "context-skk" t)

(defvar context-skk-mode-hook nil "\
*`context-skk-mode' $B$r@Z$jBX$($k:]$K8F$P$l$k%U%C%/!#(B")

(custom-autoload 'context-skk-mode-hook "context-skk" t)

(defvar context-skk-mode-on-hook nil "\
*`context-skk-mode' $B$,(B on $B$K$J$k:]$K8F$P$l$k%U%C%/!#(B")

(custom-autoload 'context-skk-mode-on-hook "context-skk" t)

(defvar context-skk-mode-off-hook nil "\
*`context-skk-mode' $B$,(B off $B$K$J$k:]$K8F$P$l$k%U%C%/!#(B")

(custom-autoload 'context-skk-mode-off-hook "context-skk" t)

(defvar context-skk-mode-off-message "[context-skk] $BF|K\8lF~NO(B off" "\
*`context-skk-mode' $B$,(B off $B$K$J$C$?$H$-$K%(%3!<%(%j%"$KI=<($9$k%a%C%;!<%8!#(B")

(custom-autoload 'context-skk-mode-off-message "context-skk" t)
 (autoload 'context-skk-mode "context-skk" "$BJ8L.$K1~$8$F<+F0E*$K(Bskk$B$NF~NO%b!<%I$r(Blatin$B$K@Z$j49$($k%^%$%J!<%b!<%I!#(B" t)

;;;***

;;;### (autoloads nil "skk-abbrev" "skk-abbrev.el" (20722 33356 0
;;;;;;  0))
;;; Generated autoloads from skk-abbrev.el

(autoload 'skk-abbrev-search "skk-abbrev" "\


\(fn)" nil nil)

;;;***

;;;### (autoloads nil "skk-annotation" "skk-annotation.el" (20722
;;;;;;  33356 0 0))
;;; Generated autoloads from skk-annotation.el

(autoload 'skk-annotation-get "skk-annotation" "\


\(fn ANNOTATION)" nil nil)

(autoload 'skk-annotation-find-and-show "skk-annotation" "\
$B3F<o%j%=!<%9$+$i%"%N%F!<%7%g%s$r<hF@$7I=<($9$k!#(B

\(fn PAIR)" nil nil)

(autoload 'skk-annotation-show "skk-annotation" "\


\(fn ANNOTATION &optional WORD SOURCES)" nil nil)

(autoload 'skk-annotation-display-p "skk-annotation" "\


\(fn TEST)" nil nil)

(autoload 'skk-annotation-toggle-display-p "skk-annotation" "\


\(fn)" t nil)

(autoload 'skk-annotation-add "skk-annotation" "\
$B:G8e$K3NDj$7$?8l$K(B annotation $B$rIU$1$k!#(B
$B4{$K(B annotation $B$,IU$1$i$l$F$$$l$P!"$=$l$rJT=8%P%C%U%!$K=PNO$9$k!#(B
NO-PREVIOUS-ANNOTATION $B$r;XDj(B (\\[Universal-Argument] \\[skk-annotation-add])
$B$9$k$H!"4{$KIU$1$i$l$F$$$k(B annotation $B$rJT=8%P%C%U%!$K=PNO$7$J$$!#(B

\(fn &optional NO-PREVIOUS-ANNOTATION)" t nil)

(autoload 'skk-annotation-remove "skk-annotation" "\
$B:G8e$K3NDj$7$?8l$+$i(B annotation $B$r<h$j5n$k!#(B

\(fn)" t nil)

(autoload 'skk-annotation-quote "skk-annotation" "\
$B:G8e$K3NDj$7$?8l$K4^$^$l$k(B `;' $B$r8uJd$N0lIt$H$7$F(B quote $B$9$k!#(B

\(fn &optional QUIET)" t nil)

(autoload 'skk-annotation-message "skk-annotation" "\


\(fn &optional SITUATION)" nil nil)

(autoload 'skk-annotation-lookup-region-or-at-point "skk-annotation" "\
$BA*BrNN0h$^$?$O%]%$%s%H0LCV$NC18l$r<-=q$GD4$Y$k!#(B
$B<-=q$H$7$F$O(B lookup.el$B!"(BMac OS X $B$N<-=q%5!<%S%9!"(BWikipedia/Wikitionary $B$J$I$,(B
$BMxMQ$5$l$k!#(B

$BNN0h$,A*Br$5$l$F$$$J$1$l$PC18l$N;O$a$H=*$o$j$r?dB,$7$FD4$Y$k!#(B

$BD4$Y$?7k2L$r(B `skk-annotation-show-as-message' $B$,(B Non-nil $B$G$"$l$P%(%3!<%(%j%"(B
$B$K!"(Bnil $B$G$"$l$PJL(B window $B$KI=<($9$k!#(B

\(fn &optional PREFIX-ARG START END)" t nil)

(autoload 'skk-annotation-start-python "skk-annotation" "\
OS X $B$N!V<-=q!W$rMxMQ$9$k$?$a$K(B python $B$r5/F0$9$k!#(B

\(fn &optional WAIT)" nil nil)

(autoload 'skk-annotation-lookup-DictionaryServices "skk-annotation" "\
python $B$r2p$7$F(B DictionaryServices $B$rMxMQ$7%"%N%F!<%7%g%s$r<hF@$9$k!#(B
$B%*%W%7%g%s0z?t(B TRUNCATE $B$,(B non-nil $B$N>l9g$O8uJd0lMwMQ$KC;$$%"%N%F!<%7%g%s(B
$B$K9J$j$3$`!#(B

\(fn WORD &optional TRUNCATE FORCE)" nil nil)

(autoload 'skk-annotation-preread-dict "skk-annotation" "\
dict $B$N%W%m%;%9$r5/F0$9$k!#@hFI$_$N$?$a$KMQ$$$k!#(B

\(fn WORD &optional NOWAIT)" nil nil)

(autoload 'skk-annotation-lookup-dict "skk-annotation" "\
dict $B$N%W%m%;%9$rI,MW$J$i5/F0$7!"7k2L$rD4$Y$k!#(B
$B0UL#$,<hF@$G$-$?>l9g$K$O7k2L$rJ8;zNs$H$7$FJV$9!#(B

\(fn WORD &optional TRUNCATE)" nil nil)

(autoload 'skk-annotation-wikipedia "skk-annotation" "\
Wiktionary/Wikipedia $B$N(B WORD $B$KAjEv$9$k5-;v$+$i%"%N%F!<%7%g%s$r<hF@$9$k!#(B

\(fn WORD &optional SOURCES)" nil nil)

(defalias 'skk-annotation-wikipedia-region-or-at-point 'skk-annotation-lookup-region-or-at-point)

(autoload 'skkannot-cache "skk-annotation" "\


\(fn WORD &optional SOURCES)" nil nil)

;;;***

;;;### (autoloads nil "skk-auto" "skk-auto.el" (19945 34559 0 0))
;;; Generated autoloads from skk-auto.el

(autoload 'skk-okuri-search-1 "skk-auto" "\


\(fn)" nil nil)

(autoload 'skk-adjust-search-prog-list-for-auto-okuri "skk-auto" "\


\(fn)" nil nil)

;;;***

;;;### (autoloads nil "skk-cdb" "skk-cdb.el" (19847 49686 0 0))
;;; Generated autoloads from skk-cdb.el

(autoload 'skk-search-cdb-jisyo "skk-cdb" "\


\(fn CDB-PATH)" nil nil)

;;;***

;;;### (autoloads nil "skk-comp" "skk-comp.el" (20722 33356 0 0))
;;; Generated autoloads from skk-comp.el

(autoload 'skk-comp-start-henkan "skk-comp" "\
$B"&%b!<%I$GFI$_$rJd40$7$?8e!"JQ49$9$k!#(B
$B$=$l0J30$N%b!<%I$G$O%*%j%8%J%k$N%-!<%^%C%W$K3d$jIU$1$i$l$?%3%^%s%I$r%(%_%e%l!<(B
$B%H$9$k!#(B

\(fn ARG)" t nil)

(autoload 'skk-comp "skk-comp" "\


\(fn FIRST &optional SILENT)" nil nil)

(autoload 'skk-comp-do "skk-comp" "\


\(fn FIRST &optional SILENT SET-THIS-COMMAND)" nil nil)

(autoload 'skk-comp-get-all-candidates "skk-comp" "\


\(fn KEY PREFIX PROG-LIST)" nil nil)

(autoload 'skk-comp-get-regexp "skk-comp" "\


\(fn PREFIX)" nil nil)

(autoload 'skk-comp-from-jisyo "skk-comp" "\
SKK $B<-=q%U%)!<%^%C%H$N(B FILE $B$+$iJd408uJd$rF@$k!#(B

\(fn FILE)" nil nil)

(autoload 'skk-comp-search-current-buffer "skk-comp" "\


\(fn KEY &optional ABBREV)" nil nil)

(autoload 'skk-comp-previous "skk-comp" "\


\(fn &optional SET-THIS-COMMAND)" nil nil)

(autoload 'skk-comp-previous/next "skk-comp" "\


\(fn CH)" nil nil)

(autoload 'skk-try-completion "skk-comp" "\
$B"&%b!<%I$G8+=P$78l$rJd40$9$k!#(B
$B$=$l0J30$N%b!<%I$G$O!"%*%j%8%J%k$N%-!<3d$jIU$1$N%3%^%s%I$r%(%_%e%l!<%H$9$k!#(B

\(fn ARG)" t nil)

(autoload 'skk-comp-wrapper "skk-comp" "\
Character $B$G$J$$%-!<$KJd40$r3d$jEv$F$k$?$a$N%3%^%s%I!#(B

\(fn &optional ARG)" t nil)

(autoload 'skk-previous-comp-maybe "skk-comp" "\
Character $B$G$J$$%-!<$KJd40A08uJd$r3d$jEv$F$k$?$a$N%3%^%s%I!#(B
$B"&%b!<%I$G$OJd40A08uJd!"$5$b$J$1$l$P%*%j%8%J%k$N%-!<Dj5A$r<B9T$9$k!#(B

\(fn &optional ARG)" t nil)

(autoload 'skk-comp-by-history "skk-comp" "\
$BF~NO$,6u$N;~$KMzNr$+$iJd40$9$k!#(B
$BBP>]$O8=:_$N(B Emacs $B$N%;%C%7%g%s$K$*$$$F9T$C$?Aw$jL5$7JQ49$N$&$A!"(B
`skk-kakutei-history-limit' $B$G;XDj$5$l$k:G6a$N$b$N$G$"$k!#(B

\(fn)" nil nil)

(autoload 'skk-comp-smart-find "skk-comp" "\
`smart-find' $B$,8+$D$1$?%U%!%$%kL>$GJd40$9$k(B

\(fn &optional PATH)" nil nil)

(autoload 'skk-search-smart-find "skk-comp" "\
`smart-find'$B$rMxMQ$7$?JQ49$r9T$&!#(B
SKK abbrev $B%b!<%I$K$F!"1QJ8;z(B + `skk-completion-search-char' (~)$B$G(B
$BL$40%9%Z%k$r;XDj$7$FJQ49$9$k$H!"Jd408uJd$,JQ498uJd$H$7$F=P8=$9$k!#(B
$B%G%U%)%k%H$G$O(B SKK abbrev $B%b!<%I$N$_$GM-8z$J5!G=$@$,!"(B
NOT-ABBREV-ONLY $B$r;XDj$9$k;v$G>o$KM-8z$H$J$k!#(B

\(fn &optional PATH NOT-ABBREV-ONLY WITHOUT-CHAR-MAYBE)" nil nil)

(autoload 'skk-comp-lisp-symbol "skk-comp" "\
Lisp symbol $BL>$GJd40$9$k!#(B
PREDICATE $B$K0z?t(B 1 $B8D$N4X?t$r;XDj$9$l$P!"(BPREDICATE $B$rK~$?$9%7%s%\%k(B
$B$K8B$C$FJd40$9$k!#(BPREDICATE $B$K$O(B `fboundp', `boundp', `commandp'
$B$J$I$,;XDj$G$-$k!#;XDj$7$J$1$l$P4X?t$^$?$OJQ?t$K8B$C$FJd40$9$k!#(B

`skk-completion-prog-list' $B$XDI2C$9$k$HM-8z$H$J$k!#(B
\(add-to-list 'skk-completion-prog-list
	     '(skk-comp-lisp-symbol) t)

\(fn &optional PREDICATE)" nil nil)

(autoload 'skk-search-lisp-symbol "skk-comp" "\
Lisp symbol $BL>$GJd40$7$?7k2L$r8!:w7k2L$H$7$FJV$9!#(B
PREDICATE $B$K0z?t(B 1 $B8D$N4X?t$r;XDj$9$l$P!"(BPREDICATE $B$rK~$?$9%7%s%\%k(B
$B$K8B$C$FJd40$9$k!#(BPREDICATE $B$K$O(B `fboundp', `boundp', `commandp'
$B$J$I$,;XDj$G$-$k!#;XDj$7$J$1$l$P4X?t$^$?$OJQ?t$K8B$C$FJd40$9$k!#(B
SKK abbrev $B%b!<%I$K$F!"1QJ8;z(B + `skk-completion-search-char' (~)$B$G(B
$BL$40%9%Z%k$r;XDj$7$FJQ49$9$k$H!"Jd408uJd$,JQ498uJd$H$7$F=P8=$9$k!#(B
$B%G%U%)%k%H$G$O(B SKK abbrev $B%b!<%I$N$_$GM-8z$J5!G=$@$,!"(B
NOT-ABBREV-ONLY $B$r;XDj$9$k;v$G>o$KM-8z$H$J$k!#(B


$B@_DjNc(B
\(add-to-list 'skk-search-prog-list
	     '(skk-search-lisp-symbol) t)

\(fn &optional PREDICATE NOT-ABBREV-ONLY WITHOUT-CHAR-MAYBE)" nil nil)

(autoload 'skk-completion-search "skk-comp" "\
$BJQ49%-!<$GJd40$r9T$$!"F@$i$l$?3F8+=P$7$G$5$i$K8!:w$9$k!#(B
COMP-PROG-LIST $B$O(B `skk-completion-prog-list' $B$HF1$87A<0$G!"(B
$B$3$l$K4^$^$l$kJd404X?t$K$h$C$F!"$^$:JQ49%-!<$+$i8+=P$7$N%j%9%H$rF@$k!#(B
SEARCH-PROG-LIST $B$O(B `skk-search-prog-list' $B$HF1$87A<0$G!"(B
$BJd404X?t$K$h$C$FF@$?8+=P$7$r$3$l$K4^$^$l$k8!:w4X?t$K$h$jJQ498uJd$rF@$k!#(B
$B%G%U%)%k%H$G$O!"Jd40$K$h$C$FF@$i$l$?8+=P$7$HBP1~$9$k8uJd$O%;%C%H$G$"$k$,!"(B
WITHOUT-MIDASI $B$r;XDj$9$k$H8+=P$7$O>J$+$l$k!#(B

\(fn COMP-PROG-LIST &optional SEARCH-PROG-LIST WITHOUT-MIDASI WITHOUT-CHAR-MAYBE)" nil nil)

;;;***

;;;### (autoloads nil "skk-cursor" "skk-cursor.el" (20722 33356 0
;;;;;;  0))
;;; Generated autoloads from skk-cursor.el

(autoload 'skk-cursor-current-color "skk-cursor" "\


\(fn)" nil nil)

(autoload 'skk-cursor-set-1 "skk-cursor" "\


\(fn COLOR)" nil nil)

(autoload 'skk-cursor-off-1 "skk-cursor" "\


\(fn)" nil nil)

;;;***

;;;### (autoloads nil "skk-cus" "skk-cus.el" (20240 11454 0 0))
;;; Generated autoloads from skk-cus.el

(autoload 'skk-customize-group-skk "skk-cus" "\


\(fn)" t nil)

(autoload 'skk-customize "skk-cus" "\


\(fn)" t nil)

(autoload 'skk-cus-setup "skk-cus" "\


\(fn)" nil nil)

(autoload 'skk-cus-set "skk-cus" "\


\(fn &optional ALIST)" nil nil)

;;;***

;;;### (autoloads nil "skk-dcomp" "skk-dcomp.el" (20722 33356 0 0))
;;; Generated autoloads from skk-dcomp.el

(autoload 'skk-dcomp-marked-p "skk-dcomp" "\


\(fn)" nil nil)

(autoload 'skk-dcomp-before-kakutei "skk-dcomp" "\


\(fn)" nil nil)

(autoload 'skk-dcomp-after-delete-backward-char "skk-dcomp" "\


\(fn)" nil nil)

;;;***

;;;### (autoloads nil "skk-develop" "skk-develop.el" (20675 52382
;;;;;;  0 0))
;;; Generated autoloads from skk-develop.el

(autoload 'skk-submit-bug-report "skk-develop" "\
SKK $B$N%P%0%l%]!<%H$r=q$/%a!<%k%P%C%U%!$rMQ0U$9$k!#(B
mail-user-agent $B$r@_Dj$9$k$3$H$K$h$j9%$_$N%a!<%k%$%s%?!<%U%'%$%9$r;HMQ$9$k$3$H(B
$B$,$G$-$k!#Nc$($P!"(BWanderlust $B$r;HMQ$7$?$$>l9g$O2<5-$N$h$&$K@_Dj$9$k!#(B

    (setq mail-user-agent 'wl-user-agent) 

\(fn)" t nil)

(add-hook 'before-init-hook (lambda nil (eval-after-load "font-lock" '(setq lisp-font-lock-keywords-2 (nconc (list (list (concat "(\\(\\(skk-\\)?def\\(" "\\(un-cond\\|subst-cond\\|advice\\|" "macro-maybe\\|alias-maybe\\|un-maybe\\)\\|" "\\(var\\|localvar\\)" "\\)\\)\\>" "[ 	'(]*" "\\(\\sw+\\)?") '(1 font-lock-keyword-face) '(6 (cond ((match-beginning 4) font-lock-function-name-face) ((match-beginning 5) font-lock-variable-name-face)) nil t))) (list (list (concat "(" (regexp-opt '("skk-save-point" "skk-with-point-move" "skk-loop-for-buffers") t) "\\>") '(1 font-lock-keyword-face))) (list (list "(\\(skk-error\\)\\>" '(1 font-lock-warning-face))) lisp-font-lock-keywords-2))) (put 'skk-deflocalvar 'doc-string-elt 3) (put 'skk-defadvice 'doc-string-elt 3)))

;;;***

;;;### (autoloads nil "skk-gadget" "skk-gadget.el" (20750 16734 0
;;;;;;  0))
;;; Generated autoloads from skk-gadget.el

(autoload 'skk-current-date "skk-gadget" "\
`current-time-string' $B$N=PNO$r2C9)$7!"8=:_$NF|;~(B (string) $B$rJV$9!#(B
$B%*%W%7%g%J%k0z?t$N(B PP-FUNCTION $B$r;XDj$9$k$H!"(B
  `skk-current-date-1' $B$NJV$jCM!"(B FORMAT $B!"(B AND-TIME
$B$r0z?t$K$7$F(B PP-FUNCTION $B$r(B `funcall' $B$9$k!#(B
PP-FUNCTION $B$,(B nil $B$N>l9g$O(B `skk-default-current-date-function' $B$r(B
`funcall' $B$9$k!#(B
FORMAT $B$O(B `format' $B$NBh#10z?t$NMM<0(B (string) $B$K$h$k=PNO;XDj%F%s%W%l!<%H!#(B
AND-TIME (boolean) $B$r;XDj$9$k$H;~9o$bJV$9!#(B
`skk-today' $B$H(B `skk-clock' $B$N%5%V%k!<%A%s$G$"$k!#(B

\(fn &optional PP-FUNCTION FORMAT AND-TIME)" nil nil)

(autoload 'skk-default-current-date "skk-gadget" "\
$BF|IU>pJs$NI8=`E*$J=PNO$r$9$kB>!"%f!<%6$K$"$kDxEY$N%+%9%?%^%$%:5!G=$rDs6!$9$k!#(B
$B$3$N4X?t$N0z?t$G%+%9%?%^%$%:$G$-$J$$=PNO$r4uK>$9$k>l9g$O!"(B
`skk-default-current-date-function' $B$K<+A0$N4X?t$r;XDj$9$k!#(B

DATE-INFORMATION $B$O(B

  (year month day day-of-week hour minute second)

$B$N7A<0$N%j%9%H!#3FMWAG$OJ8;zNs!#(B`skk-current-date-1' $B$N=PNO$r;HMQ!#(B

FORMAT $B$O(B `format' $B$NBh#10z?t$NMM<0$K$h$k=PNO7ABV$r;XDj$9$kJ8;zNs!#(B
  nil $B$G$"$l$P(B \"%s$BG/(B%s$B7n(B%s$BF|(B(%s)%s$B;~(B%s$BJ,(B%s$BIC(B\" ($B$b$7$/$O(B
  \"%s$BG/(B%s$B7n(B%s$BF|(B(%s)\" $B$,;H$o$l$k!#(B

NUM-TYPE (number) $B$O(B
  0 -> $BL5JQ49(B
  1 -> $BA43Q?t;z$XJQ49(B
  2 -> $B4A?t;z$XJQ49(B ($B0L<h$j$J$7(B)
  3 -> $B4A?t;z$XJQ49(B ($B0L<h$j$r$9$k(B)
  4 -> $B$=$N?t;z$=$N$b$N$r%-!<$K$7$F<-=q$r:F8!:w(B
  5 -> $B4A?t;z(B ($B<j7A$J$I$G;HMQ$9$kJ8;z$r;HMQ(B)$B$XJQ49(B ($B0L<h$j$r$9$k(B)
  9 -> $B>-4}$G;HMQ$9$k?t;z(B (\"$B#3;M(B\" $B$J$I(B) $B$KJQ49(B

GENGO $B$O859fI=<($9$k$+$I$&$+(B (boolean)$B!#(B

GENGO-INDEX $B$O(B `skk-gengo-alist' $B$N3FMWAG$N(B cadr $B$r(B 0 $B$H$9$k(B index
 (number)$B!#(Bnil $B$G$"$l$P(B `current-time-string' $B$N=PNO$N$^$^L5JQ49!#(B

MONTH-ALIST-INDEX $B$O(B `skk-month-alist' $B$N3FMWAG$N(B cadr $B$r(B 0 $B$H$9$k(B
 index (number)$B!#(Bnil $B$G$"$l$P(B `current-time-string' $B$N=PNO$N$^$^L5JQ49!#(B

DAYOFWEEK-ALIST-INDEX $B$O(B `skk-day-of-week-alist' $B$N3FMWAG$N(B cadr $B$r(B
 0 $B$H$9$k(B index (number)$B!#(Bnil $B$G$"$l$P(B `current-time-string' $B$N=PNO$N$^(B
$B$^L5JQ49!#(B

AND-TIME $B$O;~9o$bI=<($9$k$+$I$&$+(B (boolean)$B!#(B

\(fn DATE-INFORMATION FORMAT NUM-TYPE GENGO GENGO-INDEX MONTH-ALIST-INDEX DAYOFWEEK-ALIST-INDEX &optional AND-TIME)" nil nil)

(autoload 'skk-relative-date "skk-gadget" "\
`skk-current-date' $B$N3HD%HG!#(BPP-FUNCTION, FORMAT, AND-TIME $B$O(B `skk-current-date' $B$r;2>H$N$3$H!#(B
$B<B9TNc(B
 (skk-relative-date) => \"$BJ?@.(B25$BG/(B2$B7n(B03$BF|(B($BF|(B)\"
 (skk-relative-date (lambda (arg) body) nil nil :dd -1) => \"$BJ?@.(B25$BG/(B2$B7n(B02$BF|(B($BEZ(B)\"
 (skk-relative-date (lambda (arg) body) nil nil :mm -1) => \"$BJ?@.(B25$BG/(B1$B7n(B03$BF|(B($BLZ(B)\"
 (skk-relative-date (lambda (arg) body) nil nil :yy  2) => \"$BJ?@.(B27$BG/(B2$B7n(B03$BF|(B($B2P(B)\"

\(fn PP-FUNCTION FORMAT AND-TIME &key (yy 0) (mm 0) (dd 0))" nil nil)

(autoload 'skk-today "skk-gadget" "\
`current-time-string' $B$N=PNO$r2C9)$7!"8=:_$NF|;~$rI=$9J8;zNs$r:n$j!"A^F~(B
$B$9$k!#<B<AE*$K!V(Btoday $B%(%s%H%j$N8F$S=P$7!W$@$1$J$N$G!"%+%9%?%^%$%:$O8D?M(B
$B<-=q$N(B today $B%(%s%H%j$K$h$k!#(B

\(fn ARG)" t nil)

(autoload 'skk-clock "skk-gadget" "\
$B%_%K%P%C%U%!$K%G%8%?%k;~7W$rI=<($9$k!#(B
quit $B$9$k$H!"$=$N;~E@$NF|;~$r8uJd$H$7$FA^F~$9$k!#(B
quit $B$7$?$H$-$K5/F0$7$F$+$i$N7P2a;~4V$r%_%K%P%C%U%!$KI=<($9$k!#(B
interactive $B$K5/F0$9$kB>!"(B\"clock /(skk-clock)/\" $B$J$I$N%(%s%H%j$r(B SKK $B$N<-=q(B
$B$K2C$(!"(B\"/clock\"+ SPC $B$GJQ49$9$k$3$H$K$h$C$F$b5/F02D!#(B\\[keyboard-quit] $B$G;_$^$k!#(B
$B<B9TJQ49$G5/F0$7$?>l9g$O!"(B\\[keyboard-quit] $B$7$?;~E@$N;~E@$NF|;~$rA^F~$9$k!#(B

$B%*%W%7%g%J%k0z?t$N(B KAKUTEI-WHEN-QUIT $B$,(B non-nil $B$G$"$l$P(B \\[keyboard-quit] $B$7$?$H$-$K3NDj$9$k!#(B
$B%*%W%7%g%J%k0z?t$N(B TIME-SIGNAL $B$,(B non-nil $B$G$"$l$P!"(BNTT $B$N;~JsIw$K(B ding $B$9$k!#(B
$B$=$l$>$l(B \"clock /(skk-clock nil t)/\" $B$N$h$&$J%(%s%H%j$r<-=q$KA^F~$9$l$PNI$$!#(B
`skk-date-ad' $B$H(B `skk-number-style' $B$K$h$C$FI=<(J}K!$N%+%9%?%^%$%:$,2DG=!#(B

\(fn &optional KAKUTEI-WHEN-QUIT TIME-SIGNAL)" t nil)

(autoload 'skk-ad-to-gengo "skk-gadget" "\


\(fn GENGO-INDEX &optional DIVIDER TAIL NOT-GANNEN)" nil nil)

(autoload 'skk-ad-to-gengo-1 "skk-gadget" "\


\(fn AD &optional NOT-GANNEN)" nil nil)

(autoload 'skk-gengo-to-ad "skk-gadget" "\


\(fn &optional HEAD TAIL)" nil nil)

(autoload 'skk-gengo-to-ad-1 "skk-gadget" "\


\(fn GENGO NUMBER)" nil nil)

(autoload 'skk-calc "skk-gadget" "\


\(fn OPERATOR)" nil nil)

(autoload 'skk-plus "skk-gadget" "\


\(fn)" nil nil)

(autoload 'skk-minus "skk-gadget" "\


\(fn)" nil nil)

(autoload 'skk-times "skk-gadget" "\


\(fn)" nil nil)

(autoload 'skk-ignore-dic-word "skk-gadget" "\


\(fn &rest NO-SHOW-LIST)" nil nil)

(autoload 'skk-henkan-face-off-and-remove-itself "skk-gadget" "\


\(fn)" nil nil)

(autoload 'skk-gadget-units-conversion "skk-gadget" "\
`skk-units-alist'$B$r;2>H$7!"49;;$r9T$&!#(B
NUMBER $B$K$D$$$F(B UNIT-FROM $B$+$i(B UNIT-TO $B$X$N49;;$r9T$&!#(B

\(fn UNIT-FROM NUMBER UNIT-TO)" nil nil)

;;;***

;;;### (autoloads nil "skk-inline" "skk-inline.el" (20240 63939 0
;;;;;;  0))
;;; Generated autoloads from skk-inline.el

(autoload 'skk-inline-show "skk-inline" "\


\(fn STR FACE &optional VERTICAL-STR TEXT-MAX-HEIGHT)" nil nil)

;;;***

;;;### (autoloads nil "skk-isearch" "skk-isearch.el" (20668 32951
;;;;;;  0 0))
;;; Generated autoloads from skk-isearch.el

(autoload 'skk-isearch-message "skk-isearch" "\
Show isearch message.

\(fn)" nil nil)

(autoload 'skk-isearch-mode-setup "skk-isearch" "\
hook function called when skk isearch begin.

\(fn)" nil nil)

(autoload 'skk-isearch-mode-cleanup "skk-isearch" "\
Hook function called when skk isearch is done.

\(fn)" nil nil)

(autoload 'skk-isearch-skk-mode "skk-isearch" "\


\(fn &rest ARGS)" t nil)

(defconst skk-isearch-really-early-advice (lambda nil (defadvice isearch-message-prefix (around skk-isearch-ad activate) (let ((current-input-method (unless (and (boundp 'skk-isearch-switch) skk-isearch-switch) current-input-method))) ad-do-it)) (defadvice isearch-toggle-input-method (around skk-isearch-ad activate) (cond ((string-match "^japanese-skk" (format "%s" default-input-method)) (let ((skk-isearch-initial-mode-when-skk-mode-disabled 'latin)) (skk-isearch-mode-setup) (skk-isearch-skk-mode))) ((null default-input-method) ad-do-it (when (string-match "^japanese-skk" (format "%s" default-input-method)) (let ((skk-isearch-initial-mode-when-skk-mode-disabled 'latin)) (skk-isearch-mode-setup)) (skk-deactivate-input-method))) (t ad-do-it)))))

(unless (featurep 'xemacs) (define-key isearch-mode-map [(control \\)] 'isearch-toggle-input-method) (cond ((and (featurep 'advice) (assq 'skk-isearch-ad (assq 'around (ad-get-advice-info 'isearch-toggle-input-method)))) nil) ((locate-library "advice") (funcall skk-isearch-really-early-advice)) (t (add-hook 'before-init-hook skk-isearch-really-early-advice))))

;;;***

;;;### (autoloads nil "skk-jisx0201" "skk-jisx0201.el" (20722 33356
;;;;;;  0 0))
;;; Generated autoloads from skk-jisx0201.el

(autoload 'skk-jisx0201-mode "skk-jisx0201" "\
SKK $B$N%b!<%I$r(B JIS X 0201 $B%b!<%I$KJQ99$9$k!#(B

\(fn ARG)" t nil)

(autoload 'skk-toggle-katakana "skk-jisx0201" "\


\(fn ARG)" t nil)

(autoload 'skk-hiragana-to-jisx0201-region "skk-jisx0201" "\


\(fn START END)" nil nil)

(autoload 'skk-katakana-to-jisx0201-region "skk-jisx0201" "\


\(fn START END)" nil nil)

;;;***

;;;### (autoloads nil "skk-jisyo-edit-mode" "skk-jisyo-edit-mode.el"
;;;;;;  (19991 41203 0 0))
;;; Generated autoloads from skk-jisyo-edit-mode.el

(autoload 'skk-jisyo-edit-mode "skk-jisyo-edit-mode" "\
Major mode for editing SKK JISYO.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("SKK-JISYO" . skk-jisyo-edit-mode) t)

(add-to-list 'auto-mode-alist '("\\.skk-jisyo\\(\\.BAK\\|\\.bak\\|~\\)?$" . skk-jisyo-edit-mode))

(add-to-list 'auto-mode-alist '("\\..*skk/jisyo\\(\\.BAK\\|\\.bak\\|~\\)?$" . skk-jisyo-edit-mode))

(autoload 'skk-edit-private-jisyo "skk-jisyo-edit-mode" "\
$B8D?M<-=q%U%!%$%k(B `skk-jisyo' $B$rJT=8$9$k!#(B
$BG$0U$G$N8D?M<-=qJ]B8$N$"$H!"(B`skk-jisyo' $B$r3+$-!"(B`skk-jisyo-edit-mode' $B$KF~$k!#(B
$B%m!<%+%k$K(B $B0J2<$N%-!<Dj5A$,DI2C$5$l$k!#(B

key       binding
---       -------
C-c C-c   Save & Exit
C-c C-k   Abort

SKK $B;HMQCf$N>l9g$O(B SKK $B$K$h$k8D?M<-=q%P%C%U%!$N99?7$,6X;_$5$l$k!#(B

$B%*%W%7%g%J%k0z?t(B CODING-SYSTEM $B$K$F8D?M<-=q$N%3!<%I7O$r;XDj2DG=!#(B

$B$3$N5!G=$O=>Mh$N<jF0$G$N8D?M<-=qJT=8$h$jG[N8$5$l$F$$$k$,!"(BSKK $B<-=q$N9=J8$r(B
$B%A%'%C%/$9$k$3$H$O$G$-$:!"<+8J@UG$$G$NJT=8$G$"$k$3$H$OJQ$o$j$J$$!#(B

\(fn &optional CODING-SYSTEM)" t nil)

;;;***

;;;### (autoloads nil "skk-kakasi" "skk-kakasi.el" (20130 9048 0
;;;;;;  0))
;;; Generated autoloads from skk-kakasi.el

(autoload 'skk-gyakubiki-region "skk-kakasi" "\
$BNN0h$N4A;z!"Aw$j2>L>$rA4$F$R$i$,$J$KJQ49$9$k!#(B
$B%*%W%7%g%J%k0z?t$N(B ALL $B$,(B non-nil $B$J$i$P!"J#?t$N8uJd$,$"$k>l9g$O!"(B\"{}\" $B$G$/(B
$B$/$C$FI=<($9$k!#(B
$BNc$($P!"(B
    $BCfEg(B -> {$B$J$+$7$^(B|$B$J$+$8$^(B}

\(fn START END &optional ALL)" t nil)

(autoload 'skk-gyakubiki-and-henkan "skk-kakasi" "\
$BNN0h$N4A;z$r$R$i$,$J$KJQ49$7!"$=$N$R$i$,$J$r8+=P$78l$H$7$F$+$J4A;zJQ49$r<B9T$9$k!#(B

\(fn START END)" t nil)

(autoload 'skk-gyakubiki-message "skk-kakasi" "\
$BNN0h$N4A;z!"Aw$j2>L>$rA4$F$R$i$,$J$KJQ498e!"%(%3!<$9$k!#(B
$B%*%W%7%g%J%k0z?t$N(B ALL $B$,(B non-nil $B$J$i$P!"J#?t$N8uJd$,$"$k>l9g$O!"(B\"{}\" $B$G$/(B
$B$/$C$FI=<($9$k!#(B
$BNc$($P!"(B
    $BCfEg(B -> {$B$J$+$7$^(B|$B$J$+$8$^(B}

\(fn START END &optional ALL)" t nil)

(autoload 'skk-gyakubiki-katakana-region "skk-kakasi" "\
$BNN0h$N4A;z!"Aw$j2>L>$rA4$F%+%?%+%J$KJQ49$9$k!#(B
$B%*%W%7%g%J%k0z?t$N(B ALL $B$,(B non-nil $B$J$i$P!"J#?t$N8uJd$,$"$k>l9g$O!"(B\"{}\" $B$G$/(B
$B$/$C$FI=<($9$k!#(B
$BNc$($P!"(B
    $BCfEg(B -> {$B%J%+%7%^(B|$B%J%+%8%^(B}

\(fn START END &optional ALL)" t nil)

(autoload 'skk-gyakubiki-katakana-message "skk-kakasi" "\
$BNN0h$N4A;z!"Aw$j2>L>$rA4$F%+%?%+%J$KJQ498e!"%(%3!<$9$k!#(B
$B%*%W%7%g%J%k0z?t$N(B ALL $B$,(B non-nil $B$J$i$P!"J#?t$N8uJd$,$"$k>l9g$O!"(B\"{}\" $B$G$/(B
$B$/$C$FI=<($9$k!#(B
$BNc$($P!"(B
    $BCfEg(B -> {$B%J%+%7%^(B|$B%J%+%8%^(B}

\(fn START END &optional ALL)" t nil)

(autoload 'skk-hurigana-region "skk-kakasi" "\
$BNN0h$N4A;z$KA4$F$U$j$,$J$rIU$1$k!#(B
$BNc$($P!"(B
   \"$BJQ49A0$N4A;z$NOF$K(B\" -> \"$BJQ49A0(B[$B$X$s$+$s$^$((B]$B$N4A;z(B[$B$+$s$8(B]$B$NOF(B[$B$o$-(B]$B$K(B\"

$B%*%W%7%g%J%k0z?t$N(B ALL $B$,(B non-nil $B$J$i$P!"J#?t$N8uJd$,$"$k>l9g$O!"(B\"{}\" $B$G$/(B
$B$/$C$FI=<($9$k!#(B
$BNc$($P!"(B
    \"$BCfEg(B\" -> \"$BCfEg(B[{$B$J$+$7$^(B|$B$J$+$8$^(B}]\"

\(fn START END &optional ALL)" t nil)

(autoload 'skk-hurigana-message "skk-kakasi" "\
$BNN0h$N4A;z$KA4$F$U$j$,$J$rIU$1!"%(%3!<$9$k!#(B
$BNc$($P!"(B
   \"$BJQ49A0$N4A;z$NOF$K(B\" -> \"$BJQ49A0(B[$B$X$s$+$s$^$((B]$B$N4A;z(B[$B$+$s$8(B]$B$NOF(B[$B$o$-(B]$B$K(B\"

$B%*%W%7%g%J%k0z?t$N(B ALL $B$,(B non-nil $B$J$i$P!"J#?t$N8uJd$,$"$k>l9g$O!"(B\"{}\" $B$G$/(B
$B$/$C$FI=<($9$k!#(B
$BNc$($P!"(B
    \"$BCfEg(B\" -> \"$BCfEg(B[{$B$J$+$7$^(B|$B$J$+$8$^(B}]\"

\(fn START END &optional ALL)" t nil)

(autoload 'skk-hurigana-katakana-region "skk-kakasi" "\
$BNN0h$N4A;z$KA4$F%U%j%,%J$rIU$1$k!#(B
$BNc$($P!"(B
   \"$BJQ49A0$N4A;z$NOF$K(B\" -> \"$BJQ49A0(B[$B%X%s%+%s%^%((B]$B$N4A;z(B[$B%+%s%8(B]$B$NOF(B[$B%o%-(B]$B$K(B\"

$B%*%W%7%g%J%k0z?t$N(B ALL $B$,(B non-nil $B$J$i$P!"J#?t$N8uJd$,$"$k>l9g$O!"(B\"{}\" $B$G$/(B
$B$/$C$FI=<($9$k!#(B
$BNc$($P!"(B
    \"$BCfEg(B\" -> \"$BCfEg(B[{$B%J%+%7%^(B|$B%J%+%8%^(B}]\"

\(fn START END &optional ALL)" t nil)

(autoload 'skk-hurigana-katakana-message "skk-kakasi" "\
$BNN0h$N4A;z$KA4$F%U%j%,%J$rIU$1!"%(%3!<$9$k!#(B
$BNc$($P!"(B
   \"$BJQ49A0$N4A;z$NOF$K(B\" -> \"$BJQ49A0(B[$B%X%s%+%s%^%((B]$B$N4A;z(B[$B%+%s%8(B]$B$NOF(B[$B%o%-(B]$B$K(B\"

$B%*%W%7%g%J%k0z?t$N(B ALL $B$,(B non-nil $B$J$i$P!"J#?t$N8uJd$,$"$k>l9g$O!"(B\"{}\" $B$G$/(B
$B$/$C$FI=<($9$k!#(B
$BNc$($P!"(B
    \"$BCfEg(B\" -> \"$BCfEg(B[{$B%J%+%7%^(B|$B%J%+%8%^(B}]\"

\(fn START END &optional ALL)" t nil)

(autoload 'skk-romaji-region "skk-kakasi" "\
$BNN0h$N4A;z!"$R$i$,$J!"%+%?%+%J!"A41QJ8;z$rA4$F%m!<%^;z$KJQ49$9$k!#(B
$BJQ49$K$O!"%X%\%s<0$rMQ$$$k!#(B
$BNc$($P!"(B
   \"$B4A;z$+$J:.$8$jJ8$r%m!<%^;z$KJQ49(B\"
    -> \"  kan'zi  kana  ma  ziri  bun'  woro-ma  zi ni hen'kan' \"

`skk-romaji-*-by-hepburn' $B$,(B nil $B$G$"$l$P!"%m!<%^;z$X$NJQ49MM<0$r71Na<0$KJQ99$9(B
$B$k!#Nc$($P!"(B\"$B$7(B\" $B$O%X%\%s<0$G$O(B \"shi\" $B$@$,!"71Na<0$G$O(B \"si\" $B$H$J$k!#(B

\(fn START END)" t nil)

(autoload 'skk-romaji-message "skk-kakasi" "\
$BNN0h$N4A;z!"$R$i$,$J!"%+%?%+%J!"A41QJ8;z$rA4$F%m!<%^;z$KJQ49$7!"%(%3!<$9$k!#(B
$BJQ49$K$O!"%X%\%s<0$rMQ$$$k!#(B
$BNc$($P!"(B
   \"$B4A;z$+$J:.$8$jJ8$r%m!<%^;z$KJQ49(B\"
    -> \"  kan'zi  kana  ma  ziri  bun'  woro-ma  zi ni hen'kan' \"

`skk-romaji-*-by-hepburn' $B$,(B nil $B$G$"$l$P!"%m!<%^;z$X$NJQ49MM<0$r71Na<0$KJQ99$9(B
$B$k!#Nc$($P!"(B\"$B$7(B\" $B$O%X%\%s<0$G$O(B \"shi\" $B$@$,!"71Na<0$G$O(B \"si\" $B$H$J$k!#(B

\(fn START END)" t nil)

;;;***

;;;### (autoloads nil "skk-kcode" "skk-kcode.el" (20659 26048 0 0))
;;; Generated autoloads from skk-kcode.el

(autoload 'skk-input-by-code-or-menu "skk-kcode" "\
$BJQ?t(B `skk-kcode-method' $B$G;XDj$5$l$?5!G=$rMQ$$$FJ8;z$rA^F~$9$k!#(B

\(fn &optional ARG)" t nil)

(autoload 'skk-display-code-for-char-at-point "skk-kcode" "\
$B%]%$%s%H$K$"$kJ8;z$N6hE@HV9f!"(BJIS $B%3!<%I!"(BEUC $B%3!<%I!"%7%U%H(B JIS $B%3!<%I5Z$S%f%K%3!<%I$rI=<($9$k!#(B

\(fn &optional ARG)" t nil)

(autoload 'skk-list-chars "skk-kcode" "\
$BJQ?t(B `skk-kcode-charset' $B$K=>$C$FJ8;z0lMw$rI=<($9$k(B.
\\[universal-argument] $BIU$-$G<B9T$9$k$H!"(Bfollowing-char() $B$rM%@hI=<($9$k(B.

\(fn ARG)" t nil)

;;;***

;;;### (autoloads nil "skk-leim" "skk-leim.el" (20518 14470 0 0))
;;; Generated autoloads from skk-leim.el

(autoload 'skk-activate "skk-leim" "\


\(fn &optional NAME)" nil nil)

(autoload 'skk-auto-fill-activate "skk-leim" "\


\(fn &optional NAME)" nil nil)

(autoload 'skk-inactivate "skk-leim" "\


\(fn)" nil nil)

(autoload 'skk-auto-fill-inactivate "skk-leim" "\


\(fn)" nil nil)

(register-input-method "japanese-skk" "Japanese" 'skk-activate "" "Simple Kana to Kanji conversion program")

(register-input-method "japanese-skk-auto-fill" "Japanese" 'skk-auto-fill-activate "" "Simple Kana to Kanji conversion program with auto-fill")

;;;***

;;;### (autoloads nil "skk-look" "skk-look.el" (20722 33356 0 0))
;;; Generated autoloads from skk-look.el

(autoload 'skk-look "skk-look" "\
UNIX look $B%3%^%s%I$rMxMQ$7$FJQ49$9$k!#(B
SKK abbrev $B%b!<%I$K$F!"1QJ8;z(B + $B%"%9%?%j%9%/$G(B uncompleted spelling $B$r;XDj$9$k!#(B
$B>\$7$/$O(B skk-look.el $B%U%!%$%k$N%3%a%s%H$d(B Info $B$r;2>H$N;v!#(B
CONVERSION-ARGUMENTS $B$O(B `skk-look-conversion-arguments' $B$r(B
$B0l;~E*$KCV$-49$($?$$;~$K;XDj$9$k!#(B
$B%G%U%)%k%H$G$O(B SKK abbrev $B%b!<%I$N$_$GM-8z$J5!G=$@$,!"(B
NOT-ABBREV-ONLY $B$r;XDj$9$k;v$G>o$KM-8z$H$J$k!#(B
EXPAND-NULL $B$r;XDj$9$k$H!"F~NO$,(B \"*\" $B$N$_$N;~$O(B
words $B%U%!%$%k$K$"$kA4$F$N8+=P$7$,BP>]$H$J$k!#(B
`skk-look-recursive-search', `skk-look-expanded-word-only',
`skk-look-use-ispell' $B$r0l;~E*$KJQ99$7$?$$>l9g$K$O(B
`let' $B$K$h$jB+G{$7$F;H$&;v!#(B

\(fn &optional CONVERSION-ARGUMENTS NOT-ABBREV-ONLY EXPAND-NULL)" nil nil)

(autoload 'skk-look-completion "skk-look" "\
look $B%3%^%s%I$rMxMQ$7$FJd408uJd$rF@$k!#(B
COMPLETION-ARGUMENTS $B$O(B `skk-look-completion-arguments' $B$r(B
$B0l;~E*$KCV$-49$($?$$;~$K;XDj$9$k!#(B
$B%G%U%)%k%H$G$O(B SKK abbrev $B%b!<%I$N$_$GM-8z$J5!G=$@$,!"(B
NOT-ABBREV-ONLY $B$r;XDj$9$k;v$G>o$KM-8z$H$J$k!#(B
EXPAND-NULL $B$r;XDj$9$k$H!"F~NO$,6u$G$"$k;~$K(B
words $B%U%!%$%k$K$"$kA4$F$N8+=P$7$rJV$9!#(B
`skk-look-use-ispell' $B$r0l;~E*$KJQ99$7$?$$>l9g$K$O(B
`let' $B$K$h$jB+G{$7$F;H$&;v!#(B

\(fn &optional COMPLETION-ARGUMENTS NOT-ABBREV-ONLY EXPAND-NULL)" nil nil)

(autoload 'skk-look-ispell "skk-look" "\


\(fn WORD &optional SITUATION)" nil nil)

;;;***

;;;### (autoloads nil "skk-macs" "skk-macs.el" (20722 33356 0 0))
;;; Generated autoloads from skk-macs.el

(put 'skk-defadvice 'lisp-indent-function 'defun)

(put 'skk-loop-for-buffers 'lisp-indent-function 1)

;;;***

;;;### (autoloads nil "skk-num" "skk-num.el" (20728 431 0 0))
;;; Generated autoloads from skk-num.el

(autoload 'skk-num-compute-henkan-key "skk-num" "\
KEY $B$NCf$NO"B3$9$k?t;z$r8=$o$9J8;zNs$r(B \"#\" $B$KCV$-49$($?J8;zNs$rJV$9!#(B
\"12\" $B$d(B \"$B#0#9(B\" $B$J$IO"B3$9$k?t;z$r(B 1 $B$D$N(B \"#\" $B$KCV$-49$($k$3$H$KCm0U!#(B
$BCV$-49$($??t;z$r(B `skk-num-list' $B$NCf$K%j%9%H$N7A$GJ]B8$9$k!#(B
$BNc$($P!"(BKEY $B$,(B \"$B$X$$$;$$(B7$B$M$s(B12$B$,$D(B\" $B$G$"$l$P!"(B\"$B$X$$$;$$(B#$B$M$s(B#$B$,$D(B\"
$B$HJQ49$7!"(B`skk-num-list' $B$K(B (\"7\" \"12\") $B$H$$$&%j%9%H$rBeF~$9$k!#(B
$B<-=q$N8+=P$78l$N8!:w$K;HMQ$9$k!#(B

\(fn KEY)" nil nil)

(autoload 'skk-num-convert "skk-num" "\
INDEX $B$,;X$9(B `skk-henkan-list' $B$NMWAG$r?tCMJQ49$N$?$a$K2C9)$9$k!#(B
`skk-henkan-list' $B$N(B INDEX $B$,;X$7$F$$$k8uJd(B ($B?tCMJQ49%-!<$N(B)$B$r(B
  \"#2\" -> (\"#2\" .\"$B0l(B\")
$B$N$h$&$KJQ49$9$k!#(B

\(fn INDEX)" nil nil)

(autoload 'skk-num-multiple-convert "skk-num" "\


\(fn &optional COUNT)" nil nil)

(autoload 'skk-num-exp "skk-num" "\
ascii $B?t;z(B (string) $B$N(B NUM $B$r(B TYPE $B$K=>$C$FJQ49$7$?J8;zNs$rJV$9!#(B
TYPE $B$O2<5-$NDL$j!#(B
0 -> $BL5JQ49(B
1 -> $BA43Q?t;z$XJQ49(B
2 -> $B4A?t;z(B ($B0L<h$j$"$j(B) $B$XJQ49!#Nc(B;1024 -> $B0l!;Fs;M(B
3 -> $B4A?t;z(B ($B0L<h$j$J$7(B) $B$XJQ49!#Nc(B;1024 -> $B@iFs==;M(B
4 -> $B$=$N?t;z$=$N$b$N$r%-!<$K$7$F<-=q$r:F8!:w(B
5 -> $B4A?t;z(B ($B<j7A$J$I$G;HMQ$9$kJ8;z$r;HMQ(B) $B$XJQ49(B
8 -> $B7e6h@Z$j$XJQ49(B (1,234,567)
9 -> $B>-4}$G;HMQ$9$k?t;z(B (\"$B#3;M(B\" $B$J$I(B) $B$XJQ49(B

\(fn NUM TYPE)" nil nil)

(autoload 'skk-num-uniq "skk-num" "\


\(fn)" nil nil)

(autoload 'skk-num-initialize "skk-num" "\
`skk-use-numeric-conversion' $B4XO"$NJQ?t$r=i4|2=$9$k!#(B

\(fn)" nil nil)

(autoload 'skk-num-henkan-key "skk-num" "\
$BE,@Z$JJQ49%-!<$rJV$9!#(B
type4 $B$N?tCM:FJQ49$,9T$o$l$?$H$-$O!"?tCM<+?H$rJV$7!"$=$l0J30$N?tCMJQ49(B
$B$G$O!"(B`skk-henkan-key' $B$N?tCM$r(B \"#\" $B$GCV$-49$($?%-!<$rJV$9!#(B

\(fn)" nil nil)

(autoload 'skk-num-update-jisyo "skk-num" "\
$B?t;z<+?H$r8+=P$78l$H$7$F<-=q$r%"%C%W%G!<%H$9$k!#(B

\(fn NOCONVWORD WORD &optional PURGE)" nil nil)

(autoload 'skk-num "skk-num" "\
$B?t;z$r(B `skk-number-style' $B$NCM$K=>$$JQ49$9$k!#(B
`skk-current-date' $B$N%5%V%k!<%A%s!#(B

\(fn STR)" nil nil)

;;;***

;;;### (autoloads nil "skk-server-completion" "skk-server-completion.el"
;;;;;;  (20722 33356 0 0))
;;; Generated autoloads from skk-server-completion.el

(autoload 'skk-server-completion-search "skk-server-completion" "\
$B%5!<%P!<%3%s%W%j!<%7%g%s$r9T$$!"F@$i$l$?3F8+=P$7$G$5$i$K8!:w$9$k!#(B
$BAw$jM-$jJQ49$K$OHsBP1~!#(B

\(fn)" nil nil)

(autoload 'skk-comp-by-server-completion "skk-server-completion" "\
Server completion $B$KBP1~$7$?<-=q%5!<%P$rMxMQ$9$kJd40%W%m%0%i%`!#(B
`skk-completion-prog-list' $B$NMWAG$K;XDj$7$F;H$&!#(B

\(fn)" nil nil)

;;;***

;;;### (autoloads nil "skk-server" "skk-server.el" (20152 22069 0
;;;;;;  0))
;;; Generated autoloads from skk-server.el

(autoload 'skk-server-version "skk-server" "\
Return version information of SKK server.
When called interactively, print version information.

\(fn)" t nil)

(autoload 'skk-search-server-1 "skk-server" "\
`skk-search-server' $B$N%5%V%k!<%A%s!#(B

\(fn FILE LIMIT)" nil nil)

(autoload 'skk-adjust-search-prog-list-for-server-search "skk-server" "\
$BJQ?t(B `skk-search-prog-list' $B$rD4@0$9$k!#(B
`skk-server-host' $B$b$7$/$O(B `skk-servers-list' $B$,(B nil $B$G$"$l$P!"(B
`skk-search-prog-list' $B$+$i(B `skk-search-server' $B$r(B car $B$K;}$D%j%9%H$r>C$9!#(B
non-nil $B$G$"$l$P!"2C$($k!#(B

\(fn &optional NON-DEL)" nil nil)

(autoload 'skk-disconnect-server "skk-server" "\
$B<-=q%5!<%P$r@Z$jN%$9!#(B

\(fn)" nil nil)

;;;***

;;;### (autoloads nil "skk-show-mode" "skk-show-mode.el" (20712 44170
;;;;;;  0 0))
;;; Generated autoloads from skk-show-mode.el

(autoload 'skk-show-mode "skk-show-mode" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil "skk-tankan" "skk-tankan.el" (20635 38961 0
;;;;;;  0))
;;; Generated autoloads from skk-tankan.el

(autoload 'skk-tankan "skk-tankan" "\
$BC14A;zJQ49$r3+;O$9$k!#(B
\\[skk-tankan] $B$GIt<sJQ49$r!"(B
\\[universal-argument] $B?tCM(B \\[skk-tankan] $B$GAm2h?tJQ49$r3+;O$9$k!#(B

\(fn ARG)" t nil)

(autoload 'skk-tankan-search "skk-tankan" "\
$BJQ?t(B `skk-henkan-key' $B$G;XDj$5$l$?!VFI$_!W$K4p$E$$$FC14A;zJQ49$r<B9T$9$k!#(B
$BDL>o$O(B `skk-search-prog-list' $B$N#1MWAG$H$7$F<!$N7A<0$G;XDj$5$l$k!#(B
'(skk-tankan-search 'skk-search-jisyo-file
                    skk-large-jisyo 10000))

\(fn FUNC &rest ARGS)" nil nil)

(autoload 'skk-search-tankanji "skk-tankan" "\


\(fn &optional JISYO)" nil nil)

;;;***

;;;### (autoloads nil "skk-tut" "skk-tut.el" (20540 46621 0 0))
;;; Generated autoloads from skk-tut.el

(autoload 'skk-tutorial "skk-tut" "\
Start SKK tutorial.
You can select English version by \\[universal-argument] \\[skk-tutorial].

\(fn &optional QUERY-LANGUAGE)" t nil)

;;;***

;;;### (autoloads nil "skk-vars" "skk-vars.el" (20774 5798 0 0))
;;; Generated autoloads from skk-vars.el

(put 'skk-deflocalvar 'lisp-indent-function 'defun)

(put 'skk-kutouten-type 'safe-local-variable 'symbolp)

(defvar skk-preload nil "\
*Non-nil $B$J$i$P!"(BEmacs $B5/F0;~$K(B SKK $B%W%m%0%i%`$H<-=q$NFI$_9~$_$r:Q$^$;$k!#(B
Emacs $B$N5/F0$=$N$b$N$OCY$/$J$k$,!"(BDDSKK $B$N=i2s5/F0$rAa$/$9$k$3$H$,$G$-$k!#(B")

(custom-autoload 'skk-preload "skk-vars" t)

(defvar skk-isearch-switch nil)

;;;***

;;;### (autoloads nil "skk-version" "skk-version.el" (20804 195 0
;;;;;;  0))
;;; Generated autoloads from skk-version.el

(autoload 'skk-version "skk-version" "\
Return SKK version with its codename.
If WITHOUT-CODENAME is non-nil, simply return SKK version without
the codename.

\(fn &optional WITHOUT-CODENAME)" t nil)

;;;***

;;;### (autoloads nil "skk" "skk.el" (20774 5798 0 0))
;;; Generated autoloads from skk.el

(autoload 'skk-mode "skk" "\
$BF|K\8lF~NO%b!<%I!#(B
$B%^%$%J!<%b!<%I$N0l<o$G!"%*%j%8%J%k$N%b!<%I$K$O1F6A$rM?$($J$$!#(B
$BIi$N0z?t$rM?$($k$H(B SKK $B%b!<%I$+$iH4$1$k!#(B

An input mode for Japanese, converting romanized phonetic strings to kanji.

A minor mode, it should not affect the use of any major mode or
orthogonal minor modes.

In the initial SKK mode, hiragana submode, the mode line indicator is
\"$B$+$J(B\".  Lowercase romaji inputs are automatically converted to
hiragana where possible.  The lowercase characters `q' and `l' change
submodes of SKK, and `x' is used as a prefix indicating a small kana.

`q' is used to toggle between hiragana and katakana (mode line
indicator \"$B%+%J(B\") input submodes.

`l' is used to enter ASCII submode (mode line indicator \"SKK\").
Uppercase `L' enters JISX0208 latin (wide ASCII) submode (mode line
indicator \"$BA41Q(B\").  `
' returns to hiragana submode from either
ASCII submode.

Kanji conversion is complex, but the basic principle is that the user
signals the appropriate stem to be matched against dictionary keys by
the use of uppercase letters.  Because SKK does not use grammatical
information, both the beginning and the end of the stem must be marked.

For non-inflected words (eg, nouns) consisting entirely of kanji, the
simplest way to invoke conversion is to enter the reading of the kanji,
the first character only in uppercase.  A leading \"$B"&(B\" indicates that
kanji conversion is in progress.  After entering the reading, press
space.  This invokes dictionary lookup, and the hiragana reading will be
redisplayed in kanji as the first candidate.  Pressing space again gives
the next candidate.  Further presses of space produce further candidates,
as well as a list of the next few candidates in the minibuffer.  Eg,
\"Benri\" => \"$B"&$Y$s$j(B\", and pressing space produces \"$B"'JXMx(B\" (the
solid triangle indicates that conversion is in progress).  Backspace
steps through the candidate list in reverse.

A candidate can be accepted by pressing `
', or by entering a
self-inserting character.  (Unlike other common Japanese input methods,
RET not only accepts the current candidate, but also inserts a line
break.)

Inflected words (verbs and adjectives), like non-inflected words, begin
input with a capital letter.  However, for these words the end of the
kanji string is signaled by capitalizing the next mora.  Eg, \"TuyoI\"
=> \"$B"'6/$$(B\".  If no candidate is available at that point, the inflection
point will be indicated with an asterisk \"*\", and trailing characters
will be displayed until a candidate is recognized.  It will be
immediately displayed (pressing space is not necessary).  Space and
backspace are used to step forward and backward through the list of
candidates.

For more information, see the `skk' topic in Info.  (Japanese only.)

A tutorial is available in Japanese or English via \\[skk-tutorial].
Use a prefix argument to choose the language.  The default is system-
dependent.

\(fn &optional ARG)" t nil)

(autoload 'skk-auto-fill-mode "skk" "\
$BF|K\8lF~NO%b!<%I!#<+F0@^$jJV$75!G=IU$-!#(B
$B%^%$%J!<%b!<%I$N0l<o$G!"%*%j%8%J%k$N%b!<%I$K$O1F6A$rM?$($J$$!#(B
$B@5$N0z?t$rM?$($k$H!"6/@)E*$K(B `auto-fill-mode' $B5Z$S(B SKK $B%b!<%I$KF~$k!#(B
$BIi$N0z?t$rM?$($k$H(B `auto-fill-mode' $B5Z$S(B SKK $B%b!<%I$+$iH4$1$k!#(B

\(fn &optional ARG)" t nil)

(autoload 'skk-compile-rule-list "skk" "\
rule list $B$rLZ$N7A$K%3%s%Q%$%k$9$k!#(B

\(fn &rest RULE-LISTS)" nil nil)

(autoload 'skk-henkan-on-message "skk" "\


\(fn)" nil nil)

(autoload 'skk-remove-duplicates "skk" "\
LIST $B$+$i!"=EJ#$9$kMWAG$r=|30$7$?%j%9%H$rJV$9!#(B

\(fn LIST)" nil nil)

(autoload 'skk-preload "skk" "\
Emacs $B5/F0;~$K$"$i$+$8$a(B SKK $B$r8F$V$3$H$G(B SKK $B$N1~Ez$rB.$/$9$k!#(B
$B@hFI$_$NBP>]$K$J$k$N$O0J2<!#(B
1. skk.el $B$H4XO"$9$k$$$/$D$+$N%U%!%$%k(B ($B=i2s5/F0;~$NCY1d$r4KOB(B)
2. $B6&M-<-=q72(B ($B=iJQ49;~$NCY1d$r4KOB(B)
$BJQ?t(B `skk-preload' $B$,(B non-nil $B$N$H$-(B `after-init-hook' $B$+$i8F$P$l$k!#(B
$B$=$N$?$a(B Emacs $B$N5/F0;~4V$,D9$/$J$kE@$K$OCm0U$rMW$9$k!#(B

\(fn)" nil nil)

(add-hook 'after-init-hook (lambda nil (when (and (symbol-value 'init-file-user) skk-preload) (skk-preload))) t)

;;;***

;;;### (autoloads nil "skk-study" "skk-study.el" (20722 33356 0 0))
;;; Generated autoloads from skk-study.el

(autoload 'skk-study-search "skk-study" "\
$B3X=,%G!<%?$r;2>H$7$F(B ENTRY $B$r2C9)$7!"4XO"@-$N$"$k8l$NM%@h=g0L$r>e$2$FJV$9!#(B

\(fn HENKAN-BUFFER MIDASI OKURIGANA ENTRY)" nil nil)

(autoload 'skk-study-update "skk-study" "\
MIDASI $B$H(B WORD $B$K$D$$$F(B `skk-study-data-ring' $B$N:G=i$N4XO"8l$r4XO"IU$1$F3X=,$9$k!#(B

\(fn HENKAN-BUFFER MIDASI OKURIGANA WORD PURGE)" nil nil)

(autoload 'skk-study-save "skk-study" "\
$B3X=,7k2L$r(B `skk-study-file' $B$XJ]B8$9$k!#(B
$B%*%W%7%g%J%k0z?t$N(B NOMSG $B$,(B non-nil $B$G$"$l$P!"J]B8%a%C%;!<%8$rI=<($7$J$$!#(B

\(fn &optional NOMSG)" t nil)

(autoload 'skk-study-switch-current-theme "skk-study" "\
$B%+%l%s%H%P%C%U%!$KBP$7$F(B skk-study $B$N3X=,%F!<%^(B THEME $B$r@_Dj$9$k!#(B
$B3X=,%F!<%^L>(B THEME $B$K$OG$0U$NJ8;zNs$r;XDj$G$-$k!#(B
$B%+%l%s%H%P%C%U%!$K3X=,%F!<%^$,@_Dj$5$l$J$$$H$-$O!"3X=,%F!<%^(B
\"general\" $B$KBP$7$F3X=,$,9T$o$l$k!#(B

\(fn THEME)" t nil)

(autoload 'skk-study-remove-theme "skk-study" "\
skk-study $B$N3X=,%F!<%^(B THEME $B$r:o=|$9$k!#(B

\(fn THEME)" t nil)

(autoload 'skk-study-copy-theme "skk-study" "\
skk-study $B$N3X=,%F!<%^(B FROM $B$r(B TO $B$K%3%T!<$9$k!#(B
TO $B$N4{B8%G!<%?$OGK2u$5$l$k!#(B

\(fn FROM TO)" t nil)

(autoload 'skk-study-read "skk-study" "\
`skk-study-file' $B$+$i3X=,7k2L$rFI$_9~$`!#(B
$B%*%W%7%g%J%k0z?t$N(B FORCE $B$,(B non-nil $B$G$"$l$P!"GK4~$N3NG'$r$7$J$$!#(B

\(fn &optional NOMSG FORCE)" t nil)

;;;***
(provide 'skk-autoloads)
;;; skk-autoloads.el ends here
