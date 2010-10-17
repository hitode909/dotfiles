;;; skk-macs.el --- macros and inline functions commonly used in SKK -*- coding: iso-2022-jp -*-

;; Copyright (C) 1999-2008  SKK Development Team <skk@ring.gr.jp>
;; Copyright (C) 1993, 2000 Free Software Foundation, Inc.

;; Author: SKK Development Team <skk@ring.gr.jp>
;; Maintainer: SKK Development Team <skk@ring.gr.jp>
;; Version: $Id: skk-macs.el,v 1.130 2008/03/27 13:24:48 skk-cvs Exp $
;; Keywords: japanese, mule, input method
;; Last Modified: $Date: 2008/03/27 13:24:48 $

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

;;; Code:

(eval-when-compile
  (defvar mule-version)
  (defvar skk-e21-modeline-property))

(eval-when-compile
  (require 'advice)
  (require 'static))

(eval-and-compile
  (require 'skk-vars))

;;;; macros

(put 'ignore-errors 'defmacro-maybe (not (eq skk-emacs-type 'xemacs)))
(defmacro-maybe ignore-errors (&rest body)
  "Execute FORMS; if an error occurs, return nil.
Otherwise, return result of last FORM."
  `(condition-case nil
       (progn
	 ,@body)
     (error nil)))

;;;###autoload
(put 'dolist 'lisp-indent-function 1)
(put 'dolist 'defmacro-maybe (eq skk-emacs-type 'mule4))

;; From GNU Emacs 21.
(defmacro-maybe dolist (spec &rest body)
  "(dolist (VAR LIST [RESULT]) BODY...): loop over a list.
Evaluate BODY with VAR bound to each car from LIST, in turn.
Then evaluate RESULT to get return value, default nil."
  (let ((temp (make-symbol "--dolist-temp--")))
    (list 'let (list (list temp (nth 1 spec)) (car spec))
	  (list 'while temp
		(list 'setq (car spec) (list 'car temp))
		(cons 'progn
		      (append body
			      (list (list 'setq temp (list 'cdr temp))))))
	  (if (cdr (cdr spec))
	      (cons 'progn
		    (cons (list 'setq (car spec) nil) (cdr (cdr spec))))))))

;;;###autoload
(put 'dotimes 'lisp-indent-function 1)
(put 'dotimes 'defmacro-maybe (eq skk-emacs-type 'mule4))

;; From GNU Emacs 21.
(defmacro-maybe dotimes (spec &rest body)
  "(dotimes (VAR COUNT [RESULT]) BODY...): loop a certain number of times.
Evaluate BODY with VAR bound to successive integers running from 0,
inclusive, to COUNT, exclusive.  Then evaluate RESULT to get
the return value (nil if RESULT is omitted)."
  (let ((temp (make-symbol "--dotimes-temp--")))
    (list 'let (list (list temp (nth 1 spec)) (list (car spec) 0))
	   (list 'while (list '< (car spec) temp)
		 (cons 'progn
		       (append body (list (list 'setq (car spec)
						(list '1+ (car spec)))))))
	   (if (cdr (cdr spec))
	       (car (cdr (cdr spec)))
	     nil))))

(defmacro skk-defadvice (function &rest everything-else)
  "Defines a piece of advice for FUNCTION (a symbol).
This is like `defadvice', but warns if FUNCTION is a subr command and advice
doesn't give arguments of `interactive'. See `interactive' for details."
  (let ((origfunc (and (fboundp function)
		       (if (ad-is-advised function)
			   (ad-get-orig-definition function)
			 (symbol-function function))))
	interactive)
    (unless
	(or (not origfunc)
	    (not (subrp origfunc))
	    (memq function ; XXX possibilly Emacs version dependent
		  ;; built-in commands which do not have interactive specs.
		  '(abort-recursive-edit
		    bury-buffer
		    delete-frame
		    delete-window
		    exit-minibuffer)))
      ;; check if advice definition has a interactive call or not.
      (setq interactive
	    (cond
	     ((and (stringp (nth 1 everything-else)) ; have document
		   (eq 'interactive (car-safe (nth 2 everything-else))))
	      (nth 2 everything-else))
	     ((eq 'interactive (car-safe (nth 1 everything-else)))
	      (nth 1 everything-else))))
      (cond
       ((and (commandp origfunc)
	     (not interactive))
	(message
	 "\
*** WARNING: Adding advice to subr %s\
 without mirroring its interactive spec ***"
		 function))
       ((and (not (commandp origfunc))
	     interactive)
	(setq everything-else (delq interactive everything-else))
	(message
	 "\
*** WARNING: Deleted interactive call from %s advice\
 as %s is not a subr command ***"
	 function function))))
    `(defadvice ,function ,@everything-else)))

;;;###autoload
(put 'skk-defadvice 'lisp-indent-function 'defun)
(def-edebug-spec skk-defadvice defadvice)

(defmacro skk-save-point (&rest body)
  `(let ((skk-save-point (point-marker)))
     (unwind-protect
	 (progn
	   ,@body)
       (goto-char skk-save-point)
       (skk-set-marker skk-save-point nil))))

(def-edebug-spec skk-save-point t)

(defmacro skk-message (japanese english &rest arg)
  "$B%a%C%;!<%8$rI=<($9$k!#(B
`skk-japanese-message-and-error' $B$,(B non-nil $B$@$C$?$i(B JAPANESE $B$r(B nil $B$G$"$l$P(B
ENGLISH $B$r%(%3!<%(%j%"$KI=<($9$k!#(BARG $B$O(B `message' $B4X?t$NBh#20z?t0J9_$N0z?t$H(B
$B$7$FEO$5$l$k!#(B"
  (append
   (if arg
       (list 'message (list 'if
			    'skk-japanese-message-and-error
			    japanese
			    english))
     (list 'message "%s" (list 'if
			       'skk-japanese-message-and-error
			       japanese
			       english)))
   arg))

(defmacro skk-error (japanese english &rest arg)
  "$B%a%C%;!<%8$rI=<($7$F!"%(%i!<$rH/@8$5$;$k!#(B
`skk-japanese-message-and-error' $B$,(B non-nil $B$@$C$?$i(B JAPANESE $B$r(B nil $B$G$"$l$P(B
ENGLISH $B$r%(%3!<%(%j%"$KI=<($7!"%(%i!<$rH/@8$5$;$k!#(B ARG $B$O(B `error' $B4X?t$NBh(B
$B#20z?t0J9_$N0z?t$H$7$FEO$5$l$k!#(B"
  (append
   (if arg
       (list 'error (list 'if
			  'skk-japanese-message-and-error
			  japanese
			  english))
     (list 'error "%s" (list 'if
			     'skk-japanese-message-and-error
			     japanese
			     english)))
   arg))

(defmacro skk-yes-or-no-p (japanese english)
  "$B%f!<%6$K(B yes-or-no $B$N<ALd$r$7!"Ez$($,(B yes $B$@$C$?$i(B t $B$rJV$9!#(B
`skk-japanese-message-and-error' $B$,(B non-nil $B$G$"$l$P(B JAPANESE $B$r(B nil $B$G$"$l(B
$B$P(B ENGLISH $B$r%W%m%s%W%H$H$7$F(B `yes-or-no-p' $B$r<B9T$9$k!#(B
`yes-or-no-p' $B$N0z?t$N%W%m%s%W%H$,J#;($KF~$l9~$s$G$$$k>l9g$O$3$N%^%/%m$r;H$&(B
$B$h$j%*%j%8%J%k$N(B `yes-or-no-p' $B$r;HMQ$7$?J}$,%3!<%I$,J#;($K$J$i$J$$>l9g$,$"(B
$B$k!#(B"
 (list 'yes-or-no-p (list 'if 'skk-japanese-message-and-error
				   japanese english)))

(defmacro skk-y-or-n-p (japanese english)
  "$B%f!<%6$K(B \"y or n\" $B$N<ALd$r$7!"Ez$($,(B \"y\" $B$@$C$?$i(B t $B$rJV$9!#(B
`skk-japanese-message-and-error' $B$,(B non-nil $B$G$"$l$P(B JAPANESE $B$r(B nil $B$G$"$l(B
$B$P(B ENGLISH $B$r%W%m%s%W%H$H$7$F(B `y-or-n-p' $B$r<B9T$9$k!#(B"
  (list 'y-or-n-p (list 'if 'skk-japanese-message-and-error
				japanese english)))

(defmacro skk-set-marker (marker position &optional buffer)
  "$B%^!<%+(B MARKER $B$r(B BUFFER $B$N(B POSITION $B$K0\F0$9$k!#(B
BUFFER $B$N%G%#%U%)%k%HCM$O%+%l%s%H%P%C%U%!$G$"$k!#(B
MARKER $B$,(B nil $B$@$C$?$i!"?75,%^!<%+!<$r:n$C$FBeF~$9$k!#(B"
  (list 'progn
	(list 'if (list 'not marker)
	      (list 'setq marker (list 'make-marker)))
	(list 'set-marker marker position buffer)))

(defmacro skk-with-point-move (&rest form)
  "$B%]%$%s%H$r0\F0$9$k$,%U%C%/$r<B9T$7$F$[$7$/$J$$>l9g$K;H$&!#(B"
  `(unwind-protect
       (progn
	 ,@form)
     (setq skk-previous-point (point))))

(def-edebug-spec skk-with-point-move t)

(defmacro skk-face-on (object start end face &optional priority)
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    `(let ((inhibit-quit t))
       (if (not (extentp ,object))
	   (progn
	     (setq ,object (make-extent ,start ,end))
	     (if (not ,priority)
		 (set-extent-face ,object ,face)
	       (set-extent-properties
		,object (list 'face ,face 'priority ,priority))))
	 (set-extent-endpoints ,object ,start ,end))))
   (t
    `(let ((inhibit-quit t))
       (if (not (overlayp ,object))
	   (progn
	     (setq ,object (make-overlay ,start ,end))
	     (when ,priority
	       (overlay-put ,object 'priority ,priority))
	       (overlay-put ,object 'face ,face)
	       ;;(overlay-put (, object) 'evaporate t)
	       )
	 (move-overlay ,object ,start ,end))))))

(defmacro skk-cannot-be-undone (&rest body)
  `(let ((buffer-undo-list t)
	 ;;buffer-read-only
	 (modified (buffer-modified-p)))
     (unwind-protect
	 (progn
	   ,@body)
       (set-buffer-modified-p modified))))

;;;###autoload
(put 'skk-loop-for-buffers 'lisp-indent-function 1)
(defmacro skk-loop-for-buffers (buffers &rest body)
  "BUFFERS $B$,;XDj$9$k3F%P%C%U%!$K0\F0$7$F(B BODY $B$r<B9T$9$k!#(B"
  `(save-current-buffer
     (dolist (buf ,buffers)
       (when (buffer-live-p buf)
	 (set-buffer buf)
	 ,@body))))

;;; functions.
;; version dependent

;; From XEmacs 21.5.
(defun-maybe propertize (string &rest properties)
  "Return a copy of STRING with text properties added.
First argument is the string to copy.
Remaining arguments form a sequence of PROPERTY VALUE pairs for text
properties to add to the result."
  (let ((str (copy-sequence string)))
    (add-text-properties 0 (length str)
			 properties
			 str)
    str))

(defun-maybe substring-no-properties (string &optional from to)
  "Return a substring of string, without text properties.
It starts at index from and ending before to.
to may be nil or omitted; then the substring runs to the end of string.
If from is nil or omitted, the substring starts at the beginning of string.
If from or to is negative, it counts from the end.

With one argument, just copy string without its properties."
  (let ((substr (copy-sequence (substring string (or from 0) to))))
    (set-text-properties 0 (length substr) nil substr)
    substr))

;; From GNU Emacs 22.1.
(defun-maybe replace-regexp-in-string (regexp rep string &optional
					      fixedcase literal subexp start)
  "Replace all matches for REGEXP with REP in STRING.

Return a new string containing the replacements.

Optional arguments FIXEDCASE, LITERAL and SUBEXP are like the
arguments with the same names of function `replace-match'.  If START
is non-nil, start replacements at that index in STRING.

REP is either a string used as the NEWTEXT arg of `replace-match' or a
function.  If it is a function, it is called with the actual text of each
match, and its value is used as the replacement text.  When REP is called,
the match-data are the result of matching REGEXP against a substring
of STRING.

To replace only the first match (if any), make REGEXP match up to \\'
and replace a sub-expression, e.g.
  (replace-regexp-in-string \"\\\\(foo\\\\).*\\\\'\" \"bar\" \" foo foo\" nil nil 1)
    => \" bar foo\"
"

  ;; To avoid excessive consing from multiple matches in long strings,
  ;; don't just call `replace-match' continually.  Walk down the
  ;; string looking for matches of REGEXP and building up a (reversed)
  ;; list MATCHES.  This comprises segments of STRING which weren't
  ;; matched interspersed with replacements for segments that were.
  ;; [For a `large' number of replacements it's more efficient to
  ;; operate in a temporary buffer; we can't tell from the function's
  ;; args whether to choose the buffer-based implementation, though it
  ;; might be reasonable to do so for long enough STRING.]
  (let ((l (length string))
	(start (or start 0))
	matches str mb me)
    (save-match-data
      (while (and (< start l) (string-match regexp string start))
	(setq mb (match-beginning 0)
	      me (match-end 0))
	;; If we matched the empty string, make sure we advance by one char
	(when (= me mb) (setq me (min l (1+ mb))))
	;; Generate a replacement for the matched substring.
	;; Operate only on the substring to minimize string consing.
	;; Set up match data for the substring for replacement;
	;; presumably this is likely to be faster than munging the
	;; match data directly in Lisp.
	(string-match regexp (setq str (substring string mb me)))
	(setq matches
	      (cons (replace-match (if (stringp rep)
				       rep
				     (funcall rep (match-string 0 str)))
				   fixedcase literal str subexp)
		    (cons (substring string start mb)       ; unmatched prefix
			  matches)))
	(setq start me))
      ;; Reconstruct a string from the pieces.
      (setq matches (cons (substring string start l) matches)) ; leftover
      (apply #'concat (nreverse matches)))))

(static-unless (featurep 'xemacs)
  (fmakunbound 'next-command-event))

;; For GNU Emacs.
(defun-maybe next-command-event (&optional event prompt)
  "Read an event object from the input stream.
If EVENT is non-nil, it should be an event object and will be filled
in and returned; otherwise a new event object will be created and
returned.
If PROMPT is non-nil, it should be a string and will be displayed in
the echo area while this function is waiting for an event."
  (read-event prompt))

;; For GNU Emacs 20.7.
(defalias-maybe 'plist-member 'widget-plist-member)

(defsubst skk-sit-for (seconds &optional nodisplay)
  "`sit-for' $B$N(B Emacsen $B$K$h$k0c$$$r5[<}$9$k!#(B"
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    (sit-for seconds nodisplay))
   ((< emacs-major-version 22)
    (sit-for seconds nil nodisplay))
   (t
    (sit-for seconds nodisplay))))

(defsubst skk-ding (&optional arg sound device)
  "`ding' $B$N(B Emacsen $B$K$h$k0c$$$r5[<}$9$k!#(B"
  (static-cond
   ((eq skk-emacs-type 'xemacs)
     (ding arg sound device))
   (t
    (ding arg))))

(defsubst skk-color-display-p ()
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    (eq (device-class (selected-device)) 'color))
   ((fboundp 'x-display-color-p)
    ;; FSF Emacs on X Window System.
    (and window-system (x-display-color-p)))))

(defsubst skk-char-to-string (char)
  (ignore-errors
    (char-to-string char)))

(defsubst skk-ascii-char-p (char)
  (eq (char-charset char) 'ascii))

(defsubst skk-jisx0208-p (char)
  (eq (char-charset char) 'japanese-jisx0208))

(defsubst skk-jisx0213-p (char)
  (and (featurep 'jisx0213)
       (memq (char-charset char)
	     '(japanese-jisx0213-1 japanese-jisx0213-2))))

(defsubst skk-char-octet (ch &optional n)
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    (or (nth (if n (1+ n) 1) (split-char ch))
	0))
   (t
    ;; FSF Emacs.
    (char-octet ch n))))

;; this one is called once in skk-kcode.el, too.
(defsubst skk-charsetp (object)
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    (find-charset object))
   (t
    ;; FSF Emacs 20 or later.
    (charsetp object))))

(defun skk-indicator-to-string (indicator &optional no-properties)
  "SKK $B%$%s%8%1!<%?7?%*%V%8%'%/%H(B INDICATOR $B$rJ8;zNs$KJQ49$9$k!#(B"
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    (if (stringp indicator)
	indicator
      (cdr indicator)))
   ((eq skk-emacs-type 'mule5)
    (if no-properties
	(with-temp-buffer
	  (insert indicator)
	  (buffer-substring-no-properties (point-min) (point-max)))
      indicator))
   (t
    indicator)))

(defun skk-mode-string-to-indicator (mode string)
  "$BJ8;zNs(B STRING $B$r(B SKK $B%$%s%8%1!<%?7?%*%V%8%'%/%H$KJQ49$9$k!#(B"
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    (cons (cdr (assq mode skk-xemacs-extent-alist))
	  string))
   ((memq skk-emacs-type '(mule5))
    (if (and window-system
	     (not (eq mode 'default)))
	(apply 'propertize string
	       (cdr (assq mode skk-e21-property-alist)))
      string))
   (t
    string)))

(defsubst skk-local-variable-p (variable &optional buffer afterset)
  "Non-nil if VARIABLE has a local binding in buffer BUFFER.
BUFFER defaults to the current buffer."
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    (local-variable-p variable (or buffer (current-buffer)) afterset))
   (t
    (local-variable-p variable (or buffer (current-buffer))))))

(defsubst skk-face-proportional-p (face)
  (static-cond
   ((eq skk-emacs-type 'xemacs)
    (face-proportional-p face))
   ((eq skk-emacs-type 'mule5)
    (or (face-equal face 'variable-pitch)
	(eq (face-attribute face :inherit) 'variable-pitch)))))

(defun skk-event-key (event)
  "$B%$%Y%s%H(B EVENT $B$rH/@8$7$?F~NO$N>pJs$r<hF@$9$k!#(B"
  (static-cond
   ((eq skk-emacs-type 'xemacs)
;    (let ((tmp (event-key event)))
;      (if (symbolp tmp)
;	  (vector tmp)
;	event)))
    (let ((char (event-to-character event t t t)))
      (if (characterp char)
	  char
	(event-key event))))
   (t
    (let ((char (event-to-character event))
	  keys)
      (if char
	  (vector char)
	(setq keys (recent-keys))
	(vector (aref keys (1- (length keys)))))))))

;;; version independent
(defsubst skk-cursor-set (&optional color force)
  (when (or skk-use-color-cursor
	    force)
    (skk-cursor-set-1 color)))

(defsubst skk-cursor-off ()
  (when skk-use-color-cursor
    (skk-cursor-off-1)))

(defsubst skk-modify-indicator-alist (mode string)
  (setcdr (assq mode skk-indicator-alist)
	  (cons string (skk-mode-string-to-indicator mode string))))

(defun skk-update-modeline (&optional mode string)
  (unless mode
    (setq mode 'default))
  ;;
  (when string
    (skk-modify-indicator-alist mode string))
  ;;
  (let ((indicator (cdr (assq mode skk-indicator-alist))))
    (setq skk-modeline-input-mode
	  (if (eq skk-status-indicator 'left)
	      (cdr indicator)
	    (car indicator)))
    (force-mode-line-update)))

;; $B%D%j!<$K%"%/%;%9$9$k$?$a$N%$%s%?!<%U%'!<%9(B
(defsubst skk-make-rule-tree (char prefix nextstate kana branch-list)
  (list char
	prefix
	(if (string= nextstate "")
	    nil
	  nextstate)
	kana
	branch-list))

;;(defsubst skk-get-char (tree)
;;  (car tree))
;;
;; skk-current-rule-tree $B$KBP$7$FGK2uE*$JA`:n$O9T$J$($J$$!#(Bskk-rule-tree $B$N(B
;; $BFbMF$^$GJQ$o$C$F$7$^$$!"(Bskk-current-rule-tree $B$N(B initialize $B$,<j7Z$K9T$J(B
;; $B$($J$/$J$k!#$3$3$,2r7h$G$-$l$P(B skk-prefix $B$rA4LG$G$-$k$N$K(B...$B!#(B
;;(defsubst skk-set-char (tree char)
;;  (setcar tree char))
;;
;;(defsubst skk-set-prefix (tree prefix)
;;  (setcar (cdr tree) prefix))

(defsubst skk-get-prefix (tree)
  (nth 1 tree))

(defsubst skk-get-nextstate (tree)
  (nth 2 tree))

(defsubst skk-set-nextstate (tree nextstate)
  (when (string= nextstate "")
    (setq nextstate nil))
  (setcar (nthcdr 2 tree) nextstate))

(defsubst skk-get-kana (tree)
  (nth 3 tree))

(defsubst skk-set-kana (tree kana)
  (setcar (nthcdr 3 tree) kana))

(defsubst skk-get-branch-list (tree)
  (nth 4 tree))

(defsubst skk-set-branch-list (tree branch-list)
  (setcar (nthcdr 4 tree) branch-list))

;; tree procedure for skk-kana-input.
(defsubst skk-add-branch (tree branch)
  (skk-set-branch-list tree (cons branch (skk-get-branch-list tree))))

(defsubst skk-select-branch (tree char)
  (assq char (skk-get-branch-list tree)))

(defun skk-erase-prefix (&optional clean)
  "`skk-echo' $B$,Hs(B nil $B$G$"$l$P8=:_I=<($5$l$F$$$k(B `skk-prefix' $B$r>C$9!#(B
$B%*%W%7%g%s0z?t$N(B CLEAN $B$,;XDj$5$l$k$H!"JQ?t$H$7$F$N(B `skk-prefix' $B$r6uJ8;z$K!"(B
`skk-current-rule-tree' $B$r(B nil $B$K=i4|2=$9$k!#(B"
  ;; $B$+$JJ8;z$NF~NO$,$^$@40@.$7$F$$$J$$>l9g$K$3$N4X?t$,8F$P$l$?$H$-$J$I$O(B
  ;; $BI=<($5$l$F$$$k(B skk-prefix $B$O:o=|$7$?$$$,!"JQ?t$H$7$F$N(B skk-prefix $B$O(B
  ;; null $BJ8;z$K$7$?$/$J$$!#(B
  (when (overlayp skk-prefix-overlay)
	(condition-case nil
	    (delete-overlay skk-prefix-overlay)
	  (error
	   (skk-set-marker skk-kana-start-point nil)
	   (setq skk-prefix ""
		 skk-current-rule-tree nil))))
  (when clean
    (setq skk-prefix ""
	  skk-current-rule-tree nil)) ; fail safe
  (static-when (eq skk-emacs-type 'mule4)
    (redraw-frame (selected-frame))))

(defun skk-kana-cleanup (&optional force)
  (let ((data (cond
	       ((and skk-current-rule-tree
		     (null (skk-get-nextstate skk-current-rule-tree)))
		(skk-get-kana skk-current-rule-tree))
	       (skk-kana-input-search-function
		(car (funcall skk-kana-input-search-function)))))
	kana)
    (when (or force data)
      (skk-erase-prefix 'clean)
      (setq kana (if (functionp data)
		     (funcall data nil)
		   data))
      (when (consp kana)
	(setq kana (if skk-katakana
		       (car kana)
		     (cdr kana))))
      (when (stringp kana)
	(skk-insert-str kana))
      (skk-set-marker skk-kana-start-point nil)
      (or data t)))) ; skk-prefix $B$KBP1~$9$k%G!<%?$,$"$C$?$J$i$=$l$rJV$9(B

(defsubst skk-numeric-p ()
  (and skk-use-numeric-conversion
       (require 'skk-num)
       skk-num-list))

(defsubst skk-file-exists-and-writable-p (file)
  (and (setq file (expand-file-name file))
       (file-exists-p file)
       (file-writable-p file)))

(defsubst skk-share-private-jisyo-p ()
  (vectorp skk-jisyo-update-vector))

(defsubst skk-lower-case-p (char)
  "CHAR $B$,>.J8;z$N%"%k%U%!%Y%C%H$G$"$l$P!"(Bt $B$rJV$9!#(B"
  (and (<= ?a char)
       (>= ?z char)))

(defsubst skk-downcase (char)
  (or (cdr (assq char skk-downcase-alist))
      (downcase char)))

(defun skk-mode-off ()
  (setq skk-mode nil
	skk-abbrev-mode nil
	skk-latin-mode nil
	skk-j-mode nil
	skk-jisx0208-latin-mode nil
	skk-jisx0201-mode nil
	;; sub mode of skk-j-mode.
	skk-katakana nil)
  ;; initialize
  (skk-update-modeline)
  (skk-cursor-off)
  (skk-remove-skk-pre-command))

(defun skk-j-mode-on (&optional katakana)
  (setq skk-mode t
	skk-abbrev-mode nil
	skk-latin-mode nil
	skk-j-mode t
	skk-jisx0208-latin-mode nil
	skk-jisx0201-mode nil
	;; sub mode of skk-j-mode.
	skk-katakana katakana)
  (skk-setup-keymap)
  (skk-update-modeline (if skk-katakana
			   'katakana
			 'hiragana))
  (skk-cursor-set))

(defun skk-latin-mode-on ()
  (setq skk-mode t
	skk-abbrev-mode nil
	skk-latin-mode t
	skk-j-mode nil
	skk-jisx0208-latin-mode nil
	skk-jisx0201-mode nil
	;; sub mode of skk-j-mode.
	skk-katakana nil)
  (skk-setup-keymap)
  (skk-update-modeline 'latin)
  (skk-cursor-set))

(defun skk-jisx0208-latin-mode-on ()
  (setq skk-mode t
	skk-abbrev-mode nil
	skk-latin-mode nil
	skk-j-mode nil
	skk-jisx0208-latin-mode t
	skk-jisx0201-mode nil
	;; sub mode of skk-j-mode.
	skk-katakana nil)
  (skk-setup-keymap)
  (skk-update-modeline 'jisx0208-latin)
  (skk-cursor-set))

(defun skk-abbrev-mode-on ()
  (setq skk-mode t
	skk-abbrev-mode t
	skk-latin-mode nil
	skk-j-mode nil
	skk-jisx0208-latin-mode nil
	skk-jisx0201-mode nil
	;; skk-abbrev-mode $B$O0l;~E*$J(B ascii $BJ8;z$K$h$kJQ49$J$N$G!"JQ498e$O85$N(B
	;; $BF~NO%b!<%I(B ($B$+$J%b!<%I$+%+%J%b!<%I(B) $B$KLa$k$3$H$,4|BT$5$l$k!#(B
	;; skk-katakana $B$O(B minor-mode $B%U%i%0$G$O$J$/!"(Bskk-j-mode $B%^%$%J!<%b!<%I(B
	;; $B$NCf$G$3$N%U%i%0$K$h$jF~NOJ8;z$r7hDj$9$k%]%$%s%?$rJQ99$9$k$@$1$J$N$G(B
	;; skk-abbrev-mode $B%^%$%J!<%b!<%I2=$9$k$N$K(B skk-katakana $B%U%i%0$r=i4|2=(B
	;; $B$7$J$1$l$P$J$i$J$$I,A3@-$O$J$$!#(B
	;; sub mode of skk-j-mode.
	;;skk-katakana nil
	)
  (skk-setup-keymap)
  (skk-update-modeline 'abbrev)
  (skk-cursor-set))

(defsubst skk-in-minibuffer-p ()
  "$B%+%l%s%H%P%C%U%!$,%_%K%P%C%U%!$+$I$&$+$r%A%'%C%/$9$k!#(B"
  (eq (current-buffer) (window-buffer (minibuffer-window))))

(defun skk-window-body-height ()
  (static-if (fboundp 'window-body-height) ; emacs21 $B$K$O$J$$(B
      (window-body-height)
    (- (window-height)
       (if mode-line-format 1 0)
       (static-cond ((not (boundp 'header-line-format)) 0) ; emacs20 $B$K$O$J$$(B
		    (t (if header-line-format 1 0))))))

(defun skk-screen-column ()
  (- (current-column)
     (save-excursion
       (vertical-motion 0)
       (current-column))))

(defun skk-move-to-screen-column (col)
  (move-to-column (+ (current-column)
		     (- col (skk-screen-column))))
  (skk-screen-column))

(defun skk-insert-prefix (&optional char)
  "`skk-echo' $B$,(B non-nil $B$G$"$l$P%+%l%s%H%P%C%U%!$K(B `skk-prefix' $B$rA^F~$9$k!#(B"
  (when skk-echo
    ;; skk-prefix $B$O%"%s%I%%$NBP>]$H$J$i$J$$$N$G(B
    ;; $B%P%C%U%!$KA^F~$5$l$kI,MW$,$J$$!#(B
    (setq skk-prefix-overlay (make-overlay (point) (point)))
    (let ((prefix (or char skk-prefix)))
      (when (and skk-use-face (not skk-henkan-mode))
	(setq prefix
	      (propertize prefix 'face
			  (cond ((and skk-j-mode (not skk-katakana))
				 'skk-prefix-hiragana-face)
				(skk-katakana
				 'skk-prefix-katakana-face)
				(skk-jisx0201-mode
				 'skk-prefix-jisx0201-face)))))
      (overlay-put skk-prefix-overlay 'after-string prefix)
      (static-when (eq skk-emacs-type 'mule4)
	(redraw-frame (selected-frame))))))

(defsubst skk-string-lessp-in-coding-system (str1 str2 coding-system)
  (string< (encode-coding-string str1 coding-system)
	   (encode-coding-string str2 coding-system)))

(defsubst skk-string< (str1 str2)
  "STR1 $B$H(B STR2 $B$H$rHf3S$9$k!#(B
$BFbIt%3!<%I$,(B emacs-mule $B$G$J$$$J$I(B `stringp' $B$NJV$jCM$,0[$J$k(B Emacs $B$K(B
$BBP$7$F(B emacs-mule $B$N(B encoded string $B$KJQ49$7$FHf3S$9$k!#(B
$BHf3S$N7k2L(B str1 < str2 $B$J$i$P(B t $B$rJV$9!#(B"
  (static-cond
   ((and (string-match "^GNU" (emacs-version))
	 (string< "6.0" mule-version))
    ;; Emacs with coding system utf-8-emacs
    (skk-string-lessp-in-coding-system str1 str2 'emacs-mule))
   (t
    (string< str1 str2))))

(defsubst skk-string<= (str1 str2)
  "STR1 $B$H(B STR2 $B$H$rHf3S$7$F!"(Bstring< $B$+(B string= $B$G$"$l$P!"(Bt $B$rJV$9!#(B"
  (or (skk-string< str1 str2)
      (string= str1 str2)))

(defsubst skk-do-auto-fill ()
  "`auto-fill-function' $B$KCM$,BeF~$5$l$F$$$l$P!"$=$l$r%3!<%k$9$k!#(B"
  (when auto-fill-function
    (funcall auto-fill-function)))

(defsubst skk-current-input-mode ()
  (cond (skk-abbrev-mode 'abbrev)
	(skk-latin-mode 'latin)
	(skk-jisx0208-latin-mode 'jisx0208-latin)
	(skk-katakana 'katakana)
	(skk-j-mode 'hiragana)))

;;(defsubst skk-substring-head-character (string)
;;  (char-to-string (string-to-char string)))

(defsubst skk-get-current-candidate-1 (&optional count)
  (setq count (or count (skk-henkan-count)))
  (when (> 0 count)
    (skk-error "$B8uJd$r<h$j=P$9$3$H$,$G$-$^$;$s(B"
	       "Cannot get current candidate"))
  ;; (nth -1 '(A B C)) $B$O!"(BA $B$rJV$9$N$G!"Ii$G$J$$$+$I$&$+%A%'%C%/$9$k!#(B
  (nth count skk-henkan-list))

;; convert skk-rom-kana-rule-list to skk-rule-tree.
;; The rule tree follows the following syntax:
;; <branch-list>    ::= nil | (<tree> . <branch-list>)
;; <tree>         ::= (<char> <prefix> <nextstate> <kana> <branch-list>)
;; <kana>         ::= (<$B$R$i$,$JJ8;zNs(B> . <$B%+%?%+%JJ8;zNs(B>) | nil
;; <char>         ::= <$B1Q>.J8;z(B>
;; <nextstate>    ::= <$B1Q>.J8;zJ8;zNs(B> | nil

(defsubst skk-make-raw-arg (arg)
  (cond ((= arg 1) nil)
	((= arg -1) '-)
	((numberp arg) (list arg))))

(defsubst skk-unread-event (event)
  "Unread single EVENT."
  (setq unread-command-events
	(nconc unread-command-events (list event))))

(defsubst skk-get-last-henkan-datum (key)
  (cdr (assq key skk-last-henkan-data)))

(defsubst skk-put-last-henkan-datum (key val)
  (let ((e (assq key skk-last-henkan-data)))
    (if e
	(setcdr e val)
      (push (cons key val) skk-last-henkan-data))))

(defun skk-put-last-henkan-data (alist)
  (let (e)
    (dolist (kv alist)
      (if (setq e (assq (car kv) skk-last-henkan-data))
	  (setcdr e (cdr kv))
	(push (cons (car kv) (cdr kv))
	      skk-last-henkan-data)))))

(defun skk-find-coding-system (code)
  (cond ((and code
	      (or (and (fboundp 'coding-system-p)
		       (coding-system-p code))
		  (and (fboundp 'find-coding-system)
		       (symbolp code)
		       (find-coding-system code))))
	 code)
	((and code (stringp code))
	 (cdr (assoc code skk-coding-system-alist)))
	(t
	 (cdr (assoc "euc" skk-coding-system-alist)))))

(defsubst skk-lisp-prog-p (string)
  "STRING $B$,(B Lisp $B%W%m%0%i%`$G$"$l$P!"(Bt $B$rJV$9!#(B"
  (let ((l (length string)))
    (and (> l 2)
	 (eq (aref string 0) ?\()
	 ;; second character is ascii or not.
	 (skk-ascii-char-p (aref string 1))
	 (eq (aref string (1- l)) ?\))      ; $B$3$N9T!"$b$&ITMW$+$b(B
	 (ignore-errors
	   (= l (cdr (read-from-string string)))))))

(defun skk-eval-string (string)
  "Eval STRING as a lisp program and return the result."
  (cond ((string-match ";" string)
	 (concat (skk-eval-string (substring string 0 (match-beginning 0)))
		 (substring string (match-beginning 0) (match-end 0))
		 (skk-eval-string (substring string (match-end 0)))))
	((skk-lisp-prog-p string)
	 (let (func face)
	   ;; (^_^;) $B$N$h$&$JJ8;zNs$KBP$7!"(Bread-from-string $B$r8F$V$H(B
	   ;; $B%(%i!<$K$J$k$N$G!"(Bignore-errors $B$G0O$`!#(B
	   (ignore-errors
	     (setq func (car (read-from-string string)))
	     (when (and (listp func)
			(functionp (car func)))
	       (setq face (get-text-property 0 'face string))
	       (setq string (if face
				(propertize (format "%s" (eval func))
					    'face face)
			      (format "%s" (eval func))))))
	   string))
	(t
	 string)))

;;;; from dabbrev.el.  Welcome!
;; $BH=Dj4V0c$$$rHH$9>l9g$"$j!#MW2~NI!#(B
(defsubst skk-minibuffer-origin ()
  (nth 1 (buffer-list)))

(defun skk-quote-char-1 (word alist)
  (mapconcat
   #'(lambda (char)
       (or (cdr (assq char alist))
	   (char-to-string char)))
   ;; $BJ8;zNs$rBP1~$9$k(B char $B$N%j%9%H$KJ,2r$9$k!#(B
   (append word nil) ""))

(defun skk-key-binding-member (key commands &optional map)
  "$BF~NO(B KEY $B$,H/F0$9$k%3%^%s%I$,!"(BCOMMANDS $B$K4^$^$l$l$P(B $BHs(B nil $B$rJV$9!#(B
MAP $B$OF~NO$,=q$+$l$F$$$k%-!<%^%C%W$r;XDj$9$k$,!";XDj$5$l$J$1$l$P(B
`skk-j-mode-map' $B$r;2>H$9$k!#(B
$B$3$N4X?t$O!"F~NO(B KEY $B$,(B `lookup-key' $B$GC5$;$J$$7A<0$G$"$j$&$k>l9g$KMQ$$$k!#(B"
  (let (keys)
    (unless map
      (setq map skk-j-mode-map))
    (dolist (command commands)
      (setq keys (nconc keys
			(where-is-internal command map))))
    (member (key-description key)
	    (mapcar #'(lambda (k)
			(key-description k))
		    keys))))

(require 'product)
(product-provide
    (provide 'skk-macs)
  (require 'skk-version))

;;; skk-macs.el ends here
