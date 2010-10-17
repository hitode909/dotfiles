;;
;;      dmacro.el - $B%-!<A`:n$N7+JV$78!=P(B & $B<B9T(B
;;
;;      1993 4/14        original idea by $BA}0f=SG7!w%7%c!<%W(B
;;                         implemented by $BB@OBED@?!wD92,5;2JBg(B
;;                          refinement by $BA}0f=SG7!w%7%c!<%W(B
;;	1995 3/30 modified for Emacs19 by $BA}0f=SG7!w%7%c!<%W(B
;;
;;	2002 3              XEmacs$BBP1~(B by $B>.H*1Q;J(B obata@suzuki.kuee.kyoto-u.ac.jp
;;                                        $BJv?-9T(B zah07175@rose.zero.ad.jp
;;
;;

;;
;; dmacro.el $B$O!"7+$jJV$5$l$k%-!<A`:nNs$+$i<!$NA`:n$rM=B,$7<B9T$5$;$k(B
;; $B$?$a$N%W%m%0%i%`$G$9!#A`:n$N7+JV$7$N8!=P$H$=$N<B9T$r;XNa$9$k$?$a$K(B
;; *dmacro-key* $B$G;XDj$9$kFCJL$N!V7+JV$7%-!<!W$r;HMQ$7$^$9!#(B
;; 
;; $BNc$($P%f!<%6$,(B
;;     abcabc
;; $B$HF~NO$7$?8e!V7+JV$7%-!<!W$r2!$9$H!"(Bdmacro.el $B$O(B "abc" $B$NF~NOA`:n$N(B
;; $B7+JV$7$r8!=P$7$F$=$l$r<B9T$7!"$=$N7k2L%F%-%9%H$O(B
;;     abcabcabc
;; $B$H$J$j$^$9!#$^$?!"(B
;;     abcdefab
;; $B$HF~NO$7$?8e!V7+JV$7%-!<!W$r2!$9$H!"(Bdmacro.el $B$O$3$l$r(B "abcdef" $B$N(B
;; $BF~NO$N7+JV$7$HH=CG$7!"7+JV$7$N;D$j$NItJ,$rM=B,<B9T$7$F(B "cdef" $B$rF~NO$7!"(B
;; $B%F%-%9%H$O(B
;;     abcdefabcdef
;; $B$H$J$j$^$9!#$3$3$G$b$&0lEY!V7+JV$7%-!<!W$r2!$9$H!"(B"abcdef" $B$NF~NO(B
;; $B$,7+$jJV$5$l$F!"%F%-%9%H$O(B
;;     abcdefabcdefabcdef
;; $B$H$J$j$^$9!#(B
;; 
;; $B$"$i$f$k%-!<A`:n$N7+JV$7$,G'<1!"<B9T$5$l$k$?$a!"Nc$($P(B
;;     line1
;;     line2
;;     line3
;;     line4
;; $B$H$$$&%F%-%9%H$r(B
;;     % line1
;;     % line2
;;     line3
;;     line4
;; $B$N$h$&$KJT=8$7$?8e!V7+JV$7%-!<!W$r2!$9$H%F%-%9%H$O(B
;;     % line1
;;     % line2
;;     % line3
;;     line4
;; $B$N$h$&$K$J$j!"$=$N8e2!$9$?$S$K<!$N9TF,$K(B "% "$B$,DI2C$5$l$F$$$-$^$9!#(B
;; 
;; $B$3$N$h$&$J5!G=$O!"7+JV$7%Q%?%s$NG'<1$K$h$j%-!<%\!<%I%^%/%m$r<+F0E*$K(B
;; $BDj5A$7$F$$$k$H9M$($k$3$H$b$G$-$^$9!#%-!<%\!<%I%^%/%m$N>l9g$OA`:n$r(B
;; $B3+;O$9$k0JA0$K$=$N$3$H$r%f!<%6$,G'<1$7$F%^%/%m$rEPO?$9$kI,MW$,$"$j(B
;; $B$^$9$,!"(Bdmacro.el $B$G$O<B:]$K7+JV$7A`:n$r$7$F$7$^$C$?8e$G$=$N$3$H$K(B
;; $B5$$,$D$$$?>l9g$G$b!V7+JV$7%-!<!W$r2!$9$@$1$G$=$NA`:n$r$^$?<B9T$5$;$k(B
;; $B$3$H$,$G$-$^$9!#$^$?%^%/%m$NDj5AJ}K!(B($BA`:n$N8e$G!V7+JV$7%-!<!W$r2!$9(B
;; $B$@$1(B)$B$b%-!<%\!<%I%^%/%m$N>l9g(B($B%^%/%m$N3+;O$H=*N;$r;XDj$9$k(B)$B$KHf$Y$F(B
;; $BC1=c$K$J$C$F$$$^$9!#(B
;;  
;; $B!|(B $B;HMQNc(B
;;  
;; $B!&J8;zNsCV49(B
;; 
;; $B%F%-%9%HCf$NA4$F$N!V(Babc$B!W$r!V(Bdef]$B$K=$@5$9$k>l9g$r9M$($F$_$^$9!#(B
;; $B!V(Babc$B!W$r8!:w$9$k%-!<A`:n$O(B "Ctrl-S a b c ESC" $B$G!"$3$l$O(B
;; "DEL DEL DEL d e f" $B$G!V(Bdef$B!W$K=$@5$9$k$3$H$,$G$-$^$9!#(B
;; $B0z$-B3$-<!$N!V(Babc$B!W$r8!:w$9$k(B "Ctrl-S a b c ESC" $B$rF~NO$7$?8e$G(B
;; $B!V7+JV$7%-!<!W$r2!$9$H(B "DEL DEL DEL d e f" $B$,M=B,<B9T$5$l!"?7$?$K(B
;; $B8!:w$5$l$?!V(Babc$B!W$,!V(Bdef$B!W$K=$@5$5$l$^$9!#$3$3$G$^$?!V7+JV$7%-!<!W(B
;; $B$r2!$9$H<!$N!V(Babc$B!W$,!V(Bdef$B!W$K=$@5$5$l$^$9!#(B
;; $B$3$N$h$&$K!V7+JV$7%-!<!W$r2!$7$F$$$/$3$H$K$h$j=g!9$KJ8;zNs$r(B
;; $BCV49$7$F$$$/$3$H$,$G$-$^$9!#(B
;; 
;; $B!&7S@~$K$h$k$*3(=q$-(B
;; 
;; $B7+JV$7$r4^$`3($r4JC1$K=q$/$3$H$,$G$-$^$9!#Nc$($P!"(B
;;   $B(!($(#($(#($(#($(#($(#($(#($(#($(#($(#($(#($(#($(#($(#($(B
;;     $B(&(%(&(%(&(%(&(%(&(%(&(%(&(%(&(%(&(%(&(%(&(%(&(%(&(%(B
;; $B$N$h$&$J3($r=q$-$?$$>l9g$O!"(Bkeisen.el $B$J$I$r;H$C$F(B
;;   $B(!($(#($(B
;;     $B(&(%(B
;; $B$H=q$$$?8e$G!V7+JV$7!W%-!<$r2!$9$H!"(B
;;   $B(!($(#($(B
;;     $B(&(%(&(%(B
;; $B$H$J$j!"$b$&0lEY!V7+JV$7%-!<!W$r2!$9$H(B
;;   $B(!($(#($(#($(B
;;     $B(&(%(&(%(&(%(B
;; $B$H$J$j$^$9!#F1MM$K(B
;;  $B(#(!($(#(!($(#(!($(#(!($(#(!($(#(!($(#(!($(#(!($(B
;;  $B(&(!(%(&(!(%(&(!(%(&(!(%(&(!(%(&(!(%(&(!(%(&(!(%(B
;; $B$N$h$&$J3($b(B
;;  $B(#(!($(B  $B(!(B
;;  $B(&(!(%(B
;; $B$@$1F~NO$7$?8e!V7+JV$7%-!<!W$rO"B3$7$F2!$9$@$1$GIA$/$3$H$,$G$-$^$9!#(B
;;  
;; $B!|(B $B7+JV$7M=B,$NJ}K!(B
;;  
;; $BF~NO$N7+JV$7$NM=B,<jK!$O$$$m$$$m9M$($i$l$^$9$,!"(Bdmacro.el$B$G$O(B
;; $B0J2<$N$h$&$JM%@hEY$r$b$?$;$F$$$^$9!#(B
;; 
;;  (1) $BF1$8F~NO%Q%?%s$,M=B,$ND>A0$K(B2$BEY7+JV$5$l$F$$$k>l9g$O$=$l$r(B
;;      $BM%@h$9$k!#7+JV$7%Q%?%s$,J#?t$"$k>l9g$OD9$$$b$N$rM%@h$9$k!#(B
;; 
;;      $BNc$($P!"!V$+$o$$$$$+$o$$$$!W$H$$$&F~NO$G$O!V$+$o$$$$!W$H(B
;;      $B$$$&%Q%?%s$,7+$jJV$5$l$?$H$$$&2r<a$H!"!V$$!W$H$$$&%Q%?%s$,(B
;;      $B7+$jJV$5$l$?$H$$$&2r<a$NN>J}$,2DG=$G$9$,!"$3$N>l9g(B
;;      $B!V$+$o$$$$!W$rM%@h$7$^$9!#(B
;; 
;;  (2) (1)$B$N>l9g$K$"$F$O$^$i$:!"D>A0$NF~NONs(B<s>$B$,$=$l0JA0$NF~NONs$N(B
;;      $B0lIt$K$J$C$F$$$k>l9g(B($BD>A0$NF~NO$,(B<s> <t> <s>$B$N$h$&$J7A$K(B
;;      $B$J$C$F$$$k>l9g(B)$B$O!"$^$:(B<t>$B$rM=B,$7!"$=$N<!$+$i(B<s> <t>$B$rM=B,(B
;;      $B$9$k!#$3$N$H$-(B<s>$B$ND9$$$b$N$rM%@h$7!"$=$NCf$G$O(B<t>$B$,C;$$$b$N(B
;;      $B$rM%@h$9$k!#(B
;; 
;;      $BNc$($P!V(Babracadabra$B!W$H$$$&F~NO$G$O!"(B<s>=$B!V(Babra$B!W$,:GD9$J$N$G(B
;;      <s> <t>=$B!V(Bcadabra$B!W$NM=B,$,M%@h$5$l$^$9!#(B
;;
;; $B!|(B XEmacs $BBP1~!"(BSuper, Hyper, Alt $B%-!<$NBP1~$K$D$$$F(B
;;
;; $B$3$NHG$G$O(B XEmacs $B$K$bBP1~$7$^$7$?!#(B
;; $B8=:_$N$H$3$m(B GNU Emacs 18, 19, 20, 21, XEmacs 21 $B$G(B
;; $BF0:n$9$k$3$H$,3NG'$G$-$F$$$^$9!#(B
;; $B$^$?=>Mh$N(B dmacro $B$G$O(B Super, Hyper, Alt $B$N%-!<F~NO$r(B
;; $B@5$7$/07$&$3$H$,$G$-$^$;$s$G$7$?$,!"$3$N%P!<%8%g%s$G$O(B
;; $B07$($k$h$&$K$J$C$F$$$^$9!#(B
;; $B7+$jJV$7$N%-!<$H$7$F(B *dmacro-key* $B$K(B Super, Hyper, Alt, Meta
;; $B$r4^$a$?%-!<$r;H$&$3$H$b$G$-$^$9$,!"$?$@$7$=$N:]$O(B
;; $B0J2<$NCm0U$K=>$C$F2<$5$$!#(B
;;
;; $B!|(B *dmacro-key* $B$N;XDj(B
;;
;; GNU Emacs $B$N>l9g(B
;;   Modifier key $B$H$7$F(B Control $B$N$_$,;H$o$l$k>l9g$O(B "\C-t" $B$N$h$&$J(B
;;   $BJ8;zNs$H$7$F;XDj$G$-$^$9!#(BMeta, Super, Hyper, Alt $B$rMxMQ$9$k>l9g$K$O(B
;;   $B$=$l$>$l(B [?\M-t], [?\s-t], [?\H-t], [?\A-t] $B$N$h$&$K;XDj$7$F2<$5$$!#(B
;;
;; XEmacs $B$N>l9g(B
;;   Meta key $B$r;H$&>l9g$G$b>e5-$N$h$&$J@)8B$O$"$j$^$;$s!#(BSuper $BEy$r;H$&(B
;;   $B>l9g$K$O(B [(super t)] $B$N$h$&$K;XDj$7$F2<$5$$!#(B
;;
;; $B!|(B $B@_DjJ}K!(B
;;
;;  .emacs$B$J$I$K0J2<$N9T$rF~$l$F2<$5$$!#(B
;;
;; (defconst *dmacro-key* "\C-t" "$B7+JV$7;XDj%-!<(B")
;; (global-set-key *dmacro-key* 'dmacro-exec)
;; (autoload 'dmacro-exec "dmacro" nil t)
;;
;; $B%*%j%8%J%k$NO"Mm@h(B:
;; $BA}0f=SG7(B
;; $B%7%c!<%W3t<02q<R(B $B%=%U%H%&%'%"8&5f=j(B
;; masui@shpcsl.sharp.co.jp
;;
;; 2002/6/3$B8=:_$NO"Mm@h(B:
;; $BA}0f=SG7(B
;; ($B3t(B)$B%=%K!<%3%s%T%e!<%?%5%$%(%s%98&5f=j(B
;; masui@acm.org
;;

(defvar dmacro-array-type
  (if (and (boundp 'emacs-major-version)
	   (>= emacs-major-version 19))
      'vector 'string)
  "dmacro $B$NFbIt$G=hM}$9$kG[Ns$N<oN`!#(B
emacs 19 $B0J>e$J$i%G%U%)%k%H$G(B vector $B$K$9$k!#(B
string $B$G$O(B hyper, super, alt $B$r4^$s$@F~NO$N7+$jJV$7$,(B
$B@5$7$/=hM}$G$-$J$$$N$GCm0U!#(B
GNU Emacs 18 (Nemacs) $B$r;H$C$F$$$kJ}0J30$O(B vector $B$GLdBj$"$j$^$;$s!#(B")

(fset 'dmacro-concat
      (cond ((eq dmacro-array-type 'string) 'concat)
	    ((eq dmacro-array-type 'vector) 'vconcat)))
	    
(fset 'dmacro-subseq
      (cond ((featurep 'xemacs) 'subseq)
            ((and (eq dmacro-array-type 'vector)
                  (boundp 'emacs-major-version)
                  (eq emacs-major-version 19))
             (require 'cl)
             'subseq)
            (t 'substring)))
 
(defvar *dmacro-arry* nil "$B7+JV$7%-!<G[Ns(B")
(defvar *dmacro-arry-1* nil "$B7+JV$7%-!<$NItJ,G[Ns(B")

(setq dmacro-key
      (cond ((eq dmacro-array-type 'string)
             *dmacro-key*)
            (t
             (let ((key *dmacro-key*))
               (cond ((featurep 'xemacs)
                      (if (arrayp key)
                          (mapvector 'character-to-event key)
                        (vector (character-to-event key))))
                     (t
                      (vconcat key)))))))

(setq dmacro-keys (dmacro-concat dmacro-key dmacro-key))

(defun dmacro-exec ()
  "$B%-!<A`:n$N7+JV$7$r8!=P$7<B9T$9$k(B"
  (interactive)
  (let ((s (dmacro-get)))
    (if (null s)
	(message "$BA`:n$N7+JV$7$,8+$D$+$j$^$;$s(B")
      (execute-kbd-macro s)
      )
    ))

(defun dmacro-event (e)
  (cond
   ((integerp e) e)
   ((eq e 'backspace) 8)
   ((eq e 'tab) 9)
   ((eq e 'enter) 13)
   ((eq e 'return) 13)
   ((eq e 'escape) 27)
   ((eq e 'delete) 127)
   (t 0)
   ))

(defun dmacro-recent-keys ()
  (cond ((eq dmacro-array-type 'vector) (recent-keys))
	((eq dmacro-array-type 'string)
	 (let ((s (recent-keys)) )
	   (if (stringp s) s
	     (concat (mapcar 'dmacro-event s))
	     )))))

(defun dmacro-get ()
  (let ((rkeys (dmacro-recent-keys)) arry)
    (if (if (featurep 'xemacs)
            (let ((keys (vconcat dmacro-key
                                 (or *dmacro-arry-1* *dmacro-arry*)
                                 dmacro-key)))
              (equal keys
                     (subseq rkeys (- (length keys)))))
          (equal dmacro-keys (dmacro-subseq rkeys (- (length dmacro-keys)))))
        (progn
          (setq *dmacro-arry-1* nil)
          *dmacro-arry*)
      (setq arry (dmacro-search (dmacro-subseq rkeys 0 (- (length dmacro-key)))))
      (if (null arry)
          (setq *dmacro-arry* nil)
        (let ((s1 (car arry)) (s2 (cdr arry)))
          (setq *dmacro-arry* (dmacro-concat s2 s1)
                *dmacro-arry-1* (if (equal s1 "") nil s1))
          (setq last-kbd-macro *dmacro-arry*)
          (if (equal s1 "") *dmacro-arry* s1))
        ))))

(defun dmacro-search (array)
  (let* ((arry (dmacro-array-reverse array))
         (sptr  1)
         (dptr0 (dmacro-array-search (dmacro-subseq arry 0 sptr) arry sptr))
         (dptr dptr0)
         maxptr)
    (while (and dptr0
                (not (dmacro-array-search dmacro-key (dmacro-subseq arry sptr dptr0))))
      (if (= dptr0 sptr)
          (setq maxptr sptr))
      (setq sptr (1+ sptr))
      (setq dptr dptr0)
      (setq dptr0 (dmacro-array-search (dmacro-subseq arry 0 sptr) arry sptr))
      )
    (if (null maxptr)
        (let ((predict-arry (dmacro-array-reverse (dmacro-subseq arry (1- sptr) dptr))))
          (if (dmacro-array-search dmacro-key predict-arry)
              nil
            (cons predict-arry (dmacro-array-reverse (dmacro-subseq arry 0 (1- sptr)))))
          )
      (cons "" (dmacro-array-reverse (dmacro-subseq arry 0 maxptr)))
      )
    ))

(defun dmacro-array-reverse (arry)
  (dmacro-concat (reverse (mapcar 'identity arry))))

(defun dmacro-array-search (pat arry &optional start)
  (let* ((len (length pat))
	 (max (- (length arry) len))
	 p found
	 )
    (setq p (if start start 0))
    (while (and (not found) (<= p max))
      (setq found (equal pat (dmacro-subseq arry p (+ p len))))
      (if (not found) (setq p (1+ p)))
      )
    (if found p nil)
    ))


