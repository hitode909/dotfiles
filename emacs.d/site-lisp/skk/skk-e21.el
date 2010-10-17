;;; skk-e21.el --- GNU Emacs 21 support for SKK -*- coding: iso-2022-jp -*-

;; Copyright (C) 1999-2007 SKK Development Team <skk@ring.gr.jp>

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

;;; Code:

(eval-when-compile
  (require 'cl)
  (require 'static)
  (require 'tooltip)

  (defvar tool-bar-border)

  (when (= emacs-major-version 21)
    (defalias 'window-inside-pixel-edges 'ignore)
    (defalias 'posn-at-point 'ignore)))

(eval-and-compile
  (autoload 'mouse-avoidance-banish-destination "avoid")
  (autoload 'mouse-avoidance-point-position "avoid")
  (autoload 'mouse-avoidance-set-mouse-position "avoid")
  (autoload 'Info-goto-node "info")
  (autoload 'browse-url "browse-url"))

;; Variables.
(defvar skk-e21-modeline-menu-items
  (when window-system
    '("Daredevil SKK Menu"
      ["Hiragana"
       (skk-j-mode-on)
       :selected (and skk-j-mode (not skk-katakana))
       :style radio
       :keys nil
       :key-sequence nil]
      ["Katakana"
       (skk-j-mode-on t)
       :selected (and skk-j-mode skk-katakana)
       :style radio
       :keys nil
       :key-sequence nil]
      ["Hankaku alphabet"
       skk-latin-mode
       :selected skk-latin-mode
       :style radio
       :keys nil
       :key-sequence nil]
      ["Zenkaku alphabet"
       skk-jisx0208-latin-mode
       :selected skk-jisx0208-latin-mode
       :style radio
       :keys nil
       :key-sequence nil]
      "--"
      ["Read Manual" skk-e21-info t]
      ["Start Tutorial" skk-tutorial t]
      ["Customize SKK" skk-customize-group-skk t]
      ["Customize SKK (simple)" skk-customize t]
      ["Send a Bug Report"
       (let (skk-japanese-message-and-error)
	 (skk-submit-bug-report)) t]
      "--"
      ["About Daredevil SKK.." skk-version t]
      ["Visit Daredevil Web Site" skk-e21-visit-openlab t])))

(defvar skk-e21-menu-resource-ja
  '(("Daredevil SKK Menu" . "Daredevil SKK $B%a%K%e!<(B")
    ("Convert Region and Echo" . "$BNN0h$rJQ49$7$F%_%K%P%C%U%!$KI=<((B")
    ("Gyakubiki" . "$B5U0z$-(B")
    ("to Hiragana" . "$B$R$i$,$J$KJQ49(B")
    ("to Hiragana, All Candidates" . "$B$R$i$,$J$KJQ49!"A4$F$N8uJd$rI=<((B")
    ("to Katakana" . "$B%+%?%+%J$KJQ49(B")
    ("to Katakana, All Candidates" . "$B%+%?%+%J$KJQ49!"A4$F$N8uJd$rI=<((B")
    ("Hurigana" . "$B$U$j$,$J(B")
    ("Convert Region and Replace" . "$BNN0h$rJQ49$7$FCV$-49$($k(B")
    ("Ascii" . "$BA43Q1Q?t$r(B ASCII $B$KJQ49(B")
    ("Hiragana" . "$B$R$i$,$J(B")
    ("Katakana" . "$B%+%?%+%J(B")
    ("Romaji" . "$B%m!<%^;z$KJQ49(B")
    ("Zenkaku" . "ASCII $B$rA43Q1Q?t$KJQ49(B")
    ("Count Jisyo Candidates" . "$B<-=qCf$N8uJd?t$r?t$($k(B")
    ("Save Jisyo" . "$B<-=q$rJ]B8$9$k(B")
    ("Undo Kakutei" . "$B3NDj$r<h$j>C$9(B ($B%"%s%I%%!<(B)")
    ("Version" . "SKK $B$N%P!<%8%g%s(B")
    ("Daredevil SKK Menu" . "Daredevil SKK $B%a%K%e!<(B")
    ("Hankaku alphabet" . "$BH>3Q1Q?t(B")
    ("Zenkaku alphabet" . "$BA43Q1Q?t(B")
    ("Read Manual" . "$B%^%K%e%"%k$rFI$`(B")
    ("Start Tutorial" . "$B%A%e!<%H%j%"%k(B")
    ("Customize SKK" . "SKK $B$r%+%9%?%^%$%:(B")
    ("Customize SKK (simple)" . "SKK $B$r%+%9%?%^%$%:(B ($B4J0WHG(B)")
    ("Send a Bug Report" . "$B%P%0$rJs9p$9$k(B")
    ("About Daredevil SKK.." . "Daredevil SKK $B$K$D$$$F(B..")
    ("Visit Daredevil Web Site" . "Daredevil SKK $B$N%5%$%H$X(B")))

(defvar skk-e21-modeline-property
  (when window-system
    (list 'local-map (let ((map (make-sparse-keymap)))
		       (define-key map [mode-line mouse-3]
			 #'skk-e21-modeline-menu)
		       (define-key map [mode-line mouse-1]
			 #'skk-e21-circulate-modes)
		       map)
	  'help-echo
	  "mouse-1: $B%b!<%I@ZBX(B($B=[4D(B), mouse-3: SKK $B%a%K%e!<(B"
	  'mouse-face
	  'highlight)))

(defvar skk-e21-property-alist
  (when window-system
    (list
     (cons 'latin skk-e21-modeline-property))))

(defvar skk-e21-modeline-menu nil)

;; Functions.

;;;###autoload
(defun skk-e21-prepare-menu ()
  (unless skk-e21-modeline-menu
    (setq skk-e21-modeline-menu
	  (easy-menu-create-menu (car skk-e21-modeline-menu-items)
				 (cdr skk-e21-modeline-menu-items))))
  ;;
  (unless (or (null window-system)
	      (eq window-system 'w32)
	      (boundp 'mac-carbon-version-string)
	      (and (eq window-system 'x)
		   (>= emacs-major-version 22)
		   (boundp 'gtk-version-string)
		   (stringp (symbol-value 'gtk-version-string))
		   (string< "2.0" gtk-version-string)))
    (setq skk-show-japanese-menu nil))
  ;;
  (when skk-show-japanese-menu
    (skk-e21-menu-replace skk-e21-modeline-menu)
    (dolist (map (list skk-j-mode-map skk-latin-mode-map
		       skk-jisx0208-latin-mode-map skk-abbrev-mode-map))
      (skk-e21-menu-replace (or (assq 'skk (assq 'menu-bar map))
				(assq 'SKK (assq 'menu-bar map)))))))

(defun skk-e21-modeline-menu ()
  (interactive)
  ;; Find keys
  (aset (nth 1 skk-e21-modeline-menu-items)
	7
	(cond (skk-katakana
	       (skk-e21-find-func-keys 'skk-toggle-kana))
	      ((not skk-mode)
	       (skk-e21-find-func-keys 'skk-mode))
	      ((not skk-j-mode)
	       (skk-e21-find-func-keys 'skk-kakutei))
	      (t
	       nil)))
  (aset (nth 2 skk-e21-modeline-menu-items)
	7
	(if (and skk-j-mode
		 (not skk-katakana))
	    (skk-e21-find-func-keys 'skk-toggle-kana)
	  nil))
  (aset (nth 3 skk-e21-modeline-menu-items)
	7
	(if skk-j-mode
	    (skk-e21-find-func-keys 'skk-latin-mode)
	  nil))
  (aset (nth 4 skk-e21-modeline-menu-items)
	7
	(if skk-j-mode
	    (skk-e21-find-func-keys 'skk-jisx0208-latin-mode)
	  nil))
  ;;
  (let ((easy-menu-converted-items-table
	 (make-hash-table :test 'equal)))
    (popup-menu skk-e21-modeline-menu)))

(defun skk-e21-circulate-modes (&optional arg)
  (interactive "P")
  (cond
   (skk-henkan-mode
    nil)
   ((not skk-mode)
    (skk-mode arg))
   (skk-j-mode
    (if skk-katakana
	(skk-jisx0208-latin-mode arg)
      (skk-toggle-kana arg)))
   (skk-jisx0208-latin-mode
    (skk-latin-mode arg))
   (skk-latin-mode
    (skk-j-mode-on))))

(defun skk-e21-info ()
  (interactive)
  (Info-goto-node "(skk)"))

(defun skk-e21-customize ()
  (interactive)
  (customize-group "skk"))

(defun skk-e21-visit-openlab ()
  (interactive)
  (browse-url "http://openlab.ring.gr.jp/skk/index-j.html"))

;;;###autoload
(defun skk-e21-prepare-modeline-properties ()
  (setq skk-icon
	(let* ((dir (ignore-errors
		      (file-name-directory
		       (static-if (fboundp 'locate-file)
			   ;; Emacs 22.1 or later
			   (or (locate-file "skk/skk.xpm"
					    (list (expand-file-name
						   "../../.."
						   data-directory)))
			       (locate-file "skk/skk.xpm"
					    (list data-directory)))
			 ;; Emacs 21
			 skk-tut-file))))
	       (image (when dir
			(find-image
			 `((:type xpm
				  :file ,(expand-file-name "skk.xpm" dir)
				  :ascent center)))))
	       (string "dummy"))
	  (if (and skk-show-icon window-system image)
	      (apply 'propertize string
		     (cons 'display (cons image skk-e21-modeline-property)))
	    nil)))
  ;;
  (unless skk-use-color-cursor
    (setq skk-indicator-use-cursor-color nil))
  ;;
  (when window-system
    (let (face)
      (dolist (mode '(hiragana katakana jisx0208-latin jisx0201 abbrev))
	(setq face (intern (format "skk-e21-%s-face" mode)))
	(unless (facep face)
	  (make-face face)
	  (when skk-indicator-use-cursor-color
	    (set-face-foreground face
				 (symbol-value
				  (intern
				   (format "skk-cursor-%s-color" mode))))))
	(push (cons mode (append skk-e21-modeline-property
				 (list 'face face)))
	       skk-e21-property-alist)))))

(defun skk-e21-find-func-keys (func)
  (let ((keys
	 (or (do ((spec (nth 4 skk-rule-tree) (cdr spec))
		  (list nil (car spec))
		  (str nil (when (eq (nth 3 list) func)
			     (nth 1 list))))
		 ((or str (null spec))
		  (if (stringp str)
		      str
		    nil)))
	     (car (where-is-internal func skk-j-mode-map)))))
    (if keys
	(format "%s" (key-description keys))
      nil)))

(defun skk-e21-menu-replace (list)
  (let (cons)
    (while (and list (listp list))
      (cond
       ((and (car-safe list)
	     (listp (car list)))
	(skk-e21-menu-replace (car list)))
       ((and (stringp (car-safe list))
	     (setq cons (assoc (car list) skk-e21-menu-resource-ja)))
	(setcar list (cdr cons)))
       ((and (vectorp (car-safe list))
	     (setq cons (assoc (aref (car list) 0) skk-e21-menu-resource-ja)))
	(aset (car list) 0 (cdr cons))))
      (setq list (cdr list)))))

(defun skk-e21-mouse-position ()
  "$B%]%$%s%H$N0LCV$r(B (FRAME X . Y) $B$N7A$GJV$9!#(B
$B$3$l$O(B `mouse-avoidance-point-position' $B$H$[$\F1$8$@$,!"(BSKK $B"'%b!<%I$N$H$-$O(B
$B"'$N%]%$%s%H$rJV$9!#(B"
  (let* ((w (if skk-isearch-switch
		(minibuffer-window)
	      (selected-window)))
	 (edges (window-edges w))
	 (list
	  (compute-motion (max (window-start w) (point-min))   ; start pos
			  ;; window-start can be < point-min if the
			  ;; latter has changed since the last redisplay
			  '(0 . 0)       ; start XY
			  (if (eq skk-henkan-mode 'active)
			      (ignore-errors
				(marker-position skk-henkan-start-point))
			    (point))       ; stop pos
			  (cons (window-width w)
				(window-height w)); stop XY: none
			  (1- (window-width w))       ; width
			  (cons (window-hscroll w) 0)     ; 0 may not be right?
			  w)))
    ;; compute-motion returns (pos HPOS VPOS prevhpos contin)
    ;; we want:               (frame hpos . vpos)
    (cons (selected-frame)
	  (cons (+ (car edges)       (car (cdr list)))
		(+ (car (cdr edges)) (car (cdr (cdr list))))))))

(defun skk-tooltip-resize-text (text)
  (let ((lines 0)
	(max-lines
	 ;; $B2hLL$NH>J,$N9b$5$r4p=`$K:GBg9b$r7h$a$k(B
	 (- (/ (/ (display-pixel-height) 2) (frame-char-height))
	    2))
	(columns 0)
	(current-column nil))
    (with-temp-buffer
      (set-buffer-multibyte t)
      (insert text)
      (goto-char (point-min))
      (while (not (eobp))
	(setq lines (1+ lines))
	(cond ((= lines max-lines)
	       ;; $BD9$9$.$k(B
	       (beginning-of-line)
	       (insert "($BD9$9$.$k$N$G>JN,$5$l$^$7$?(B)")
	       (delete-region (point) (point-max))
	       (goto-char (point-max))
	       (setq text (buffer-string)))
	      (t
	       (end-of-line)
	       (setq current-column (current-column))
	       (when (> current-column columns)
		 (setq columns current-column))
	       (forward-line 1)))))
    ;; (text . (x . y))
    (cons text (cons columns lines))))

(defun skk-tooltip-show-at-point (text &optional situation)
  (require 'tooltip)
  ;; Emacs 21 $B$G$O!"%^%&%9%]%$%s%?Hs0MB8$N0LCV7hDj$,$G$-$J$$(B ($B$H;W$o$l$k(B)
  (when (eq emacs-major-version 21)
    (setq skk-tooltip-mouse-behavior 'follow))
  ;;
  (let* ((P (cdr (skk-e21-mouse-position)))
	 (oP (cdr (mouse-position)))
	 event
	 parameters
	 (avoid-destination (if (memq skk-tooltip-mouse-behavior
				      '(avoid avoid-maybe banish))
				(mouse-avoidance-banish-destination)
			       nil))
	 edges
	 tip-destination
	 fontsize
	 left top
	 tooltip-info tooltip-size
	 text-width text-height
	 screen-width screen-height
	 (inhibit-quit t)
	 (tooltip-use-echo-area nil))
    ;;
    (when (null (car P))
      (unless (memq skk-tooltip-mouse-behavior '(avoid-maybe banish nil))
	(setq oP (cdr (mouse-avoidance-point-position)))))
    ;; Elscreen $B;HMQ;~$O(B Y $B:BI8$,$:$l$k!#$H$j$"$($:(B workaround$B!#(B
    (when (and (featurep 'elscreen)
	       (not (or skk-isearch-switch
			(skk-in-minibuffer-p)))
	       (symbol-value 'elscreen-display-tab))
      (setcdr P (1+ (cdr P))))
    ;;
    (when (eq skk-tooltip-mouse-behavior 'follow)
      (mouse-avoidance-set-mouse-position P))
    ;;
    (when (or (and (memq skk-tooltip-mouse-behavior '(avoid banish))
		   (not (equal (mouse-position) avoid-destination)))
	      (and (eq skk-tooltip-mouse-behavior 'avoid-maybe)
		   (cadr (mouse-position))
		   (not (equal (mouse-position) avoid-destination))))
      (set-mouse-position (selected-frame)
			  (car avoid-destination)
			  ;; XXX pending
			  ;; $B%^%&%9%]%$%s%?$O$I$3$X$$$/$Y$-$+(B
			  ;; (cdr avoid-destination)
			  0))
    ;;
    (unless (eq skk-tooltip-mouse-behavior 'follow)
      ;; $B%^%&%9%]%$%s%?$K0MB8$;$:(B tooptip $B$N0LCV$r7hDj$9$k!#(B
      (setq edges (window-inside-pixel-edges
		   (if skk-isearch-switch
		       (minibuffer-window)
		     (selected-window)))
	    tip-destination (posn-x-y
			     (if skk-isearch-switch
				 (posn-at-point
				  (with-current-buffer
				      (window-buffer (minibuffer-window))
				    (point-min))
				  (minibuffer-window))
			       (posn-at-point (point))))
	    fontsize (frame-char-height)
	    ;; x $B:BI8(B ($B:8$+$i$N(B)
	    left (+ (car tip-destination)
		    (nth 0 edges)
		    (frame-parameter (selected-frame) 'left)
		    skk-tooltip-x-offset)
	    ;; y $B:BI8(B ($B>e$+$i$N(B)
	    ;; $B@5$7$$$+J,$+$i$J$$$,!"%D!<%k%P!<$H%a%K%e!<%P!<$NJ,$b7W;;$9$k(B
	    ;; ($B$?$@$7%&%#%s%I%&%G%3%l!<%?$J$I$N07$$$O4XCN$G$-$J$$!)(B)
	    top  (+ (if (boundp 'tool-bar-images-pixel-height)
			tool-bar-images-pixel-height
		      0)
		    (if (boundp 'tool-bar-button-margin)
			(* 2 tool-bar-button-margin)
		      0)
		    (if (boundp 'tool-bar-button-relief)
			(* 2 tool-bar-button-relief)
		      0)
		    (if (boundp 'tool-bar-border)
			(cond ((integerp tool-bar-border)
			       tool-bar-border)
			      ((symbolp tool-bar-border)
			       (frame-parameter (selected-frame)
						tool-bar-border))
			      (t
			       0))
		      0)
		    (if menu-bar-mode
			(* 1 fontsize)
		      0)
		    (if (and (featurep 'elscreen)
			     (not (or skk-isearch-switch
				      (skk-in-minibuffer-p)))
			     (symbol-value 'elscreen-display-tab))
			(* 1 fontsize)
		      0)
		    ;; magic
		    (* 1 fontsize)
		    ;;
		    (cdr tip-destination)
		    (nth 1 edges)
		    (frame-parameter (selected-frame) 'top)
		    skk-tooltip-y-offset)
	    tooltip-info (skk-tooltip-resize-text text)
	    text (car tooltip-info)
	    tooltip-size (cdr tooltip-info)
	    text-width (* (/ (1+ fontsize) 2) (+ 2 (car tooltip-size)))
	    text-height (* fontsize (+ 1 (cdr tooltip-size)))
	    screen-width (display-pixel-width)
	    screen-height (display-pixel-height))
      ;;
      (when (> (+ left text-width) screen-width)
	;; $B1&$K4s$j$9$.$F7g$1$F$7$^$o$J$$$h$&$K(B
	(setq left (- left (- (+ left text-width
				 ;; $B>/$7M>7W$K:8$K4s$;$J$$$H(B avoid
				 ;; $B$7$?%^%&%9%]%$%s%?$H43>D$9$k(B
				 (* 2 fontsize))
			      screen-width))))
      (when (> (+ top text-height) screen-height)
	;; $B2<$K4s$j$9$.$F7g$1$F$7$^$o$J$$$h$&$K(B
	(setq top (- top
		     (- (+ top text-height) screen-height)
		     ;; $B==J,>e$2$J$$$H%F%-%9%H$H=E$J$k$N$G!"(B
		     ;; $B$$$C$=%F%-%9%H$N>e$K$7$F$_$k(B
		     (- screen-height top)
		     fontsize))
	;; $B$5$i$K(B X $B:BI8$r(B...
	(let ((right (+ left
			text-width
			skk-tooltip-x-offset))
	      (mouse-x (+ (frame-parameter (selected-frame) 'left)
			  (* (frame-pixel-width)))))
	  (when (and (<= left mouse-x) (<= mouse-x right))
	    ;; $B%^%&%9%]%$%s%?$HHo$j$=$&$J$H$-(B
	    (setq left (- left (- right mouse-x) fontsize))))))
    ;;
    (setq parameters (if (eq skk-tooltip-mouse-behavior 'follow)
			 skk-tooltip-parameters
		       (append skk-tooltip-parameters
			       (list (cons 'top top)
				     (cons 'left left)))))
    ;;
    (skk-tooltip-show-1 text parameters)
    ;;
    (when (eq situation 'annotation)
      (skk-annotation-message situation))
    ;;
    (setq event (next-command-event))
    (cond
     ((skk-key-binding-member (skk-event-key event)
			      '(keyboard-quit
				skk-kanagaki-bs
				skk-kanagaki-esc)
			      skk-j-mode-map)
      (tooltip-hide)
      (when (and (not (memq skk-tooltip-mouse-behavior '(banish nil)))
		 (car oP))
	(mouse-avoidance-set-mouse-position oP))
      (skk-set-henkan-count 0)
      (cond ((eq skk-henkan-mode 'active)
	     (skk-unread-event
	      (character-to-event
	       (aref (car (where-is-internal 'skk-previous-candidate
					     skk-j-mode-map))
		     0)))
	     (when (eq situation 'listing)
	       ;; skk-henkan $B$^$G0l5$$K(B throw $B$9$k!#(B
	       (throw 'unread nil)))
	    (t
	     (skk-unread-event event))))
     (t
      (when (and (not (memq skk-tooltip-mouse-behavior '(banish nil)))
		 (car oP))
	(mouse-avoidance-set-mouse-position oP))
      (tooltip-hide)
      (skk-unread-event event)))))

(defun skk-tooltip-show-1 (text skk-params)
  (condition-case error
      (let ((params (copy-sequence tooltip-frame-parameters))
	    fg bg)
	(if skk-params
	    ;; $B%f!<%6$,FH<+$K(B tooltip $BI=<(@_Dj$9$k(B
	    (dolist (cell skk-params)
	      (setq params (tooltip-set-param params
					      (car cell)
					      (cdr cell))))
	  ;; tooltip $B$N%G%U%)%k%H$N@_Dj$r$9$k(B
	  (setq fg (face-attribute 'tooltip :foreground))
	  (setq bg (face-attribute 'tooltip :background))
	  (when (stringp fg)
	    (setq params (tooltip-set-param params 'foreground-color fg))
	    (setq params (tooltip-set-param params 'border-color fg)))
	  (when (stringp bg)
	    (setq params (tooltip-set-param params 'background-color bg))))
	(when (facep skk-tooltip-face)
	  (setq text (propertize text 'face skk-tooltip-face)))
	;; $B%_%K%P%C%U%!$K$$$k$H$-M>7W$J%a%C%;!<%8$r%/%j%"$9$k(B
	(when (or skk-isearch-switch
		  (skk-in-minibuffer-p))
	  (message nil))
	;;
	(x-show-tip text (selected-frame) params skk-tooltip-hide-delay
		    ;;
		    (if (eq skk-tooltip-mouse-behavior 'follow)
			skk-tooltip-x-offset
		      tooltip-x-offset)
		    ;;
		    (if (eq skk-tooltip-mouse-behavior 'follow)
			skk-tooltip-y-offset
		      tooltip-y-offset)))
    (error
     (message "Error while displaying tooltip: %s" error)
     (sit-for 1)
     (message "%s" text))))

(defalias 'skk-tooltip-hide 'tooltip-hide)

;; advices.

(defadvice tooltip-hide (after ccc-ad activate)
  (update-buffer-local-frame-params))

(require 'product)
(product-provide
    (provide 'skk-e21)
  (require 'skk-version))

;;; skk-e21.el ends here
