;;; skk-show-mode.el --- $B%b!<%I@ZBX;~$K(B tooltip/inline $BI=<($9$k(B -*- coding: iso-2022-jp -*-

;; Copyright (C) 2011 Tsuyoshi Kitamoto  <tsuyoshi.kitamoto@gmail.com>

;; Author: 2011 Tsuyoshi Kitamoto  <tsuyoshi.kitamoto@gmail.com>
;; Maintainer: SKK Development Team <skk@ring.gr.jp>
;; Version: $Id: skk-show-mode.el,v 1.6 2013/01/05 22:43:22 skk-cvs Exp $
;; Keywords: japanese, mule, input method
;; Last Modified: $Date: 2013/01/05 22:43:22 $

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
;; 
;;  ~/.skk $B$K$F(B
;;      (setq skk-show-mode-show t)
;;  $B$H@_Dj$7$F$/$@$5$$!#(B
;;  Emacs $B5/F0Cf$O(B M-x skk-show-mode $B$G%H%0%k$9$k$3$H$,$G$-$^$9!#(B

;;  $BJQ?t(B skk-show-mode-style $B$K(B 'tooltip $BKt$O(B 'inline $B$r@_Dj$7$F$/$@$5$$!#(B

;;; Code:

(eval-when-compile
  (require 'skk-vars)
  (require 'skk-dcomp))

(defadvice skk-isearch-set-initial-mode (before skk-show-mode activate)
  (setq skk-show-mode-show nil))

(defadvice skk-isearch-initialize-working-buffer (before skk-show-mode activate)
  (setq skk-show-mode-show nil))

(defadvice skk-cursor-set (after skk-show-mode activate)
  "$B$+$J%b!<%I$d%"%9%-!<%b!<%I$X@Z$jBX$o$C$?$H$-$K(B skk-*-mode-string $B$r(B
tooltip / inline $BI=<($9$k(B."
  (when (and skk-show-mode-invoked
	     skk-show-mode-show
	     (not skk-isearch-switch))
    (let ((func (cdr (assq skk-show-mode-style skk-show-mode-functions))))
      (when func
	(funcall func))))
  (setq skk-show-mode-invoked t))

(declare-function skk-dcomp-multiple-show "skk-dcomp")
(defun skk-show-mode-inline ()
  (let ((string (cond (skk-abbrev-mode         skk-abbrev-mode-string)
		      (skk-jisx0208-latin-mode skk-jisx0208-latin-mode-string)
		      (skk-katakana            skk-katakana-mode-string)
		      (skk-j-mode              skk-hiragana-mode-string)
		      (skk-jisx0201-mode       skk-jisx0201-mode-string)
		      (t                       skk-latin-mode-string)))
	(skk-henkan-start-point (point)))
    (skk-dcomp-multiple-show (list string))
    (sit-for 0.5)			; wait $BCf$G$b%-!<F~NO$O2DG=(B
    (skk-delete-overlay skk-dcomp-multiple-overlays)))

(defun skk-show-mode-tooltip ()
  (when window-system
    (let ((indicator
	   (apply 'skk-mode-string-to-indicator
		  (cond
		   (skk-abbrev-mode
		    `(abbrev ,skk-abbrev-mode-string))
		   (skk-jisx0208-latin-mode
		    `(jisx0208-latin ,skk-jisx0208-latin-mode-string))
		   (skk-katakana
		    `(katakana ,skk-katakana-mode-string))
		   (skk-j-mode
		    `(hiragana ,skk-hiragana-mode-string))
		   (skk-jisx0201-mode
		    `(jisx0201 ,skk-jisx0201-mode-string))
		   (t
		    `(latin ,skk-latin-mode-string))))))
      (skk-tooltip-show-at-point indicator))))

;;;###autoload
(defun skk-show-mode ()
  (interactive)
  (message "skk-show-mode-show: %s"
	   (setq skk-show-mode-show (null skk-show-mode-show))))
(provide 'skk-show-mode)

;;; skk-show-mode.el ends here
