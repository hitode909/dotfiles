;;; skk-autoloads.el --- autoload settings for SKK.

;; This file was generated automatically by SKK-MK at Fri May 29 16:26:03 2009.

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


;;;### (autoloads (skk-cursor-off-1 skk-cursor-set-1 skk-cursor-current-color)
;;;;;;  "skk-cursor" "skk-cursor.el" (18266 42923))
;;; Generated autoloads from skk-cursor.el

(autoload (quote skk-cursor-current-color) "skk-cursor" "\
Not documented

\(fn)" nil nil)

(autoload (quote skk-cursor-set-1) "skk-cursor" "\
Not documented

\(fn COLOR)" nil nil)

(autoload (quote skk-cursor-off-1) "skk-cursor" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (skk-viper-normalize-map) "skk-viper" "skk-viper.el"
;;;;;;  (18200 50108))
;;; Generated autoloads from skk-viper.el

(autoload (quote skk-viper-normalize-map) "skk-viper" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (skk-e21-prepare-modeline-properties skk-e21-prepare-menu)
;;;;;;  "skk-e21" "skk-e21.el" (18451 54887))
;;; Generated autoloads from skk-e21.el

(autoload (quote skk-e21-prepare-menu) "skk-e21" "\
Not documented

\(fn)" nil nil)

(autoload (quote skk-e21-prepare-modeline-properties) "skk-e21" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (update-buffer-local-frame-params ccc-setup) "ccc"
;;;;;;  "ccc.el" (18321 16082))
;;; Generated autoloads from ccc.el

(autoload (quote ccc-setup) "ccc" "\
Not documented

\(fn)" nil nil)

(autoload (quote update-buffer-local-frame-params) "ccc" "\
Not documented

\(fn &optional BUFFER)" nil nil)

(add-hook (quote after-init-hook) (lambda nil (when window-system (ccc-setup))))

;;;***

;;;### (autoloads (context-skk-programming-mode context-skk-custumize-functions
;;;;;;  context-skk-context-check-hook context-skk) "context-skk"
;;;;;;  "context-skk.el" (18140 29057))
;;; Generated autoloads from context-skk.el

(let ((loads (get (quote context-skk) (quote custom-loads)))) (if (member (quote "context-skk") loads) nil (put (quote context-skk) (quote custom-loads) (cons (quote "context-skk") loads))))

(defvar context-skk-context-check-hook (quote (context-skk-out-of-string-or-comment-in-programming-mode-p context-skk-on-keymap-defined-area-p context-skk-in-read-only-p)) "\
*$BF|K\8lF~NO$r<+F0E*$K(Boff$B$K$7$?$$!V%3%s%F%-%9%H!W$K$$$l$P(Bt$B$rJV$94X?t$rEPO?$9$k!#(B")

(custom-autoload (quote context-skk-context-check-hook) "context-skk" t)

(defvar context-skk-custumize-functions (quote (context-skk-customize-kutouten)) "\
*skk$B$K$h$kF~NO3+;OD>A0$K!"F~NO$N%+%9%?%^%$%:$r9T$&$?$a$N4X?t$rEPO?$9$k!#(B
$B4X?t$O0J2<$N7A<0$N%G!<%?$rMWAG$H$9$k%j%9%H$rJV$9$b$N$H$9$k(B: 

  (VARIABLE VALUE)

`skk-insert'$B$r$+$3$`(B`let'$B$K$h$C$F(BVARIABLE$B$O(BVALUE$B$KB+G{$5$l$k!#(B
$BFC$K$=$N>l$G%+%9%?%^%$%:$9$Y$-JQ?t$,$J$$>l9g(B `nil'$B$rJV$;$PNI$$!#(B
$B4X?t$K$O2?$b0z?t$,EO$5$l$J$$!#(B")

(custom-autoload (quote context-skk-custumize-functions) "context-skk" t)

(defvar context-skk-programming-mode (quote (ada-mode antlr-mode asm-mode autoconf-mode awk-mode c-mode objc-mode java-mode idl-mode pike-mode cperl-mode delphi-mode f90-mode fortran-mode icon-mode idlwave-mode inferior-lisp-mode lisp-mode m4-mode makefile-mode metafont-mode modula-2-mode octave-mode pascal-mode perl-mode prolog-mode ps-mode postscript-mode ruby-mode scheme-mode sh-mode simula-mode tcl-mode vhdl-mode emacs-lisp-mode)) "\
*context-skk$B$K$F!V%W%m%0%i%_%s%0%b!<%I!W$H$_$J$9%b!<%I$N%j%9%H(B")

(custom-autoload (quote context-skk-programming-mode) "context-skk" t)
 (autoload 'context-skk-mode "context-skk" "$BJ8L.$K1~$8$F<+F0E*$K(Bskk$B$NF~NO%b!<%I$r(Blatin$B$K@Z$j49$($k%^%$%J!<%b!<%I!#(B" t)

;;;***

;;;### (autoloads (skk-abbrev-search) "skk-abbrev" "skk-abbrev.el"
;;;;;;  (18155 8647))
;;; Generated autoloads from skk-abbrev.el

(autoload (quote skk-abbrev-search) "skk-abbrev" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (skk-annotation-wikipedia-region skk-annotation-wikipedia-cache
;;;;;;  skk-annotation-treat-wikipedia skk-annotation-wikipedia skk-annotation-quote
;;;;;;  skk-annotation-toggle-display-p skk-annotation-display-p
;;;;;;  skk-annotation-remove skk-annotation-add skk-annotation-message
;;;;;;  skk-annotation-show skk-annotation-find-and-show skk-annotation-get)
;;;;;;  "skk-annotation" "skk-annotation.el" (18644 42543))
;;; Generated autoloads from skk-annotation.el

(autoload (quote skk-annotation-get) "skk-annotation" "\
Not documented

\(fn ANNOTATION)" nil nil)

(autoload (quote skk-annotation-find-and-show) "skk-annotation" "\
Not documented

\(fn PAIR)" nil nil)

(autoload (quote skk-annotation-show) "skk-annotation" "\
Not documented

\(fn ANNOTATION &optional WORD SOURCES)" nil nil)

(autoload (quote skk-annotation-message) "skk-annotation" "\
Not documented

\(fn &optional SITUATION)" nil nil)

(autoload (quote skk-annotation-add) "skk-annotation" "\
$B:G8e$K3NDj$7$?8l$K(B annotation $B$rIU$1$k!#(B
$B4{$KIU$1$i$l$F$$$k(B annotation $B$,$"$l$P$=$l$rJT=8%P%C%U%!$K=PNO$9$k!#(B
no-previous-annotation $B$r;XDj$9$k$H(B (C-u M-x skk-annotation-add $B$G;XDj2D(B)
$B4{$KIU$1$i$l$F$$$k(B annotation $B$rJT=8%P%C%U%!$K=PNO$7$J$$!#(B

\(fn &optional NO-PREVIOUS-ANNOTATION)" t nil)

(autoload (quote skk-annotation-remove) "skk-annotation" "\
$B:G8e$K3NDj$7$?8l$+$i(B annotation $B$r<h$j5n$k!#(B

\(fn)" t nil)

(autoload (quote skk-annotation-display-p) "skk-annotation" "\
Not documented

\(fn TEST)" nil nil)

(autoload (quote skk-annotation-toggle-display-p) "skk-annotation" "\
Not documented

\(fn)" t nil)

(autoload (quote skk-annotation-quote) "skk-annotation" "\
$B:G8e$K3NDj$7$?8l$K4^$^$l$k(B `;' $B$r8uJd$N0lIt$H$7$F(B quote $B$9$k!#(B

\(fn &optional QUIET)" t nil)

(autoload (quote skk-annotation-wikipedia) "skk-annotation" "\
Wiktionary/Wikipedia $B$N(B WORD $B$KAjEv$9$k5-;v$+$i%"%N%F!<%7%g%s$r<hF@$9$k!#(B

\(fn WORD &optional SOURCES)" nil nil)

(autoload (quote skk-annotation-treat-wikipedia) "skk-annotation" "\
WORD $B$,A^F~$5$l$k$H$-$KI=<($5$l$k$Y$-Cm<a$r@8@.$9$k!#(B
$B@8@.$7$?Cm<a$rJV$9!#(B

\(fn WORD &optional SOURCES)" nil nil)

(autoload (quote skk-annotation-wikipedia-cache) "skk-annotation" "\
Not documented

\(fn WORD &optional SOURCES)" nil nil)

(autoload (quote skk-annotation-wikipedia-region) "skk-annotation" "\
Not documented

\(fn &optional PREFIX-ARG START END)" t nil)

;;;***

;;;### (autoloads (skk-adjust-search-prog-list-for-auto-okuri skk-okuri-search-1)
;;;;;;  "skk-auto" "skk-auto.el" (17962 51878))
;;; Generated autoloads from skk-auto.el

(autoload (quote skk-okuri-search-1) "skk-auto" "\
Not documented

\(fn)" nil nil)

(autoload (quote skk-adjust-search-prog-list-for-auto-okuri) "skk-auto" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (skk-completion-search skk-search-lisp-symbol skk-comp-lisp-symbol
;;;;;;  skk-search-smart-find skk-comp-smart-find skk-comp-by-history
;;;;;;  skk-comp-previous/next skk-comp-previous skk-comp-search-current-buffer
;;;;;;  skk-comp-from-jisyo skk-comp-get-all-candidates skk-comp-do
;;;;;;  skk-comp skk-comp-start-henkan) "skk-comp" "skk-comp.el"
;;;;;;  (18424 4796))
;;; Generated autoloads from skk-comp.el

(autoload (quote skk-comp-start-henkan) "skk-comp" "\
$B"&%b!<%I$GFI$_$NJd40$r9T$J$C$?8e!"JQ49$9$k!#(B
$B$=$l0J30$N%b!<%I$G$O%*%j%8%J%k$N%-!<%^%C%W$K3d$jIU$1$i$l$?%3%^%s%I$r%(%_%e%l!<(B
$B%H$9$k!#(B

\(fn ARG)" t nil)

(autoload (quote skk-comp) "skk-comp" "\
Not documented

\(fn FIRST &optional SILENT)" nil nil)

(autoload (quote skk-comp-do) "skk-comp" "\
Not documented

\(fn FIRST &optional SILENT)" nil nil)

(autoload (quote skk-comp-get-all-candidates) "skk-comp" "\
Not documented

\(fn KEY PREFIX PROG-LIST)" nil nil)

(autoload (quote skk-comp-from-jisyo) "skk-comp" "\
SKK $B<-=q%U%)!<%^%C%H$N(B FILE $B$+$iJd408uJd$rF@$k!#(B

\(fn FILE)" nil nil)

(autoload (quote skk-comp-search-current-buffer) "skk-comp" "\
Not documented

\(fn KEY &optional ABBREV)" nil nil)

(autoload (quote skk-comp-previous) "skk-comp" "\
Not documented

\(fn)" nil nil)

(autoload (quote skk-comp-previous/next) "skk-comp" "\
Not documented

\(fn CH)" nil nil)

(autoload (quote skk-comp-by-history) "skk-comp" "\
$BF~NO$,6u$N;~$KMzNr$+$iJd40$9$k!#(B
$BBP>]$O8=:_$N(B Emacs $B$N%;%C%7%g%s$K$*$$$F9T$J$C$?Aw$jL5$7JQ49$N$&$A!"(B
`skk-kakutei-history-limit' $B$G;XDj$5$l$k:G6a$N$b$N$G$"$k!#(B

\(fn)" nil nil)

(autoload (quote skk-comp-smart-find) "skk-comp" "\
`smart-find' $B$,8+$D$1$?%U%!%$%kL>$GJd40$9$k(B

\(fn &optional PATH)" nil nil)

(autoload (quote skk-search-smart-find) "skk-comp" "\
`smart-find'$B$rMxMQ$7$?JQ49$r9T$J$&!#(B
SKK abbrev $B%b!<%I$K$F!"1QJ8;z(B + skk-completion-search-char (~)$B$G(B
$BL$40%9%Z%k$r;XDj$7$FJQ49$9$k$H!"Jd408uJd$,JQ498uJd$H$7$F=P8=$9$k!#(B
$B%G%U%)%k%H$G$O(B SKK abbrev $B%b!<%I$N$_$GM-8z$J5!G=$@$,!"(B
NOT-ABBREV-ONLY $B$r;XDj$9$k;v$G>o$KM-8z$H$J$k!#(B

\(fn &optional PATH NOT-ABBREV-ONLY WITHOUT-CHAR-MAYBE)" nil nil)

(autoload (quote skk-comp-lisp-symbol) "skk-comp" "\
Lisp symbol $BL>$GJd40$9$k!#(B
PREDICATE $B$K0z?t(B 1 $B8D$N4X?t$r;XDj$9$l$P!"(BPREDICATE $B$rK~$?$9%7%s%\%k(B
$B$K8B$C$FJd40$9$k!#(BPREDICATE $B$K$O(B `fboundp', `boundpp', `commandp'
$B$J$I$,;XDj$G$-$k!#;XDj$7$J$1$l$P4X?t$^$?$OJQ?t$K8B$C$FJd40$9$k!#(B

\(fn &optional PREDICATE)" nil nil)

(autoload (quote skk-search-lisp-symbol) "skk-comp" "\
Lisp symbol $BL>$GJd40$7$?7k2L$r8!:w7k2L$H$7$FJV$9!#(B
PREDICATE $B$K0z?t(B 1 $B8D$N4X?t$r;XDj$9$l$P!"(BPREDICATE $B$rK~$?$9%7%s%\%k(B
$B$K8B$C$FJd40$9$k!#(BPREDICATE $B$K$O(B `fboundp', `boundpp', `commandp'
$B$J$I$,;XDj$G$-$k!#;XDj$7$J$1$l$P4X?t$^$?$OJQ?t$K8B$C$FJd40$9$k!#(B
SKK abbrev $B%b!<%I$K$F!"1QJ8;z(B + skk-completion-search-char (~)$B$G(B
$BL$40%9%Z%k$r;XDj$7$FJQ49$9$k$H!"Jd408uJd$,JQ498uJd$H$7$F=P8=$9$k!#(B
$B%G%U%)%k%H$G$O(B SKK abbrev $B%b!<%I$N$_$GM-8z$J5!G=$@$,!"(B
NOT-ABBREV-ONLY $B$r;XDj$9$k;v$G>o$KM-8z$H$J$k!#(B

\(fn &optional PREDICATE NOT-ABBREV-ONLY WITHOUT-CHAR-MAYBE)" nil nil)

(autoload (quote skk-completion-search) "skk-comp" "\
$BJQ49%-!<$GJd40$r9T$$!"F@$i$l$?3F8+=P$7$G$5$i$K8!:w$9$k!#(B
COMP-PROG-LIST $B$O(B `skk-completion-prog-list' $B$HF1$87A<0$G!"(B
$B$3$l$K4^$^$l$kJd404X?t$K$h$C$F!"$^$:JQ49%-!<$+$i8+=P$7$N%j%9%H$rF@$k!#(B
SEARCH-PROG-LIST $B$O(B `skk-search-prog-list' $B$HF1$87A<0$G!"(B
$BJd404X?t$K$h$C$FF@$?8+=P$7$r$3$l$K4^$^$l$k8!:w4X?t$K$h$jJQ498uJd$rF@$k!#(B
$B%G%U%)%k%H$G$O!"Jd40$K$h$C$FF@$i$l$?8+=P$7$HBP1~$9$k8uJd$O%;%C%H$G$"$k$,!"(B
WITHOUT-MIDASI $B$r;XDj$9$k$H8+=P$7$O>J$+$l$k!#(B

\(fn COMP-PROG-LIST &optional SEARCH-PROG-LIST WITHOUT-MIDASI WITHOUT-CHAR-MAYBE)" nil nil)

;;;***

;;;### (autoloads (skk-cus-setup skk-customize skk-customize-group-skk)
;;;;;;  "skk-cus" "skk-cus.el" (18266 42923))
;;; Generated autoloads from skk-cus.el

(autoload (quote skk-customize-group-skk) "skk-cus" "\
Not documented

\(fn)" t nil)

(autoload (quote skk-customize) "skk-cus" "\
Not documented

\(fn)" t nil)

(autoload (quote skk-cus-setup) "skk-cus" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (skk-dcomp-after-delete-backward-char skk-dcomp-before-kakutei
;;;;;;  skk-dcomp-marked-p) "skk-dcomp" "skk-dcomp.el" (18793 14012))
;;; Generated autoloads from skk-dcomp.el

(autoload (quote skk-dcomp-marked-p) "skk-dcomp" "\
Not documented

\(fn)" nil nil)

(autoload (quote skk-dcomp-before-kakutei) "skk-dcomp" "\
Not documented

\(fn)" nil nil)

(autoload (quote skk-dcomp-after-delete-backward-char) "skk-dcomp" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (skk-submit-bug-report) "skk-develop" "skk-develop.el"
;;;;;;  (17962 51878))
;;; Generated autoloads from skk-develop.el

(autoload (quote skk-submit-bug-report) "skk-develop" "\
SKK $B$N%P%0%l%]!<%H$r=q$/%a!<%k%P%C%U%!$rMQ0U$9$k!#(B
mail-user-agent $B$r@_Dj$9$k$3$H$K$h$j9%$_$N%a!<%k%$%s%?!<%U%'%$%9$r;HMQ$9$k$3$H(B
$B$,$G$-$k!#Nc$($P!"(BWanderlust $B$r;HMQ$7$?$$>l9g$O2<5-$N$h$&$K@_Dj$9$k!#(B

    (setq mail-user-agent 'wl-user-agent) 

\(fn)" t nil)

(add-hook (quote before-init-hook) (function (lambda nil (eval-after-load "font-lock" (quote (setq lisp-font-lock-keywords-2 (nconc (list (list (concat "(\\(\\(skk-\\)?def\\(" "\\(un-cond\\|subst-cond\\|advice\\|" "macro-maybe\\|alias-maybe\\|un-maybe\\)\\|" "\\(var\\|localvar\\)" "\\)\\)\\>" "[ 	'(]*" "\\(\\sw+\\)?") (quote (1 font-lock-keyword-face)) (quote (6 (cond ((match-beginning 4) font-lock-function-name-face) ((match-beginning 5) font-lock-variable-name-face)) nil t)))) (list (list (concat "(" (regexp-opt (quote ("skk-save-point" "skk-with-point-move" "skk-loop-for-buffers" "static-if" "static-when" "static-unless" "static-cond")) t) "\\>") (quote (1 font-lock-keyword-face)))) (list (list "(\\(skk-error\\)\\>" (quote (1 font-lock-warning-face)))) lisp-font-lock-keywords-2)))) (put (quote skk-deflocalvar) (quote doc-string-elt) 3) (put (quote skk-defadvice) (quote doc-string-elt) 3) (put (quote defun-maybe) (quote doc-string-elt) 3) (put (quote defmacro-maybe) (quote doc-string-elt) 3) (put (quote defalias-maybe) (quote doc-string-elt) 3))))

;;;***

;;;### (autoloads (skk-dic-setup-buffer skk-search-small-dic) "skk-dic"
;;;;;;  "skk-dic.el" (17962 51878))
;;; Generated autoloads from skk-dic.el

(autoload (quote skk-search-small-dic) "skk-dic" "\
`skk-henkan-key' $B$K$D$$$F(B `skk-dic-buffer' $B$r8!:w$7!"8uJd$N%j%9%H$rJV$9!#(B
`skk-search-prog-list' $B$NMWAG$K(B `(skk-search-small-dic)' $B$r;XDj$7$FMxMQ$9$k!#(B
SKK $B%$%s%9%H!<%k;~$K%$%s%9%H!<%i$,(B SKK-JISYO.S $B$r8+$D$1$?$i!"(Bskk-dic.el
$B%m!<%I;~$K(B `skk-dic-buffer' $B$O<+F0E*$K@_Dj$5$l$k!#(B

\(fn)" nil nil)

(autoload (quote skk-dic-setup-buffer) "skk-dic" "\
Not documented

\(fn &optional ARG)" nil nil)

;;;***

;;;### (autoloads (skk-gadget-units-conversion skk-henkan-face-off-and-remove-itself
;;;;;;  skk-ignore-dic-word skk-times skk-minus skk-plus skk-calc
;;;;;;  skk-gengo-to-ad-1 skk-gengo-to-ad skk-ad-to-gengo-1 skk-ad-to-gengo
;;;;;;  skk-clock skk-today skk-default-current-date skk-current-date)
;;;;;;  "skk-gadget" "skk-gadget.el" (17962 51878))
;;; Generated autoloads from skk-gadget.el

(autoload (quote skk-current-date) "skk-gadget" "\
`current-time-string' $B$N=PNO$r2C9)$7!"8=:_$NF|;~(B (string)$B$rJV$9!#(B
$B%*%W%7%g%J%k0z?t$N(B PP-FUNCTION $B$r;XDj$9$k$H!"(B`skk-current-date-1'
$B$NJV$jCM!"(BFORMAT $B$H(B AND-TIME $B$r0z?t$K$7$F(B `funcall' $B$9$k!#(B
PP-FUNCTION $B$N;XDj$,$J$$>l9g$O(B `skk-default-current-date-function' $B$r(B
`funcall' $B$9$k!#(B
FORMAT $B$O(B `format' $B$NBh0l0z?t$NMM<0(B (string)$B$K$h$k=PNO;XDj%F%s%W%l!<%H!#(B
AND-TIME (boolean) $B$r;XDj$9$k$H;~9o$bJV$9!#(B
`skk-today' $B$H(B `skk-clock' $B$N%5%V%k!<%A%s!#(B

\(fn &optional PP-FUNCTION FORMAT AND-TIME)" nil nil)

(autoload (quote skk-default-current-date) "skk-gadget" "\
$BF|IU>pJs$NI8=`E*$J=PNO$r$9$kB>!"%f!<%6$K$"$kDxEY$N%+%9%?%^%$%:5!G=$rDs6!$9$k!#(B
$B$3$N4X?t$N0z?t$G%+%9%?%^%$%:$G$-$J$$=PNO$r4uK>$9$k>l9g$O!"(B
`skk-default-current-date-function' $B$K<+A0$N4X?t$r;XDj$9$k!#(B

DATE-INFORMATION $B$O(B `current-time-string' $B$,JV$7$?J8;zNs$r(B

  (year month day day-of-week hour minute second)

$B$N7A<0$GJQ49$7$?%j%9%H(B ($B3FMWAG$OJ8;zNs(B)$B!#(B
FORMAT $B$O(B `format' $B$NBh0l0z?t$NMM<0$K$h$k=PNO7ABV$r;XDj$9$kJ8;zNs!#(B
  nil $B$G$"$l$P(B \"%s$BG/(B%s$B7n(B%s$BF|(B(%s)%s$B;~(B%s$BJ,(B%s$BIC(B\" ($B$b$7$/$O(B
  \"%s$BG/(B%s$B7n(B%s$BF|(B(%s)\" $B$,;H$o$l$k!#(B
NUM-TYPE (number) $B$O(B
  0 -> $BL5JQ49(B,
  1 -> $BA43Q?t;z$XJQ49(B,
  2 -> $B4A?t;z$XJQ49(B ($B0L<h$j$J$7(B),
  3 -> $B4A?t;z$XJQ49(B ($B0L<h$j$r$9$k(B),
  4 -> $B$=$N?t;z$=$N$b$N$r%-!<$K$7$F<-=q$r:F8!:w(B,
  5 -> $B4A?t;z(B ($B<j7A$J$I$G;HMQ$9$kJ8;z$r;HMQ(B)$B$XJQ49(B ($B0L<h$j$r$9$k(B),
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

(autoload (quote skk-today) "skk-gadget" "\
`current-time-string' $B$N=PNO$r2C9)$7!"8=:_$NF|;~$rI=$9J8;zNs$r:n$j!"A^F~$9$k!#(B
$B<B<AE*$K(B today $B%(%s%H%j$N8F=P$7$J$N$G!"8D?M<-=q$N(B today $B%(%s%H%j$K$h$j%+%9%?%^(B
$B%$%:$9$k$3$H$,$G$-$k!#(B

\(fn ARG)" t nil)

(autoload (quote skk-clock) "skk-gadget" "\
$B%G%8%?%k;~7W$r%_%K%P%C%U%!$KI=<($9$k!#(B
quit $B$9$k$H$=$N;~E@$NF|;~$r8uJd$H$7$FA^F~$9$k!#(B
quit $B$7$?$H$-$K5/F0$7$F$+$i$N7P2a;~4V$r%_%K%P%C%U%!$KI=<($9$k!#(B
interactive $B$K5/F0$9$kB>!"(B\"clock /(skk-clock)/\" $B$J$I$N%(%s%H%j$r(B SKK $B$N<-=q(B
$B$K2C$(!"(B\"/clock\"+ SPC $B$GJQ49$9$k$3$H$K$h$C$F$b5/F02D!#(BC-g $B$G;_$^$k!#(B
$B<B9TJQ49$G5/F0$7$?>l9g$O!"(BC-g $B$7$?;~E@$N;~E@$NF|;~$rA^F~$9$k!#(B
$B%*%W%7%g%J%k0z?t$N(B KAKUTEI-WHEN-QUIT $B$,(B non-nil $B$G$"$l$P(B C-g $B$7$?$H$-$K3N(B
$BDj$9$k!#(B
$B%*%W%7%g%J%k0z?t$N(B TIME-SIGNAL $B$,(B non-nil $B$G$"$l$P!"(BNTT $B$N;~JsIw$K(B ding $B$9$k!#(B
$B$=$l$>$l(B \"clock /(skk-clock nil t)/\" $B$N$h$&$J%(%s%H%j$r<-=q$KA^F~$9$l$PNI$$!#(B
skk-date-ad $B$H(B skk-number-style $B$K$h$C$FI=<(J}K!$N%+%9%?%^%$%:$,2DG=!#(B

\(fn &optional KAKUTEI-WHEN-QUIT TIME-SIGNAL)" t nil)

(autoload (quote skk-ad-to-gengo) "skk-gadget" "\
Not documented

\(fn GENGO-INDEX &optional DIVIDER TAIL NOT-GANNEN)" nil nil)

(autoload (quote skk-ad-to-gengo-1) "skk-gadget" "\
Not documented

\(fn AD &optional NOT-GANNEN)" nil nil)

(autoload (quote skk-gengo-to-ad) "skk-gadget" "\
Not documented

\(fn &optional HEAD TAIL)" nil nil)

(autoload (quote skk-gengo-to-ad-1) "skk-gadget" "\
Not documented

\(fn GENGO NUMBER)" nil nil)

(autoload (quote skk-calc) "skk-gadget" "\
Not documented

\(fn OPERATOR)" nil nil)

(autoload (quote skk-plus) "skk-gadget" "\
Not documented

\(fn)" nil nil)

(autoload (quote skk-minus) "skk-gadget" "\
Not documented

\(fn)" nil nil)

(autoload (quote skk-times) "skk-gadget" "\
Not documented

\(fn)" nil nil)

(autoload (quote skk-ignore-dic-word) "skk-gadget" "\
Not documented

\(fn &rest NO-SHOW-LIST)" nil nil)

(autoload (quote skk-henkan-face-off-and-remove-itself) "skk-gadget" "\
Not documented

\(fn)" nil nil)

(autoload (quote skk-gadget-units-conversion) "skk-gadget" "\
`skk-units-alist'$B$r;2>H$7!"49;;$r9T$J$&!#(B
NUMBER $B$K$D$$$F(B UNIT-FROM $B$+$i(B UNIT-TO $B$X$N49;;$r9T$J$&!#(B

\(fn UNIT-FROM NUMBER UNIT-TO)" nil nil)

;;;***

;;;### (autoloads (skk-isearch-skk-mode skk-isearch-mode-cleanup
;;;;;;  skk-isearch-mode-setup skk-isearch-message) "skk-isearch"
;;;;;;  "skk-isearch.el" (18129 48844))
;;; Generated autoloads from skk-isearch.el

(autoload (quote skk-isearch-message) "skk-isearch" "\
Show isearch message.

\(fn)" nil nil)

(autoload (quote skk-isearch-mode-setup) "skk-isearch" "\
hook function called when skk isearch begin.

\(fn)" nil nil)

(autoload (quote skk-isearch-mode-cleanup) "skk-isearch" "\
Hook function called when skk isearch is done.

\(fn)" nil nil)

(autoload (quote skk-isearch-skk-mode) "skk-isearch" "\
Not documented

\(fn &rest ARGS)" t nil)

(defconst skk-isearch-really-early-advice (function (lambda nil (defadvice isearch-message-prefix (around skk-isearch-ad activate) (let ((current-input-method (unless (and (boundp (quote skk-isearch-switch)) skk-isearch-switch) current-input-method))) ad-do-it)) (defadvice isearch-toggle-input-method (around skk-isearch-ad activate) (cond ((string-match "^japanese-skk" (format "%s" default-input-method)) (let ((skk-isearch-initial-mode-when-skk-mode-disabled (quote latin))) (skk-isearch-mode-setup) (skk-isearch-skk-mode))) ((null default-input-method) ad-do-it (when (string-match "^japanese-skk" (format "%s" default-input-method)) (let ((skk-isearch-initial-mode-when-skk-mode-disabled (quote latin))) (skk-isearch-mode-setup)) (inactivate-input-method))) (t ad-do-it))))))

(unless (featurep (quote xemacs)) (define-key isearch-mode-map [(control \\)] (quote isearch-toggle-input-method)) (cond ((and (featurep (quote advice)) (assq (quote skk-isearch-ad) (assq (quote around) (ad-get-advice-info (quote isearch-toggle-input-method))))) nil) ((locate-library "advice") (funcall skk-isearch-really-early-advice)) (t (add-hook (quote before-init-hook) skk-isearch-really-early-advice))))

;;;***

;;;### (autoloads (skk-katakana-to-jisx0201-region skk-hiragana-to-jisx0201-region
;;;;;;  skk-toggle-katakana skk-jisx0201-mode) "skk-jisx0201" "skk-jisx0201.el"
;;;;;;  (17962 51878))
;;; Generated autoloads from skk-jisx0201.el

(autoload (quote skk-jisx0201-mode) "skk-jisx0201" "\
SKK $B$N%b!<%I$r(B JIS X 0201 $B%b!<%I$KJQ99$9$k!#(B

\(fn ARG)" t nil)

(autoload (quote skk-toggle-katakana) "skk-jisx0201" "\
Not documented

\(fn ARG)" t nil)

(autoload (quote skk-hiragana-to-jisx0201-region) "skk-jisx0201" "\
Not documented

\(fn START END)" nil nil)

(autoload (quote skk-katakana-to-jisx0201-region) "skk-jisx0201" "\
Not documented

\(fn START END)" nil nil)

;;;***

;;;### (autoloads (skk-edit-private-jisyo skk-jisyo-edit-mode) "skk-jisyo-edit-mode"
;;;;;;  "skk-jisyo-edit-mode.el" (17962 51878))
;;; Generated autoloads from skk-jisyo-edit-mode.el

(autoload (quote skk-jisyo-edit-mode) "skk-jisyo-edit-mode" "\
Major mode for editing SKK JISYO.

\(fn)" t nil)

(add-to-list (quote auto-mode-alist) (quote ("SKK-JISYO" . skk-jisyo-edit-mode)))

(add-to-list (quote auto-mode-alist) (quote ("\\.skk-jisyo\\(\\.BAK\\|\\.bak\\|~\\)?$" . skk-jisyo-edit-mode)))

(add-to-list (quote auto-mode-alist) (quote ("\\..*skk/jisyo\\(\\.BAK\\|\\.bak\\|~\\)?$" . skk-jisyo-edit-mode)))

(autoload (quote skk-edit-private-jisyo) "skk-jisyo-edit-mode" "\
Not documented

\(fn &optional CODING-SYSTEM)" t nil)

;;;***

;;;### (autoloads (skk-romaji-message skk-romaji-region skk-hurigana-katakana-message
;;;;;;  skk-hurigana-katakana-region skk-hurigana-message skk-hurigana-region
;;;;;;  skk-gyakubiki-katakana-message skk-gyakubiki-katakana-region
;;;;;;  skk-gyakubiki-message skk-gyakubiki-region) "skk-kakasi"
;;;;;;  "skk-kakasi.el" (18434 6255))
;;; Generated autoloads from skk-kakasi.el

(autoload (quote skk-gyakubiki-region) "skk-kakasi" "\
$BNN0h$N4A;z!"Aw$j2>L>$rA4$F$R$i$,$J$KJQ49$9$k!#(B
$B%*%W%7%g%J%k0z?t$N(B ALL $B$,(B non-nil $B$J$i$P!"J#?t$N8uJd$,$"$k>l9g$O!"(B\"{}\" $B$G$/(B
$B$/$C$FI=<($9$k!#(B
$BNc$($P!"(B
    $BCfEg(B -> {$B$J$+$7$^(B|$B$J$+$8$^(B}

\(fn START END &optional ALL)" t nil)

(autoload (quote skk-gyakubiki-message) "skk-kakasi" "\
$BNN0h$N4A;z!"Aw$j2>L>$rA4$F$R$i$,$J$KJQ498e!"%(%3!<$9$k!#(B
$B%*%W%7%g%J%k0z?t$N(B ALL $B$,(B non-nil $B$J$i$P!"J#?t$N8uJd$,$"$k>l9g$O!"(B\"{}\" $B$G$/(B
$B$/$C$FI=<($9$k!#(B
$BNc$($P!"(B
    $BCfEg(B -> {$B$J$+$7$^(B|$B$J$+$8$^(B}

\(fn START END &optional ALL)" t nil)

(autoload (quote skk-gyakubiki-katakana-region) "skk-kakasi" "\
$BNN0h$N4A;z!"Aw$j2>L>$rA4$F%+%?%+%J$KJQ49$9$k!#(B
$B%*%W%7%g%J%k0z?t$N(B ALL $B$,(B non-nil $B$J$i$P!"J#?t$N8uJd$,$"$k>l9g$O!"(B\"{}\" $B$G$/(B
$B$/$C$FI=<($9$k!#(B
$BNc$($P!"(B
    $BCfEg(B -> {$B%J%+%7%^(B|$B%J%+%8%^(B}

\(fn START END &optional ALL)" t nil)

(autoload (quote skk-gyakubiki-katakana-message) "skk-kakasi" "\
$BNN0h$N4A;z!"Aw$j2>L>$rA4$F%+%?%+%J$KJQ498e!"%(%3!<$9$k!#(B
$B%*%W%7%g%J%k0z?t$N(B ALL $B$,(B non-nil $B$J$i$P!"J#?t$N8uJd$,$"$k>l9g$O!"(B\"{}\" $B$G$/(B
$B$/$C$FI=<($9$k!#(B
$BNc$($P!"(B
    $BCfEg(B -> {$B%J%+%7%^(B|$B%J%+%8%^(B}

\(fn START END &optional ALL)" t nil)

(autoload (quote skk-hurigana-region) "skk-kakasi" "\
$BNN0h$N4A;z$KA4$F$U$j$,$J$rIU$1$k!#(B
$BNc$($P!"(B
   \"$BJQ49A0$N4A;z$NOF$K(B\" -> \"$BJQ49A0(B[$B$X$s$+$s$^$((B]$B$N4A;z(B[$B$+$s$8(B]$B$NOF(B[$B$o$-(B]$B$K(B\"

$B%*%W%7%g%J%k0z?t$N(B ALL $B$,(B non-nil $B$J$i$P!"J#?t$N8uJd$,$"$k>l9g$O!"(B\"{}\" $B$G$/(B
$B$/$C$FI=<($9$k!#(B
$BNc$($P!"(B
    \"$BCfEg(B\" -> \"$BCfEg(B[{$B$J$+$7$^(B|$B$J$+$8$^(B}]\"

\(fn START END &optional ALL)" t nil)

(autoload (quote skk-hurigana-message) "skk-kakasi" "\
$BNN0h$N4A;z$KA4$F$U$j$,$J$rIU$1!"%(%3!<$9$k!#(B
$BNc$($P!"(B
   \"$BJQ49A0$N4A;z$NOF$K(B\" -> \"$BJQ49A0(B[$B$X$s$+$s$^$((B]$B$N4A;z(B[$B$+$s$8(B]$B$NOF(B[$B$o$-(B]$B$K(B\"

$B%*%W%7%g%J%k0z?t$N(B ALL $B$,(B non-nil $B$J$i$P!"J#?t$N8uJd$,$"$k>l9g$O!"(B\"{}\" $B$G$/(B
$B$/$C$FI=<($9$k!#(B
$BNc$($P!"(B
    \"$BCfEg(B\" -> \"$BCfEg(B[{$B$J$+$7$^(B|$B$J$+$8$^(B}]\"

\(fn START END &optional ALL)" t nil)

(autoload (quote skk-hurigana-katakana-region) "skk-kakasi" "\
$BNN0h$N4A;z$KA4$F%U%j%,%J$rIU$1$k!#(B
$BNc$($P!"(B
   \"$BJQ49A0$N4A;z$NOF$K(B\" -> \"$BJQ49A0(B[$B%X%s%+%s%^%((B]$B$N4A;z(B[$B%+%s%8(B]$B$NOF(B[$B%o%-(B]$B$K(B\"

$B%*%W%7%g%J%k0z?t$N(B ALL $B$,(B non-nil $B$J$i$P!"J#?t$N8uJd$,$"$k>l9g$O!"(B\"{}\" $B$G$/(B
$B$/$C$FI=<($9$k!#(B
$BNc$($P!"(B
    \"$BCfEg(B\" -> \"$BCfEg(B[{$B%J%+%7%^(B|$B%J%+%8%^(B}]\"

\(fn START END &optional ALL)" t nil)

(autoload (quote skk-hurigana-katakana-message) "skk-kakasi" "\
$BNN0h$N4A;z$KA4$F%U%j%,%J$rIU$1!"%(%3!<$9$k!#(B
$BNc$($P!"(B
   \"$BJQ49A0$N4A;z$NOF$K(B\" -> \"$BJQ49A0(B[$B%X%s%+%s%^%((B]$B$N4A;z(B[$B%+%s%8(B]$B$NOF(B[$B%o%-(B]$B$K(B\"

$B%*%W%7%g%J%k0z?t$N(B ALL $B$,(B non-nil $B$J$i$P!"J#?t$N8uJd$,$"$k>l9g$O!"(B\"{}\" $B$G$/(B
$B$/$C$FI=<($9$k!#(B
$BNc$($P!"(B
    \"$BCfEg(B\" -> \"$BCfEg(B[{$B%J%+%7%^(B|$B%J%+%8%^(B}]\"

\(fn START END &optional ALL)" t nil)

(autoload (quote skk-romaji-region) "skk-kakasi" "\
$BNN0h$N4A;z!"$R$i$,$J!"%+%?%+%J!"A41QJ8;z$rA4$F%m!<%^;z$KJQ49$9$k!#(B
$BJQ49$K$O!"%X%\%s<0$rMQ$$$k!#(B
$BNc$($P!"(B
   \"$B4A;z$+$J:.$8$jJ8$r%m!<%^;z$KJQ49(B\"
    -> \"  kan'zi  kana  ma  ziri  bun'  woro-ma  zi ni hen'kan' \"

skk-romaji-*-by-hepburn $B$,(B nil $B$G$"$l$P!"%m!<%^;z$X$NJQ49MM<0$r71Na<0$KJQ99$9(B
$B$k!#Nc$($P!"(B\"$B$7(B\" $B$O%X%\%s<0$G$O(B \"shi\" $B$@$,!"71Na<0$G$O(B \"si\" $B$H$J$k!#(B

\(fn START END)" t nil)

(autoload (quote skk-romaji-message) "skk-kakasi" "\
$BNN0h$N4A;z!"$R$i$,$J!"%+%?%+%J!"A41QJ8;z$rA4$F%m!<%^;z$KJQ49$7!"%(%3!<$9$k!#(B
$BJQ49$K$O!"%X%\%s<0$rMQ$$$k!#(B
$BNc$($P!"(B
   \"$B4A;z$+$J:.$8$jJ8$r%m!<%^;z$KJQ49(B\"
    -> \"  kan'zi  kana  ma  ziri  bun'  woro-ma  zi ni hen'kan' \"

skk-romaji-*-by-hepburn $B$,(B nil $B$G$"$l$P!"%m!<%^;z$X$NJQ49MM<0$r71Na<0$KJQ99$9(B
$B$k!#Nc$($P!"(B\"$B$7(B\" $B$O%X%\%s<0$G$O(B \"shi\" $B$@$,!"71Na<0$G$O(B \"si\" $B$H$J$k!#(B

\(fn START END)" t nil)

;;;***

;;;### (autoloads (skk-display-code-for-char-at-point skk-input-by-code-or-menu)
;;;;;;  "skk-kcode" "skk-kcode.el" (18210 32971))
;;; Generated autoloads from skk-kcode.el

(autoload (quote skk-input-by-code-or-menu) "skk-kcode" "\
7bit $B$b$7$/$O(B 8bit $B$b$7$/$O(B $B6hE@%3!<%I$KBP1~$9$k(B 2byte $BJ8;z$rA^F~$9$k!#(B

\(fn &optional ARG)" t nil)

(autoload (quote skk-display-code-for-char-at-point) "skk-kcode" "\
$B%]%$%s%H$K$"$kJ8;z$N6hE@%3!<%I!"(BJIS $B%3!<%I!"(BEUC $B%3!<%I5Z$S%7%U%H(B JIS $B%3!<%I(B $B$rI=<($9$k!#(B

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (skk-auto-fill-inactivate skk-inactivate skk-auto-fill-activate
;;;;;;  skk-activate) "skk-leim" "skk-leim.el" (17962 51878))
;;; Generated autoloads from skk-leim.el

(autoload (quote skk-activate) "skk-leim" "\
Not documented

\(fn &optional NAME)" nil nil)

(autoload (quote skk-auto-fill-activate) "skk-leim" "\
Not documented

\(fn &optional NAME)" nil nil)

(autoload (quote skk-inactivate) "skk-leim" "\
Not documented

\(fn)" nil nil)

(autoload (quote skk-auto-fill-inactivate) "skk-leim" "\
Not documented

\(fn)" nil nil)

(register-input-method "japanese-skk" "Japanese" (quote skk-activate) "" "Simple Kana to Kanji conversion program")

(register-input-method "japanese-skk-auto-fill" "Japanese" (quote skk-auto-fill-activate) "" "Simple Kana to Kanji conversion program with auto-fill")

;;;***

;;;### (autoloads (skk-look-ispell skk-look-completion skk-look)
;;;;;;  "skk-look" "skk-look.el" (18090 34886))
;;; Generated autoloads from skk-look.el

(autoload (quote skk-look) "skk-look" "\
UNIX look $B%3%^%s%I$rMxMQ$7$?JQ49$r9T$J$&!#(B
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

(autoload (quote skk-look-completion) "skk-look" "\
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

(autoload (quote skk-look-ispell) "skk-look" "\
Not documented

\(fn WORD &optional SITUATION)" nil nil)

;;;***

;;;### (autoloads nil "skk-macs" "skk-macs.el" (18413 34765))
;;; Generated autoloads from skk-macs.el

(put (quote dolist) (quote lisp-indent-function) 1)

(put (quote dotimes) (quote lisp-indent-function) 1)

(put (quote skk-defadvice) (quote lisp-indent-function) (quote defun))

(put (quote skk-loop-for-buffers) (quote lisp-indent-function) 1)

;;;***

;;;### (autoloads (skk-num skk-num-update-jisyo skk-num-henkan-key
;;;;;;  skk-num-initialize skk-num-uniq skk-num-exp skk-num-multiple-convert
;;;;;;  skk-num-convert skk-num-compute-henkan-key) "skk-num" "skk-num.el"
;;;;;;  (17962 51878))
;;; Generated autoloads from skk-num.el

(autoload (quote skk-num-compute-henkan-key) "skk-num" "\
KEY $B$NCf$NO"B3$9$k?t;z$r8=$o$9J8;zNs$r(B \"#\" $B$KCV$-49$($?J8;zNs$rJV$9!#(B
\"12\" $B$d(B \"$B#0#9(B\" $B$J$IO"B3$9$k?t;z$r(B 1 $B$D$N(B \"#\" $B$KCV$-49$($k$3$H$KCm0U!#(B
$BCV$-49$($??t;z$r(B `skk-num-list' $B$NCf$K%j%9%H$N7A$GJ]B8$9$k!#(B
$BNc$($P!"(BKEY $B$,(B \"$B$X$$$;$$(B7$BG/(B12$B$,$D(B\" $B$G$"$l$P!"(B\"$B$X$$$;$$(B#$B$M$s(B#$B$,$D(B\"
$B$HJQ49$7!"(B`skk-num-list' $B$K(B (\"7\" \"12\") $B$H$$$&%j%9%H$rBeF~$9$k!#(B
$B<-=q$N8+=P$78l$N8!:w$K;HMQ$9$k!#(B

\(fn KEY)" nil nil)

(autoload (quote skk-num-convert) "skk-num" "\
INDEX $B$,;X$9(B `skk-henkan-list' $B$NMWAG$r?tCMJQ49$N$?$a$K2C9)$9$k!#(B
`skk-henkan-list' $B$N(B INDEX $B$,;X$7$F$$$k8uJd(B ($B?tCMJQ49%-!<$N(B)$B$r(B
  \"#2\" -> (\"#2\" .\"$B0l(B\")
$B$N$h$&$KJQ49$9$k!#(B

\(fn INDEX)" nil nil)

(autoload (quote skk-num-multiple-convert) "skk-num" "\
Not documented

\(fn &optional COUNT)" nil nil)

(autoload (quote skk-num-exp) "skk-num" "\
ascii $B?t;z(B (string) $B$N(B NUM $B$r(B TYPE $B$K=>$$JQ49$7!"JQ498e$NJ8;zNs$rJV$9!#(B
TYPE $B$O2<5-$NDL$j!#(B
0 -> $BL5JQ49(B
1 -> $BA43Q?t;z$XJQ49(B
2 -> $B4A?t;z$XJQ49(B ($B0L<h$j$J$7(B)
3 -> $B4A?t;z$XJQ49(B ($B0L<h$j$r$9$k(B)
4 -> $B$=$N?t;z$=$N$b$N$r%-!<$K$7$F<-=q$r:F8!:w(B
5 -> $B4A?t;z(B ($B<j7A$J$I$G;HMQ$9$kJ8;z$r;HMQ(B) $B$XJQ49(B ($B0L<h$j$r$9$k(B)
9 -> $B>-4}$G;HMQ$9$k?t;z(B (\"$B#3;M(B\" $B$J$I(B) $B$KJQ49(B

\(fn NUM TYPE)" nil nil)

(autoload (quote skk-num-uniq) "skk-num" "\
Not documented

\(fn)" nil nil)

(autoload (quote skk-num-initialize) "skk-num" "\
`skk-use-numeric-conversion' $B4XO"$NJQ?t$r=i4|2=$9$k!#(B

\(fn)" nil nil)

(autoload (quote skk-num-henkan-key) "skk-num" "\
$BE,@Z$JJQ49%-!<$rJV$9!#(B
type4 $B$N?tCM:FJQ49$,9T$J$o$l$?$H$-$O!"?tCM<+?H$rJV$7!"$=$l0J30$N?tCMJQ49(B
$B$G$O!"(B`skk-henkan-key' $B$N?tCM$r(B \"#\" $B$GCV$-49$($?%-!<$rJV$9!#(B

\(fn)" nil nil)

(autoload (quote skk-num-update-jisyo) "skk-num" "\
$B?t;z<+?H$r8+=P$78l$H$7$F<-=q$N%"%C%W%G!<%H$r9T$J$&!#(B

\(fn NOCONVWORD WORD &optional PURGE)" nil nil)

(autoload (quote skk-num) "skk-num" "\
$B?t;z$r(B `skk-number-style' $B$NCM$K=>$$JQ49$9$k!#(B
`skk-current-date' $B$N%5%V%k!<%A%s!#(B

\(fn STR)" nil nil)

;;;***

;;;### (autoloads (skk-obsolete-put-obsolete-mark skk-obsolete-check-all-files
;;;;;;  skk-obsolete-check) "skk-obsolete" "skk-obsolete.el" (18147
;;;;;;  14268))
;;; Generated autoloads from skk-obsolete.el

(autoload (quote skk-obsolete-check) "skk-obsolete" "\
FILE $BFb$N(B obsolete $BJQ?tL>$H(B obsolete $B4X?tL>$r%A%'%C%/$7!"=q49$($k!#(B

\(fn FILE)" t nil)

(autoload (quote skk-obsolete-check-all-files) "skk-obsolete" "\
$B4XO"%U%!%$%kA4$F$N(B obsolete $BJQ?tL>$H(B obsolete $B4X?tL>$r%A%'%C%/$7!"=q49$($k!#(B
C-u M-x skk-obsolete-check-all-files $B$N$h$&$K5/F0$7$?$H$-$O!"%G%#%U%)%k%H%G%#%l(B
$B%/%H%j$K$"$k(B SKK $B%W%m%0%i%`%U%!%$%k$b%A%'%C%/$r9T$J$&!#(B

\(fn &optional PROGRAM-FILES-TOO)" t nil)

(autoload (quote skk-obsolete-put-obsolete-mark) "skk-obsolete" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (skk-comp-by-server-completion skk-server-completion-search)
;;;;;;  "skk-server-completion" "skk-server-completion.el" (18105
;;;;;;  57050))
;;; Generated autoloads from skk-server-completion.el

(autoload (quote skk-server-completion-search) "skk-server-completion" "\
$B%5!<%P!<%3%s%W%j!<%7%g%s$r9T$$!"F@$i$l$?3F8+=P$7$G$5$i$K8!:w$9$k!#(B
$BAw$jM-$jJQ49$K$OHsBP1~!#(B

\(fn)" nil nil)

(autoload (quote skk-comp-by-server-completion) "skk-server-completion" "\
Server completion $B$KBP1~$7$?(B SKK $B%5!<%P$rMxMQ$9$kJd40%W%m%0%i%`!#(B
`skk-completion-prog-list' $B$NMWAG$K;XDj$7$F;H$&!#(B

\(fn)" nil nil)

;;;***

;;;### (autoloads (skk-disconnect-server skk-adjust-search-prog-list-for-server-search
;;;;;;  skk-search-server-1 skk-server-version) "skk-server" "skk-server.el"
;;;;;;  (18145 59207))
;;; Generated autoloads from skk-server.el

(autoload (quote skk-server-version) "skk-server" "\
Return version information of SKK server.
When called interactively, print version information.

\(fn)" t nil)

(autoload (quote skk-search-server-1) "skk-server" "\
skk-search-server $B$N%5%V%k!<%A%s!#(B

\(fn FILE LIMIT)" nil nil)

(autoload (quote skk-adjust-search-prog-list-for-server-search) "skk-server" "\
$BJQ?t(B `skk-search-prog-list' $B$rD4@0$9$k!#(B
`skk-server-host' $B$b$7$/$O(B `skk-servers-list' $B$,(B nil $B$G$"$l$P!"(B
`skk-search-prog-list' $B$+$i(B `skk-search-server' $B$r(B car $B$K;}$D%j%9%H$r>C$9!#(B
non-nil $B$G$"$l$P!"2C$($k!#(B

\(fn &optional NON-DEL)" nil nil)

(autoload (quote skk-disconnect-server) "skk-server" "\
$B%5!<%P!<$r@Z$jN%$9!#(B

\(fn)" nil nil)

;;;***

;;;### (autoloads (skk-search-tankanji skk-tankan-search) "skk-tankan"
;;;;;;  "skk-tankan.el" (18162 35187))
;;; Generated autoloads from skk-tankan.el

(autoload (quote skk-tankan-search) "skk-tankan" "\
Not documented

\(fn FUNC &rest ARGS)" nil nil)

(autoload (quote skk-search-tankanji) "skk-tankan" "\
Not documented

\(fn &optional JISYO)" nil nil)

;;;***

;;;### (autoloads (skk-tutorial) "skk-tut" "skk-tut.el" (17962 51878))
;;; Generated autoloads from skk-tut.el

(autoload (quote skk-tutorial) "skk-tut" "\
Start SKK tutorial.
You can select English version by \\[universal-argument] \\[skk-tutorial].

\(fn &optional QUERY-LANGUAGE)" t nil)

;;;***

;;;### (autoloads (skk-preload) "skk-vars" "skk-vars.el" (18793 14012))
;;; Generated autoloads from skk-vars.el

(put (quote skk-deflocalvar) (quote lisp-indent-function) (quote defun))

(put (quote skk-kutouten-type) (quote safe-local-variable) (quote symbolp))

(defvar skk-preload nil "\
Non-nil $B$J$i$P!"(BSKK $B$rA0$b$C$F%m!<%I$9$k!#(B
$B$3$l$K$h$C$F=i2s5/F0$,9bB.$K$J$k!#(B")

(custom-autoload (quote skk-preload) "skk-vars" t)

(defvar skk-isearch-switch nil)

;;;***

;;;### (autoloads (skk-version) "skk-version" "skk-version.el" (18119
;;;;;;  34877))
;;; Generated autoloads from skk-version.el

(autoload (quote skk-version) "skk-version" "\
Return SKK version with its codename.
If WITHOUT-CODENAME is non-nil, simply return SKK version without
the codename.

\(fn &optional WITHOUT-CODENAME)" t nil)

;;;***

;;;### (autoloads (skk-preload skk-remove-duplicates skk-henkan-on-message
;;;;;;  skk-compile-rule-list skk-auto-fill-mode skk-mode) "skk"
;;;;;;  "skk.el" (18793 14012))
;;; Generated autoloads from skk.el

(autoload (quote skk-mode) "skk" "\
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

A tutorial is available in Japanese or English via \"M-x skk-tutorial\".
Use a prefix argument to choose the language.  The default is system-
dependent.

\(fn &optional ARG)" t nil)

(autoload (quote skk-auto-fill-mode) "skk" "\
$BF|K\8lF~NO%b!<%I!#<+F0@^$jJV$75!G=IU$-!#(B
$B%^%$%J!<%b!<%I$N0l<o$G!"%*%j%8%J%k$N%b!<%I$K$O1F6A$rM?$($J$$!#(B
$B@5$N0z?t$rM?$($k$H!"6/@)E*$K(B `auto-fill-mode' $B5Z$S(B SKK $B%b!<%I$KF~$k!#(B
$BIi$N0z?t$rM?$($k$H(B `auto-fill-mode' $B5Z$S(B SKK $B%b!<%I$+$iH4$1$k!#(B

\(fn &optional ARG)" t nil)

(autoload (quote skk-compile-rule-list) "skk" "\
rule list $B$rLZ$N7A$K%3%s%Q%$%k$9$k!#(B

\(fn &rest RULE-LISTS)" nil nil)

(autoload (quote skk-henkan-on-message) "skk" "\
Not documented

\(fn)" nil nil)

(autoload (quote skk-remove-duplicates) "skk" "\
LIST $B$+$i=EJ#$r$J$/$7$?%j%9%H$rJV$9!#(B

\(fn LIST)" nil nil)

(autoload (quote skk-preload) "skk" "\
$BJQ?t(B `skk-preload' $B$,Hs(B nil $B$N$H$-!"(B`after-init-hook' $B$+$i8F$P$l$k!#(B
$B$"$i$+$8$a(B SKK $B$r8F$s$G$*$/$3$H$G!"(B SKK $B$N=i2s5/F0$rB.$/$9$k!#(B

\(fn)" nil nil)

(add-hook (quote after-init-hook) (function (lambda nil (when (and (symbol-value (quote init-file-user)) skk-preload) (skk-preload)))) t)

;;;***

;;;### (autoloads (skk-study-read skk-study-save skk-study-update
;;;;;;  skk-study-search) "skk-study" "skk-study.el" (17962 51878))
;;; Generated autoloads from skk-study.el

(autoload (quote skk-study-search) "skk-study" "\
$B3X=,%G!<%?$r;2>H$7$F(B ENTRY $B$r2C9)$7!"4XO"@-$N$"$k8l$NM%@h=g0L$r>e$2$FJV$9!#(B

\(fn HENKAN-BUFFER MIDASI OKURIGANA ENTRY)" nil nil)

(autoload (quote skk-study-update) "skk-study" "\
MIDASI $B$H(B WORD $B$K$D$$$F(B `skk-study-data-ring' $B$N:G=i$N4XO"8l$r4XO"IU$1$F3X=,$9$k!#(B

\(fn HENKAN-BUFFER MIDASI OKURIGANA WORD PURGE)" nil nil)

(autoload (quote skk-study-save) "skk-study" "\
`skk-study-file' $B$K3X=,7k2L$rJ]B8$9$k!#(B
$B%*%W%7%g%J%k0z?t$N(B NOMSG $B$,(B non-nil $B$G$"$l$P!"J]B8%a%C%;!<%8$r=PNO$7$J$$!#(B

\(fn &optional NOMSG)" t nil)

(autoload (quote skk-study-read) "skk-study" "\
`skk-study-file' $B$+$i3X=,7k2L$rFI$_9~$`!#(B
$B%*%W%7%g%J%k0z?t$N(B FORCE $B$,(B non-nil $B$G$"$l$P!"GK4~$N3NG'$r$7$J$$!#(B

\(fn &optional NOMSG FORCE)" t nil)

;;;***
(provide 'skk-autoloads)
;;; skk-autoloads.el ends here
