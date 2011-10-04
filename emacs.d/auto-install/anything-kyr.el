;;; anything-kyr.el --- Show context-aware commands
;; $Id: anything-kyr.el,v 1.7 2009/03/04 00:02:14 rubikitch Exp $

;; Copyright (C) 2009  rubikitch

;; Author: rubikitch <rubikitch@ruby-lang.org>
;; Keywords: anything, convenience
;; URL: http://www.emacswiki.org/cgi-bin/wiki/download/anything-kyr.el

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Show context-aware commands by `anything'. It avoids forgetting
;; existence of appropriate commands. KYR is an abbreviation of "Kuuki
;; wo YomeRu", which means that person can read the atmosphere in
;; Japanese. Anything-kyr shows appropriate commands for the
;; situation.

;; Note that anything-kyr.el provides only the framework. See
;; anything-kyr-config.el for practical, polished, easy to use
;; configurations which can be used to assemble a custom personalized
;; configuration.
;;
;; http://www.emacswiki.org/cgi-bin/wiki/download/anything-kyr-config.el


;;; Installation:
;;
;; Put anything-kyr.el and anything-kyr-config.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'anything-kyr-config)
;;
;; Then put `anything-c-source-kyr' to `anything-sources'.
;; M-x `anything-kyr' for demo.

;;; History:

;; $Log: anything-kyr.el,v $
;; Revision 1.7  2009/03/04 00:02:14  rubikitch
;; Command description support (thanks tk159)
;;
;; Revision 1.6  2009/02/22 05:04:33  rubikitch
;; ignore erros when calculating conditions
;;
;; Revision 1.5  2009/02/19 16:25:02  rubikitch
;; * update doc.
;; * New command: `anything-kyr'
;;
;; Revision 1.4  2009/02/19 16:17:44  rubikitch
;; remove unneeded defvars
;;
;; Revision 1.3  2009/02/19 16:12:31  rubikitch
;; update doc
;;
;; Revision 1.2  2009/02/18 10:19:57  rubikitch
;; Commands are now symbols.
;;
;; Revision 1.1  2009/02/18 09:59:05  rubikitch
;; Initial revision
;;

;;; Code:

(defvar anything-kyr-version "$Id: anything-kyr.el,v 1.7 2009/03/04 00:02:14 rubikitch Exp $")
(require 'anything)

(defvar anything-c-source-kyr
  '((name . "Context-aware Commands")
    (candidates . anything-kyr-candidates)
    (display-to-real . (lambda (str) (intern-soft (car (split-string str " +\t")))))
    (action ("Execute" . call-interactively)
            ("Describe Function" . describe-function))
    (persistent-action . describe-function)))

(defvar anything-kyr-commands-by-major-mode nil
  "Show commands by major-mode.
It is a list of elements of (MAJOR-MODE COMMAND1 ...) or ((MAJOR-MODE1 MAJOR-MODE2) COMMAND1 ...).")
(defvar anything-kyr-commands-by-file-name nil
  "Show commands by file name.
It is a list of elements of (REGEXP COMMAND1 ...).")
(defvar anything-kyr-commands-by-condition nil
  "Show commands by condition.
It is a list of elements of (CONDITION COMMAND1 ...).")
(defvar anything-kyr-kinds
  '((anything-kyr-commands-by-condition . eval)
    (anything-kyr-commands-by-file-name
     . (lambda (re) (string-match re (or buffer-file-name ""))))
    (anything-kyr-commands-by-major-mode
     . (lambda (mode) (if (listp mode)
                          (memq major-mode mode)
                        (eq major-mode mode))))))
;; (anything 'anything-c-source-kyr)

(defvar anything-kyr-display-format "%-30s\t%-s")
(defun anything-kyr-candidates ()
  (with-current-buffer anything-current-buffer
    (delq nil
          (loop for (varname . condition-func) in anything-kyr-kinds append
                (loop for (condition . cmds) in (symbol-value varname)
                      when (save-excursion
                             (ignore-errors (funcall condition-func condition)))
                      append (mapcar
                              (lambda (command)
                                (cond ((commandp command)
                                       (symbol-name command))
                                      ((and (consp command) (commandp (car command)))
                                       (format anything-kyr-display-format
                                               (symbol-name (car command))
                                               (cdr command)))))
                              cmds))))))

(defun anything-kyr-commands-by-major-mode ()
  (assoc-default major-mode anything-kyr-commands-by-major-mode))

(defun anything-kyr ()
  (interactive)
  (anything 'anything-c-source-kyr))

;;;; unit test
;; (install-elisp "http://www.emacswiki.org/cgi-bin/wiki/download/el-expectations.el")
;; (install-elisp "http://www.emacswiki.org/cgi-bin/wiki/download/el-mock.el")
(dont-compile
  (when (fboundp 'expectations)
    (expectations
      (desc "anything-kyr-commands-by-condition")
      (expect '("find-file")
        (let (anything-kyr-commands-by-major-mode
              anything-kyr-commands-by-file-name
              (anything-kyr-commands-by-condition
               '(((eq t t) find-file)
                 ((eq t nil) switch-to-buffer))))
          (anything-kyr-candidates)))
      (expect '("find-file")
        (let (anything-kyr-commands-by-major-mode
              anything-kyr-commands-by-file-name
              (anything-kyr-commands-by-condition
               '(((equal buffer-file-name "hoge") find-file)
                 ((eq t nil) switch-to-buffer)))
              (buffer-file-name "hoge"))
          (anything-kyr-candidates)))
      (desc "anything-kyr-commands-by-file-name")
      (expect '("describe-variable" "describe-function")
        (let (anything-kyr-commands-by-major-mode
              anything-kyr-commands-by-condition
              (anything-kyr-commands-by-file-name
               '((".lisp$" describe-variable describe-function)))
              (buffer-file-name "test.lisp"))
          (anything-kyr-candidates)))
      (desc "anything-kyr-commands-by-major-mode")
      (expect '("gomoku")
        (let (anything-kyr-commands-by-file-name
              anything-kyr-commands-by-condition
              (anything-kyr-commands-by-major-mode
               '((lisp-mode gomoku)))
              (major-mode 'lisp-mode))
          (anything-kyr-candidates)))
      (expect '("gomoku")
        (let (anything-kyr-commands-by-file-name
              anything-kyr-commands-by-condition
              (anything-kyr-commands-by-major-mode
               '(((lisp-mode perl-mode) gomoku)))
              (major-mode 'lisp-mode))
          (anything-kyr-candidates)))
      (desc "condition / file-name / major-mode")
      (expect '("find-file" "describe-variable" "describe-function" "gomoku")
        (let ((anything-kyr-commands-by-file-name
               '((".lisp$" describe-variable describe-function)))
              (anything-kyr-commands-by-major-mode
               '((lisp-mode gomoku)))
              (anything-kyr-commands-by-condition
               '(((eq t t) find-file)
                 ((eq t nil) switch-to-buffer)))
              (buffer-file-name "test.lisp")
              (major-mode 'lisp-mode))
          (anything-kyr-candidates)))
      (desc "only commands are listed")
      (expect '("find-file")
        (let (anything-kyr-commands-by-major-mode
              anything-kyr-commands-by-file-name
              (anything-kyr-commands-by-condition
               '((t find-file not-command))))
          (anything-kyr-candidates)))
      (desc "command with description")
      (expect '("find-file" "switch-to-buffer \tBuffer Switch")
        (let (anything-kyr-commands-by-major-mode
              anything-kyr-commands-by-file-name
              (anything-kyr-display-format "%s \t%s") 
              (anything-kyr-commands-by-condition
               '((t find-file (switch-to-buffer . "Buffer Switch")))))
          (anything-kyr-candidates)))
      )))

(provide 'anything-kyr)

;; How to save (DO NOT REMOVE!!)
;; (emacswiki-post "anything-kyr.el")
;;; anything-kyr.el ends here
