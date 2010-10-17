;;; moz-plus.el ---

;; Author: Kenji.I (Kenji Imakado) <ken.imakaado@gmail.com>
;; Version: 0.1
;; Keywords: javascript mozrepl moz.el anything

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.



;;; Commentary:

;; 補完候補を探す時に副作用があるような場合気をつけてください。


;;; known bug
;;; complete
;;eval("jsKeywords" , FirebugLib.isJavaScriptKeyword).`!!'
;; URLBarAutoFillPrefListener.`!!' -> TAB -> ["prototype=[probably array, length undefined]"]
;; になってしまう。補完のインサート部分の見直しが必要

;;;id and class complete
;; 複数のクラスの補完のコマンド化
;; インサート時の挙動（JSと同じでは問題あり）

;; IDの補完時のinsert
;; 補完に失敗した際の後処理 => clean up見たいな処理が必要。
;; Cc["@mozilla.org/preferences-service;1"].getService(Ci.nsIPrefBranch).getCharPref('extensions.mozlab.mozrepl.initUrl')
;;↑適当。こういった行がストレスなく入力できるようにする。

;;arg process -> set marker -> eval -> copy -> delete text -> return list of string
;;repl.enter(repl.`!') -> \t の挙動

;;; TODO
;; Buffer-Local変数を作る? moz-plus-enable-repl.MOZPLUS-flag等
;;; Hook作成
;; comint-redirect-send-command-to-process を使った方法を試す（現在未検証）
;;repl> タイミングによってプロンプトが重複表示してしまうのに対応する(優先度低)


(require 'cl)
(require 'moz)
(require 'anything)

;;; Variables
(defvar moz-plus-obj-name nil)
(defvar moz-plus-hint nil)
(defvar moz-plus-output-data "") ;; in moz-plus-get-output-filter
(defvar moz-plus-candidates nil) ;; candidates for anything
(defvar moz-plus-repl-js-identifier-re "[_$a-zA-Z][_$a-zA-Z0-9]*")

(defvar moz-plus-completion-include-dontenum-flag nil)
(defvar moz-plus-enable-completion-include-dontenum-flag nil)
;; (set (make-variable-buffer-local 'moz-plus-completion-include-dontenum-flag) nil)
;; (set (make-variable-buffer-local 'moz-plus-enable-completion-include-dontenum-flag) nil) 


;;; build string
(defun moz-plus-build-str-add-semicolon-tail (str)
  (unless (string-match ";[ \t]*$" str)
    (concat str ";")))

(defun moz-plus-build-str-with-repl-name (str)
  (concat moz-repl-name "." str))

(defun moz-plus-build-str-with-repl-print (str)
  (moz-plus-build-str-add-semicolon-tail (concat (moz-plus-build-str-with-repl-name "print") "(" str ")")))

(defun moz-plus-build-str-repl-command (&rest los)
  (moz-plus-build-str-add-semicolon-tail
   (moz-plus-build-str-with-repl-name
    (apply 'concat los))))

(defun moz-plus-build-search-string (&optional obj type)
  (setq obj (or obj "this"))
  (cond
   ((eq type 'id)
    (moz-plus-build-str-repl-command "MOZPLUS.getAllIdAndClassName" "(" obj ", 'id'" ")"))
   ((eq type 'class)
    (moz-plus-build-str-repl-command "MOZPLUS.getAllIdAndClassName" "(" obj ", 'class'" ")"))
   ((eq type 'id-and-class)
    (moz-plus-build-str-repl-command "MOZPLUS.getAllIdAndClassName" "(" obj ", 'id-and-class'" ")"))
   ((eq type 'inspect)
    (concat (moz-plus-build-str-repl-command "inspect" "(" obj ")")
            (moz-plus-build-str-repl-command "print('_____end_of_mozrepl_output_____')")))
   ((and moz-plus-completion-include-dontenum-flag
         moz-plus-enable-completion-include-dontenum-flag)
    (moz-plus-build-str-repl-command "MOZPLUS.getProperties" "(" obj ")"))
   (t
    (concat (moz-plus-build-str-repl-command "search" "(" "function(a){return a}" "," obj ")")
            (moz-plus-build-str-repl-command "print('_____end_of_mozrepl_output_____')")))))

;;; Utils send str to mozrepl process 
(defun moz-plus-send-string (string &optional proc)
  (let ((proc (or proc (inferior-moz-process))))
    (comint-send-string proc string)))

(defun moz-plus-send-string-multiline (string &optional proc)
  (moz-plus-send-string-quietly
   (mapconcat 'moz-plus-build-str-with-repl-name 
              '("pushenv('printPrompt', 'inputMode');"
                "setenv('printPrompt', false);"
                "setenv('inputMode', 'multiline');")
              " "))
  (sleep-for 0 10)
  (moz-plus-send-string-quietly string)
  (moz-plus-send-string-quietly "\n--end-remote-input\n")
  (moz-plus-send-string-quietly (moz-plus-build-str-with-repl-name "popenv('inputMode', 'printPrompt'); "))
  (moz-plus-send-string-quietly "\n--end-remote-input\n"))

(defun moz-plus-send-string-quietly (string &optional proc)
  (let ((s (concat  (moz-plus-build-str-add-semicolon-tail string) " undefined;")))
    (moz-plus-send-string string proc)))

(defun moz-plus-send-string-no-prompt (string &optional proc)
  (moz-plus-send-string-quietly
   (mapconcat 'moz-plus-build-str-with-repl-name
              '("pushenv('printPrompt');"
                "setenv('printPrompt', false); undefined;")
              " "))
  (sleep-for 0 10)
  (moz-plus-send-string-quietly string)
  (moz-plus-send-string-quietly (moz-plus-build-str-with-repl-name "popenv('printPrompt'); undefined;")))

;;; Config and Utils for anything
(defvar moz-plus-completion-anything-source
  '((name . "moz-completion")

    (candidates . moz-plus-candidates)

    (match . (moz-plus-anything-c-match-spacelable))

    (action . (("insert" . moz-plus-appropriate-insert)

               ("insert as hash access" . (lambda (candidate)
                                                    (delete-backward-char (1+ (length moz-plus-hint)))
                                                    (insert (concat "[\"" candidate "\"]"))))))))

(defun moz-plus-anything-c-match-spacelable (candidate)
  "an thing sour\" -> \"an.*thing.*sour"
  (let ((pattern anything-pattern)
        (replaced-re))
    (setq replaced-re
          (while (string-match "\\([ \t]+\\)" pattern)
            (setq pattern (replace-match ".*" nil nil pattern 1))))
    (string-match (or replaced-re pattern) candidate)))

(defun moz-plus-appropriate-insert (candidate)
  (cond
   ;; javascript variable
   ((string-match (concat "^" moz-plus-repl-js-identifier-re "$") candidate)
    (delete-backward-char (length moz-plus-hint))
    (insert candidate))
   ;; handle index
   ;; this same as ["10"] but feel better :)
   ((string-match "^[0-9]+$" candidate)
    (delete-backward-char (1+ (length moz-plus-hint)))
    (insert (concat "[" candidate "]")))
   (t
    (delete-backward-char (1+ (length moz-plus-hint)))
    (insert (concat "[\"" candidate "\"]")))))

(put 'moz-plus-with-anything-sources 'lisp-indent-hook 1) ;indent
(defmacro moz-plus-with-anything-sources (sources &rest body) ;;展開系はanything-sourcesを参照する。
  (let ((saved-anything-souces (gensym)))
    `(let ((,saved-anything-souces anything-sources))
       (unwind-protect
           (let ((anything-sources ,sources))
             ,@body)
         (setq anything-sources ,saved-anything-souces)))))

;; non-nilでanythingでの補完時にオリジナルのキーマップを使う 未実装
(defvar moz-plus-use-moz-plus-anything-keys t)
(defvar moz-plus-anything-keymap
  (let ((map (copy-keymap anything-map)))
    (define-key map (kbd "C-n")     'anything-next-line)
    (define-key map (kbd "C-p")     'anything-previous-line)
    (define-key map (kbd "M-v")     'anything-previous-page)
    (define-key map (kbd "C-v")     'anything-next-page)
    map))

(put 'moz-plus-with-anything-map 'lisp-indent-hook 1) ;indent
(defmacro moz-plus-with-anything-map (keymap &rest body)
  (let ((saved-anything-map (gensym)))
    `(let ((,saved-anything-map anything-map))
       (unwind-protect
           (let ((anything-map ,keymap))
             ,@body)
         (setq anything-map ,saved-anything-map)))))

;;; Special case
(defvar moz-plus-completion-special-case-alst
      `(
        ((matcher . ,(concat "\\(" "\\)" ;dummy...
                             "\\(?:"
                             "\\(?:^\\|[^$]\\)" "\\$"
                             "\\|"
                             "getElementById"
                             "\\)"
                             
                             "([\"']"
                             "\\(" ;hint
                             moz-plus-repl-js-identifier-re
                             "\\)?"
                             "$"
                             ))
         
         (search-str . ,(moz-plus-build-search-string "document" 'id))
         
         (complete . (lambda ()
                       (let (cands)
                         (dolist (cand moz-plus-candidates cands)
                           (when (string-match "\\(.*\\) - \\[\\(id\\|class\\)\\]" cand)
                             (setq cands (cons (cons cand (match-string 1 cand)) cands))))
                         (setq moz-plus-candidates cands)
                         (moz-plus-completion-use-anything)))))
        

        ((matcher . ,(concat "\\(?:"
                             "\\$\\$" ;$$() prototype MochiKit
                             "\\|"
                             "getElementsByClassName"
                             "\\)"
                             
                             "([\"']"
                             "\\("
                             moz-plus-repl-js-identifier-re
                             "\\)?"
                             "$"))
         (search-str . ,(moz-plus-build-search-string "document" 'class))
         
         (complete . (lambda ()
                       (dolist (cand moz-plus-candidates)
                         (when (string-match "\\(.*\\) - \\[\\(id\\|class\\)\\]$" cand)
                           (setq moz-plus-candidates (cons (cons cand (match-string 1 cand)) moz-plus-candidates))))
                       (moz-plus-completion-use-anything))))

        ((matcher . ,(concat "\\(" "\\)" ;dummy...
                             "([\"']"
                             "$"
                             ))
         (search-str . ,(moz-plus-build-search-string "document" 'id-and-class))
         (complete . (lambda ()
                       (let (cands)
                         (dolist (cand moz-plus-candidates cands)
                           (when (string-match "\\(.*\\) - \\[\\(id\\|class\\)\\]" cand)
                             (setq cands (cons (cons cand (match-string 1 cand)) cands))))
                         (setq moz-plus-candidates cands)
                         (moz-plus-completion-use-anything))))
        (search-str . ,(moz-plus-build-search-string "document" 'id-and-class)))))

(defun moz-plus-completion-special-case (input loalst)
  (let (called)
    (dolist (alst loalst called)
      (let* ((getval (lambda (type)
                       (assoc-default type alst 'eq)))
             (matcher (funcall getval 'matcher))
             (search-str (or (funcall getval 'search-str)
                             (moz-plus-build-search-string moz-plus-obj-name)))
             (build-cands (or (funcall getval 'build-cands)
                              'moz-plus-build-candidates))
             (complete (or (funcall getval 'complete) 'moz-plus-completion-use-anything)))
        (cond
         (called)
         ((string-match matcher input)
          (setq called t)
          (setq moz-plus-obj-name (match-string 1 input)
                moz-plus-hint (match-string 2 input))
          (let ((got-data (moz-plus-send-and-get-output search-str)))
            (setq moz-plus-candidates (funcall build-cands got-data moz-plus-hint)))
          (funcall complete)))))))


;;; Completion
(defun moz-plus-complete (&optional arg)
  (interactive "p")
  (moz-plus-initialize)
  (let ((input (moz-plus-get-input))
        (search-by-repl-inspect (> arg 1)))
    (unless (moz-plus-completion-special-case input moz-plus-completion-special-case-alst)
      (multiple-value-setq (moz-plus-obj-name moz-plus-hint)
                           (moz-plus-get-obj-name-and-hint-from-input input)) ;str -> los (objname hint)
      (let ((got-data (moz-plus-send-and-get-output
                       (moz-plus-build-search-string moz-plus-obj-name
                                                     (when search-by-repl-inspect 'inspect))))) ;C-u \t
        (setq moz-plus-candidates (moz-plus-build-candidates got-data moz-plus-hint nil search-by-repl-inspect)))
      (moz-plus-completion-use-anything))))

(defun moz-plus-initialize ()
  (setq moz-plus-obj-name nil
        moz-plus-hint nil
        moz-plus-output-data ""
        moz-plus-candidates nil)
  (moz-plus-prompt-make-ready))

(defun moz-plus-prompt-make-ready ()
  "if ...> prompt enter a colon to force evaluation"
  (interactive)
  (let ((cont-prompt-re (concat "^" (regexp-quote "....> "))))
    (when (or (string-match cont-prompt-re moz-plus-output-data)
              (string-match cont-prompt-re
                            (buffer-substring-no-properties
                             (save-excursion (move-to-column 0) (point))
                             (point))))
      (moz-plus-send-string ";")
      (setq moz-plus-output-data ""))))

(defun moz-plus-get-input ()
  (let ((bol)
        (eol (point)))
    (save-excursion
      (beginning-of-line)
      (setq bol (point)))
    (buffer-substring-no-properties bol eol)))

;;str -> los (objname hint)
(defun moz-plus-get-obj-name-and-hint-from-input (input)
  (let (objname hint after-=)
    (cond
     ;; (
     ((string-match (concat "(" "\\(" moz-plus-repl-js-identifier-re  "\\)?" "$") input)
      (setq hint (match-string 1 input)))
     ;; 閉じてない括弧の場合
     ((string-match (concat "(" ;open paren
                            "\\(" ;1
                            "[^)\n]*"
                            "$"
                            "\\)") input)
      (multiple-value-setq (objname hint)
                           (moz-plus-get-obj-name-and-hint-from-input (match-string 1 input))))
                            
     ;; .
     ((string-match (concat "\\([^ \t]+\\)";1
                            "\\."
                            "\\("          ;2
                            moz-plus-repl-js-identifier-re
                            "\\)?"
                            "$"
                            ) input)
      (setq objname (match-string 1 input))
      (setq hint (match-string 2 input)))
     ;; =
     ((string-match (concat ".*"
                            "="
                            "\\("       ;1
                            ".*"
                            "\\)" 
                            "$")
                    input)
      (multiple-value-setq (objname hint)
                           (moz-plus-get-obj-name-and-hint-from-input (match-string 1 input))))
     ((string-match (concat "[ \t]*"
                            "\\("       ;1
                            moz-plus-repl-js-identifier-re
                            "\\)?"
                            "$") input)
      (setq hint (match-string 1 input)))
     ;; default
     (t
      (setq objname nil)
      (setq hint nil)))
    (list objname hint)))

(defun moz-plus-output-filter (output)
  (prog1 ""
    (setq moz-plus-output-data (concat  moz-plus-output-data output))))

(defun moz-plus-send-and-get-output (search-str)
  (unwind-protect
      (let ((done) (limit 3000) (time 0))
        (moz-plus-prompt-make-ready)
        (setq moz-plus-output-data "")
        (add-hook 'comint-preoutput-filter-functions 'moz-plus-output-filter)
        (moz-plus-send-string search-str)
        (while (not done)
          (cond
           ((string-match "_____end_of_mozrepl_output_____" moz-plus-output-data)
            (setq done t))
           ;; handle inviled js
           ((string-match (regexp-quote "....>") moz-plus-output-data)
            (moz-plus-send-string ";")
            (error "maybe inviled js. sent \";\" to force evaluation"))
           ;; timeout
           ((> time  limit)
            (error "timeout"))
           (t
            (setq time (+ time 20))
            (sleep-for 0 20))))
        moz-plus-output-data)
    (remove-hook 'comint-preoutput-filter-functions 'moz-plus-output-filter)))

(defun moz-plus-build-candidates (output-data &optional hint split-re repl-inspect-p) ; repl-inspect-p is non-nil if searched by repl.inspect 
  (let ((los (moz-plus-split-and-remove-mess output-data split-re))
        (ret))
    (cond
     ;; repl.inspect
     (repl-inspect-p
      (let ((hint-str (or hint "")))
        (dolist (s los)
          (when (string-match (concat "^<[^>\n]*>\\."
                                      "\\(" ;1 DISPLAY
                                      "\\(" hint-str "[^=\n]+" "\\)" ;2 obj(REAL)
                                      "="
                                      ".*"
                                      "$"
                                      "\\)";1 end
                                      ) s)
            (push (cons (match-string 1 s) (match-string 2 s)) ret))))
            (sort ret (lambda (a b)
                        (string< (car a) (car b)))));;(display . val)
     (t
      (if hint
          (dolist (l los)
            (when (string-match (concat "^\\(" (regexp-quote hint) ".*\\)") l)
              (push (match-string 1 l) ret)))
        (setq ret los))
      (sort ret 'string<)))))

(defun moz-plus-split-and-remove-mess (output-data &optional split-re)
  (let ((split-re (or split-re "[\n]")))
    (remove "_____end_of_mozrepl_output_____" (remove "repl> " (remove "" (split-string output-data split-re))))))

(defun moz-plus-completion-use-anything ()
  (moz-plus-with-anything-sources `(,moz-plus-completion-anything-source)
    (moz-plus-with-anything-map moz-plus-anything-keymap
      (cond
       ;; handle not found propaty in obj and if inspected-data is ... send `;' to mozrepl process
       ((null moz-plus-candidates)
        (message "no property found  \"%s\" in object: %s " moz-plus-hint moz-plus-obj-name))
       ;; handle found just one prop
       ;; alistがくる場合もある
       ((= 1 (length moz-plus-candidates))
        (moz-plus-appropriate-insert (if (listp (car moz-plus-candidates))
                                         (caar moz-plus-candidates) ;'(("DISPLAY" . "REAL"))
                                       (car moz-plus-candidates))))
       (t
        (anything)))))) 

(defun moz-plus-completion-cleanup (output-data) ;;not used for now
  "error check"
  (cond
   ((string-match "!!! .+Error:" output-data)
    (moz-plus-send-string ";")) ))

;;util funcs

;;util "an thing sour\" -> \"an.*thing.*sour"
;;Todo: funcname
;; space区切りで絞り込めるようにする

;;; Completion id class name
(defun moz-plus-complete-all-ids ()
  (interactive)
  (moz-plus-complete-selector "id"))

(defun moz-plus-complete-all-classes ()
  (interactive)
  (moz-plus-complete-selector "class"))

(defun moz-plus-complete-all-names ()
  (interactive)
  (moz-plus-complete-selector "name"))

(defun moz-plus-complete-all-selector ()
  (interactive)
  (moz-plus-complete-selector "all"))

(defun moz-plus-complete-selector (type)
  (moz-plus-initialize)
  (let ((input (moz-plus-get-input)))
    (multiple-value-setq (moz-plus-obj-name moz-plus-hint)
                         (moz-plus-get-obj-name-and-hint-from-input input))
    (let ((got-data (moz-plus-send-and-get-output
                     (moz-plus-build-js-get-id-class type))))
      (setq moz-plus-candidates (moz-plus-build-candidates-selector got-data moz-plus-hint)))
    (moz-plus-completion-selector-use-anything)))

(defun moz-plus-build-candidates-selector (output-data &optional hint)
  (let ((los (moz-plus-split-and-remove-mess output-data nil))
        (hint (or hint ""))
        (ret))
    (dolist (s los ret)
      (when (string-match "\\(.*\\)\\( - \\[\\(?:id\\|class\\|name\\)\\]\\)" s)
        (let ((selector (match-string 1 s))
              (describe (match-string 2 s)))
          (mapc (lambda (name)
                  (when (string-match (concat "^" hint) name)
                    (add-to-list 'ret (cons (concat name describe) name))))
                (split-string selector " ")))))))

(defun moz-plus-completion-selector-use-anything ()
  (moz-plus-with-anything-sources `(,moz-plus-completion-selector-anything-source)
    (moz-plus-with-anything-map moz-plus-anything-keymap
      (let ((selector (if (listp (car moz-plus-candidates)) (caar moz-plus-candidates) (car moz-plus-candidates)))) ;'(("DISPLAY" . "REAL"))
        (cond
         ((null moz-plus-candidates)
          (message "completion is not found"))
         ((= 1 (length moz-plus-candidates))
          (delete-backward-char (length moz-plus-hint))
          (insert selector))
         (t
          (anything)))))))

(defvar moz-plus-completion-selector-anything-source
  '((name . "moz-completion")
        
    (candidates . moz-plus-candidates)

    (match . (moz-plus-anything-c-match-spacelable))

    (action . (("insert" . (lambda (candidate)
                             (delete-backward-char (length moz-plus-hint))
                             (insert candidate)))))
    ))

(defun moz-plus-build-js-get-id-class (type)
 (concat "(function(node, type){
    var arr = 
        (function(node, type, ret){
            if (node.nodeType == 1){
                if (node.id && ('id' == type || 'all' == type) ) ret.push(node.id + ' - [id]');
                else if (node.className && ('class' == type || 'all' == type)) ret.push(node.className + ' - [class]');
                else if (node.name && ('name' == type || 'all' == type)) ret.push(node.name + ' - [name]');
            }

            var cNodes = node.childNodes;
            for (var i = 0, cl = cNodes.length; i < cl; i++)
                arguments.callee(cNodes[i], type, ret);

            return ret;
        })(node, type, []);

    arr.sort();

    //uniq expect arr is sorted
    var ans = [];
    for(var j = 0, al = arr.length; j < al; j++)
        if (j == 0 || ans[ans.length - 1] != arr[j])
            ans.push(arr[j]);
    ans[ans.length] = '_____end_of_mozrepl_output_____';
    return ans.join('\\n');    
})(document, '" type "')"))


;;; Utilities commands
;;; completion include dontEnum
(defun moz-plus-toggle-completion-include-dontenum ()
  (interactive)
  (let ((enablep nil))
    (cond
     ((not moz-plus-completion-include-dontenum-flag)
      (unless moz-plus-enable-completion-include-dontenum-flag
        (moz-plus-prompt-make-ready)
        (moz-plus-init-MOZPLUS)
        (when (dotimes (count 15 enablep)
                (cond
                 (enablep)
                 (t
                  (sleep-for 0 200)
                  (when (moz-plus-enable-MOZPLUS-p)
                    (setq enablep t)))))
          (setq moz-plus-enable-completion-include-dontenum-flag t)))
      (setq moz-plus-completion-include-dontenum-flag t))
     (t
      (setq moz-plus-completion-include-dontenum-flag nil)))))

(defun moz-plus-enable-MOZPLUS-p () ;return nil or non-nil
  (string-match "^true" (moz-plus-send-and-get-output moz-plus-enable-MOZPLUS-p-js)))

(defvar moz-plus-enable-MOZPLUS-p-js
  (concat (moz-plus-build-str-with-repl-print "!!((repl.MOZPLUS) && (repl.MOZPLUS.getProperties))")
          (moz-plus-build-str-with-repl-print "'_____end_of_mozrepl_output_____'")))

;;; repl.load
(defun moz-plus-load-js (&optional file context)
  (interactive "f\nsContext[default nil]: ")
  (let ((file (expand-file-name file))
        (context (if (string= context "")
                     "')"
                   (concat "'," context ")"))))
    (moz-plus-send-string
     (moz-plus-build-str-repl-command "load('file:" file context))))

;;; repl.enter (content)
;;command
(defun moz-plus-always-enter-content ()
  (interactive)
  (if (not moz-plus-always-enter-content-flag);if nil
      (progn
        (setq moz-plus-always-enter-content-flag t)
        (ad-enable-advice 'comint-send-input 'after 'repl-enter-content)
        (ad-activate 'comint-send-input)
        (message "toggle moz-plus-always-enter-content-flag on"))
    (setq moz-plus-always-enter-content-flag nil)
    (ad-disable-advice 'comint-send-input 'after 'repl-enter-content)
    (ad-activate 'comint-send-input)
    (message "toggle moz-plus-always-enter-content-flag off")))

(defadvice comint-send-input (after repl-enter-content)
  (moz-plus-enter-content))

(defun moz-plus-enter-content (&optional arg)
  (sleep-for 0 20)
  (moz-plus-prompt-make-ready)
  (moz-plus-send-and-get-output
   (concat (moz-plus-build-str-repl-command "enter(content)")
           (moz-plus-build-str-with-repl-print "'_____end_of_mozrepl_output_____'"))))
  
(defvar moz-plus-always-enter-content-flag nil)

;;; repl.whereAmI
(defun moz-plus-where-am-i ()
  (sleep-for 0 20)
  (moz-plus-prompt-make-ready)
  (moz-plus-send-and-get-output
   (concat (moz-plus-build-str-repl-command "whereAmI()")
           (moz-plus-build-str-with-repl-print "'_____end_of_mozrepl_output_____'")))
  (let ((where (progn
                 (string-match "\\(\\[[^]]+?\\]\\)" moz-plus-output-data)
                 (concat " PLUS-" (match-string 1 moz-plus-output-data)))))
    (setcar (cdr (assoc  'moz+ minor-mode-alist)) where)))

(defadvice comint-send-input (after repl-where-am-i)
  (moz-plus-where-am-i))

(defvar moz-plus-display-where-am-i-flag nil)
(defun moz-plus-display-where-am-i ()
  (interactive)
  (if (not moz-plus-display-where-am-i-flag)
      (progn 
        (setq moz-plus-display-where-am-i-flag t)
        (ad-enable-advice 'comint-send-input 'after 'repl-where-am-i)
        (ad-activate 'comint-send-input)
        (message "toggle moz-plus-display-where-am-i-flag on"))
    (setq moz-plus-display-where-am-i-flag nil)
    (ad-disable-advice 'comint-send-input 'after 'repl-where-am-i)
    (ad-activate 'comint-send-input)
    (setcar (cdr (assoc 'moz+ minor-mode-alist)) " PLUS")
    (message "toggle moz-plus-display-where-am-i-flag off")))

;;;status
(defun moz-plus-display-status ()
  (interactive)
  (apply 'message
         (cons "auto enter context: [%s] display where: [%s] completion include dontEnum: [%s]"
               (mapcar (lambda (flag)
                         (if flag "on" "off"))
                       (list moz-plus-always-enter-content-flag
                             moz-plus-display-where-am-i-flag
                             moz-plus-completion-include-dontenum-flag)))))
               

;;; MODE
(defun moz-plus-mode-init ()
  (let ((enablep nil))
    (when moz-plus-completion-include-dontenum-flag
      (moz-plus-init-MOZPLUS)
      (when (dotimes (count 15 enablep)
              (cond
               (enablep)
               (t
                (sleep-for 0 200)
                (when (moz-plus-enable-MOZPLUS-p)
                  (setq enablep t)))))
        (setq moz-plus-enable-completion-include-dontenum-flag t))))) 

(defvar moz-plus-completion-key "\t")
(defvar moz-plus-prefix-key "\C-cm")
(defun moz-plus-setup-keymap ()
  (let ((map (make-keymap)))
    (define-key map moz-plus-prefix-key nil)
    (define-key map (concat moz-plus-prefix-key "l") 'moz-plus-load-js);Default: C-c m l
    (define-key map (concat moz-plus-prefix-key "w") 'moz-plus-display-where-am-i);Default: C-c m w
    (define-key map (concat moz-plus-prefix-key "e") 'moz-plus-always-enter-content);Default: C-c m e
    (define-key map moz-plus-completion-key 'moz-plus-complete)
    (define-key map (concat moz-plus-prefix-key "i") 'moz-plus-complete-all-ids)
    (define-key map (concat moz-plus-prefix-key "c") 'moz-plus-complete-all-classes)
    (define-key map (concat moz-plus-prefix-key "n") 'moz-plus-complete-all-names)
    (define-key map (concat moz-plus-prefix-key "a") 'moz-plus-complete-all-selector)
    (define-key map (concat moz-plus-prefix-key "s") 'moz-plus-display-status)
    (define-key map (concat moz-plus-prefix-key "d") 'moz-plus-toggle-completion-include-dontenum)
    map))

;; 0, 1とかも追加した。
;; forEach, Iterator, prototype, Event, typeofはキーワード
(defvar moz-plus-init-js (concat "(function () {
if (typeof " moz-repl-name " != 'undefined'){
    " moz-repl-name ".MOZPLUS = {};
    var M = " moz-repl-name ".MOZPLUS;
    
    M.getProperties = function(obj){
        var arr = [], count = 0;
        for (arr[count++] in obj) ;

        var _undefined = void(0);
        for (var i = 0, dl = M.dontEnum.length; i < dl; i++)
            if (_undefined != obj[M.dontEnum[i]])
                arr.push(M.dontEnum[i]);

        arr.sort();

        var ans = [];
        for(var j = 0, al = arr.length; j < al; j++)
            if (j == 0 || ans[ans.length - 1] != arr[j]) 
                ans.push(arr[j]);

        ans[ans.length] = '_____end_of_mozrepl_output_____';
        return ans.join('\\n');
    };

    M.getAllIdAndClassName = function(n, type){
        var arr = 
        (function(n, type, ret){
            if (n.nodeType == 1){
                if (n.id && ('id' == type || 'id-and-class' == type) ) ret.push(n.id + ' - [id]');
                else if (n.className && ('class' == type || 'id-and-class' == type)) ret.push(n.className + ' - [class]');
            }

            var cNodes = n.childNodes;
            for (var i = 0, cl = cNodes.length; i < cl; i++)
                arguments.callee(cNodes[i], type, ret);

            return ret;
         })(n, type, []);

        arr.sort();

        //uniq
        var ans = [];
        for(var j = 0, al = arr.length; j < al; j++)
            if (j == 0 || ans[ans.length - 1] != arr[j])
                ans.push(arr[j]);

        ans[ans.length] = '_____end_of_mozrepl_output_____';
        return ans.join('\\n');
    };

    M.dontEnum = [
                  '0',
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                  '6',
                  '7',
                  '8',
                  '9',
                  '10',
                  '11',
                  '12',
                  '13',
                  '14',
                  '15',
                  '16',
                  '17',
                  '18',
                  '19',
                  '20',
                  '$&',
                  '$\\'',
                  '$*',
                  '$+',
                  '$1',
                  '$2',
                  '$3',
                  '$4',
                  '$5',
                  '$6',
                  '$7',
                  '$8',
                  '$9',
                  '$_',
                  '$`',
                  'ActiveXObject',
                  'AddChannel',
                  'AddDesktopComponent',
                  'AddFavorite',
                  'Array',
                  'AutoCompleteSaveForm',
                  'AutoScan',
                  'Boolean',
                  'ChooseColorDlg',
                  'Date',
                  'E',
                  'Enumerator',
                  'Event',
                  'Error',
                  'Function',
                  'GetObject',
                  'Hidden',
                  'Image',
                  'ImportExportFavorites',
                  'IsSubscribed',
                  'Iterator',
                  'LN10',
                  'LN2',
                  'LOG10E',
                  'LOG2E',
                  'MAX_VALUE',
                  'MIN_VALUE',
                  'Math',
                  'Methods',
                  'NEGATIVE_INFINITY',
                  'NaN',
                  'NavigateAndFind',
                  'Number',
                  'Object',
                  'Option',
                  'PI',
                  'POSITIVE_INFINITY',
                  'QueryInterface',
                  'RegExp',
                  'SQRT1_2',
                  'SQRT2',
                  'Script',
                  'ScriptEngine',
                  'ScriptEngineBuildVersion',
                  'ScriptEngineMajorVersion',
                  'ScriptEngineMinorVersion',
                  'ShowBrowserUI',
                  'String',
                  'URL',
                  'URLUnencoded',
                  'UTC',
                  'VBArray',
                  'XMLDocument',
                  'XSLDocument',
                  'aLink',
                  'abbr',
                  'abs',
                  'accelerator',
                  'accept',
                  'acceptCharset',
                  'accessKey',
                  'acos',
                  'action',
                  'activeElement',
                  'add',
                  'addBehavior',
                  'addImport',
                  'addPageRule',
                  'addReadRequest',
                  'addRequest',
                  'addRule',
                  'alert',
                  'align',
                  'alinkColor',
                  'all',
                  'allowTransparency',
                  'alt',
                  'altHTML',
                  'altKey',
                  'altLeft',
                  'anchor',
                  'anchors',
                  'appCodeName',
                  'appMinorVersion',
                  'appName',
                  'appVersion',
                  'appendChild',
                  'appendData',
                  'applets',
                  'apply',
                  'applyElement',
                  'areas',
                  'arguments',
                  'asin',
                  'assign',
                  'atEnd',
                  'atan',
                  'atan2',
                  'atomic',
                  'attachEvent',
                  'attributes',
                  'autocomplete',
                  'availHeight',
                  'availWidth',
                  'axis',
                  'back',
                  'background',
                  'backgroundAttachment',
                  'backgroundColor',
                  'backgroundImage',
                  'backgroundPosition',
                  'backgroundPositionX',
                  'backgroundPositionY',
                  'backgroundRepeat',
                  'balance',
                  'baseHref',
                  'behavior',
                  'behaviorCookie',
                  'behaviorPart',
                  'behaviorUrns',
                  'bgColor',
                  'bgProperties',
                  'big',
                  'blink',
                  'blockDirection',
                  'blur',
                  'body',
                  'bold',
                  'border',
                  'borderBottom',
                  'borderBottomColor',
                  'borderBottomStyle',
                  'borderBottomWidth',
                  'borderCollapse',
                  'borderColor',
                  'borderColorDark',
                  'borderColorLight',
                  'borderLeft',
                  'borderLeftColor',
                  'borderLeftStyle',
                  'borderLeftWidth',
                  'borderRight',
                  'borderRightColor',
                  'borderRightStyle',
                  'borderRightWidth',
                  'borderStyle',
                  'borderTop',
                  'borderTopColor',
                  'borderTopStyle',
                  'borderTopWidth',
                  'borderWidth',
                  'bottom',
                  'bottomMargin',
                  'browserLanguage',
                  'bufferDepth',
                  'button',
                  'call',
                  'caller',
                  'canHaveChildren',
                  'canHaveHTML',
                  'cancelBubble',
                  'caption',
                  'captureEvents',
                  'ceil',
                  'cellIndex',
                  'cellPadding',
                  'cellSpacing',
                  'cells',
                  'ch',
                  'chOff',
                  'charAt',
                  'charCodeAt',
                  'charset',
                  'checked',
                  'checked',
                  'childNodes',
                  'children',
                  'chooseColorDlg',
                  'cite',
                  'className',
                  'clear',
                  'clearAttributes',
                  'clearData',
                  'clearInterval',
                  'clearRequest',
                  'clearTimeout',
                  'click',
                  'clientHeight',
                  'clientInformation',
                  'clientLeft',
                  'clientTop',
                  'clientWidth',
                  'clientX',
                  'clientY',
                  'clip',
                  'clipBottom',
                  'clipLeft',
                  'clipRight',
                  'clipTop',
                  'clipboardData',
                  'cloneNode',
                  'close',
                  'closed',
                  'code',
                  'codeBase',
                  'codeType',
                  'colSpan',
                  'collapse',
                  'color',
                  'colorDepth',
                  'cols',
                  'commitChanges',
                  'compact',
                  'compareEndPoints',
                  'compatMode',
                  'compile',
                  'complete',
                  'componentFromPoint',
                  'concat',
                  'confirm',
                  'connectionSpeed',
                  'constructor',
                  'contains',
                  'content',
                  'contentEditable',
                  'contentOverflow',
                  'contentWindow',
                  'cookie',
                  'cookieEnabled',
                  'coords',
                  'cos',
                  'count',
                  'cpuClass',
                  'create',
                  'createAttribute',
                  'createCDATASection',
                  'createCaption',
                  'createComment',
                  'createControlRange',
                  'createDocumentFragment',
                  'createDocumentFromUrl',
                  'createElement',
                  'createEntityReference',
                  'createEventObject',
                  'createPopup',
                  'createProcessingInstruction',
                  'createRange',
                  'createRangeCollection',
                  'createStyleSheet',
                  'createTFoot',
                  'createTHead',
                  'createTextNode',
                  'createTextRange',
                  'cssText',
                  'ctrlKey',
                  'ctrlLeft',
                  'currentStyle',
                  'cursor',
                  'data',
                  'dataFld',
                  'dataFormatAs',
                  'dataPageSize',
                  'dataSrc',
                  'dataTransfer',
                  'dateTime',
                  'declare',
                  'decodeURI',
                  'decodeURIComponent',
                  'defaultCharset',
                  'defaultChecked',
                  'defaultSelected',
                  'defaultStatus',
                  'defaultValue',
                  'defaults',
                  'defer',
                  'deleteCaption',
                  'deleteData',
                  'deleteRow',
                  'deleteTFoot',
                  'deleteTHead',
                  'description',
                  'designMode',
                  'detachEvent',
                  'deviceXDPI',
                  'deviceYDPI',
                  'dialogArguments',
                  'dialogHeight',
                  'dialogLeft',
                  'dialogTop',
                  'dialogWidth',
                  'dimensions',
                  'dir',
                  'direction',
                  'disableExternalCapture',
                  'disabled',
                  'display',
                  'doImport',
                  'doReadRequest',
                  'doRequest',
                  'doScroll',
                  'doWriteRequest',
                  'doctype',
                  'document',
                  'documentElement',
                  'domain',
                  'dragDrop',
                  'dropEffect',
                  'duplicate',
                  'dynsrc',
                  'effectAllowed',
                  'elementFromPoint',
                  'elements',
                  'embeds',
                  'empty',
                  'enableExternalCapture',
                  'encodeURI',
                  'encodeURIComponent',
                  'encoding',
                  'enctype',
                  'escape',
                  'eval',
                  'event',
                  'exec',
                  'execCommand',
                  'execScript',
                  'exp',
                  'expando',
                  'external',
                  'face',
                  'fgColor',
                  'fileCreatedDate',
                  'fileModifiedDate',
                  'fileSize',
                  'fileUpdatedDate',
                  'filter',
                  'filters',
                  'find',
                  'findText',
                  'fireEvent',
                  'firstChild',
                  'firstPage',
                  'fixed',
                  'floor',
                  'focus',
                  'font',
                  'fontFamily',
                  'fontSize',
                  'fontSmoothingEnabled',
                  'fontStyle',
                  'fontVariant',
                  'fontWeight',
                  'fontcolor',
                  'fontsize',
                  'forEach',
                  'form',
                  'forms',
                  'forward',
                  'frame',
                  'frameBorder',
                  'frameSpacing',
                  'frames',
                  'fromCharCode',
                  'fromElement',
                  'galleryImg',
                  'getAdjacentText',
                  'getAttribute',
                  'getAttributeNode',
                  'getBookmark',
                  'getBoundingClientRect',
                  'getCharset',
                  'getClientRects',
                  'getComponentVersion',
                  'getData',
                  'getDate',
                  'getDay',
                  'getElementById',
                  'getElementsByName',
                  'getElementsByTagName',
                  'getExpression',
                  'getFullYear',
                  'getHours',
                  'getMilliseconds',
                  'getMinutes',
                  'getMonth',
                  'getNamedItem',
                  'getSeconds',
                  'getSelection',
                  'getTime',
                  'getTimezoneOffset',
                  'getUTCDate',
                  'getUTCDay',
                  'getUTCFullYear',
                  'getUTCHours',
                  'getUTCMilliseconds',
                  'getUTCMinutes',
                  'getUTCMonth',
                  'getUTCSeconds',
                  'getUTCYear',
                  'getVarDate',
                  'getYear',
                  'global',
                  'go',
                  'handleEvent',
                  'hasChildNodes',
                  'hasFeature',
                  'hasFocus',
                  'hasLayout',
                  'hasOwnProperty',
                  'hash',
                  'headers',
                  'height',
                  'hidden',
                  'hide',
                  'hideFocus',
                  'history',
                  'home',
                  'host',
                  'hostname',
                  'href',
                  'hreflang',
                  'hspace',
                  'htmlFor',
                  'htmlText',
                  'httpEquiv',
                  'id',
                  'ignoreCase',
                  'images',
                  'imeMode',
                  'implementation',
                  'imports',
                  'inRange',
                  'indeterminate',
                  'index',
                  'indexOf',
                  'innerHTML',
                  'innerText',
                  'input',
                  'insertAdjacentElement',
                  'insertAdjacentHTML',
                  'insertAdjacentText',
                  'insertBefore',
                  'insertData',
                  'insertRow',
                  'isComponentInstalled',
                  'isContentEditable',
                  'isDisabled',
                  'isEqual',
                  'isFinite',
                  'isMap',
                  'isMultiLine',
                  'isNaN',
                  'isOpen',
                  'isPrototypeOf',
                  'isTextEdit',
                  'italics',
                  'item',
                  'javaEnabled',
                  'join',
                  'keyCode',
                  'label',
                  'lang',
                  'language',
                  'lastChild',
                  'lastIndex',
                  'lastIndexOf',
                  'lastMatch',
                  'lastModified',
                  'lastPage',
                  'lastParen',
                  'layoutFlow',
                  'layoutGrid',
                  'layoutGridChar',
                  'layoutGridLine',
                  'layoutGridMode',
                  'layoutGridType',
                  'lbound',
                  'left',
                  'leftContext',
                  'leftMargin',
                  'length',
                  'letterSpacing',
                  'lineBreak',
                  'lineHeight',
                  'link',
                  'linkColor',
                  'links',
                  'listStyle',
                  'listStyleImage',
                  'listStylePosition',
                  'listStyleType',
                  'load',
                  'location',
                  'log',
                  'logicalXDPI',
                  'logicalYDPI',
                  'longDesc',
                  'loop',
                  'lowsrc',
                  'map',
                  'margin',
                  'marginBottom',
                  'marginHeight',
                  'marginLeft',
                  'marginRight',
                  'marginTop',
                  'marginWidth',
                  'match',
                  'max',
                  'maxLength',
                  'media',
                  'mergeAttributes',
                  'message',
                  'method',
                  'mimeType',
                  'mimeTypes',
                  'min',
                  'minHeight',
                  'move',
                  'moveAbove',
                  'moveBelow',
                  'moveBy',
                  'moveEnd',
                  'moveFirst',
                  'moveNext',
                  'moveRow',
                  'moveStart',
                  'moveTo',
                  'moveToAbsolute',
                  'moveToBookmark',
                  'moveToElementText',
                  'moveToPoint',
                  'multiline',
                  'multiple',
                  'n',
                  'name',
                  'nameProp',
                  'namedItem',
                  'namedRecordset',
                  'namespaces',
                  'navigate',
                  'navigator',
                  'nextPage',
                  'nextSibling',
                  'noHref',
                  'noResize',
                  'noShade',
                  'noWrap',
                  'nodeName',
                  'nodeType',
                  'nodeValue',
                  'normalize',
                  'number',
                  'object',
                  'offscreenBuffering',
                  'offsetHeight',
                  'offsetLeft',
                  'offsetParent',
                  'offsetTop',
                  'offsetWidth',
                  'offsetX',
                  'offsetY',
                  'onLine',
                  'onactivate',
                  'onafterprint',
                  'onafterupdate',
                  'onbeforeactivate',
                  'onbeforecopy',
                  'onbeforecut',
                  'onbeforedeactivate',
                  'onbeforeeditfocus',
                  'onbeforepaste',
                  'onbeforeprint',
                  'onbeforeunload',
                  'onbeforeupdate',
                  'onblur',
                  'oncellchange',
                  'onclick',
                  'oncontextmenu',
                  'oncontrolselect',
                  'oncopy',
                  'oncut',
                  'ondataavailable',
                  'ondatasetchanged',
                  'ondatasetcomplete',
                  'ondblclick',
                  'ondeactivate',
                  'ondrag',
                  'ondragend',
                  'ondragenter',
                  'ondragleave',
                  'ondragover',
                  'ondragstart',
                  'ondrop',
                  'onerror',
                  'onerrorupdate',
                  'onfilterchange',
                  'onfocus',
                  'onfocusin',
                  'onfocusout',
                  'onhelp',
                  'onkeydown',
                  'onkeypress',
                  'onkeyup',
                  'onlayoutcomplete',
                  'onload',
                  'onlosecapture',
                  'onmousedown',
                  'onmouseenter',
                  'onmouseleave',
                  'onmousemove',
                  'onmouseout',
                  'onmouseover',
                  'onmouseup',
                  'onmousewheel',
                  'onmove',
                  'onmoveend',
                  'onmovestart',
                  'onpage',
                  'onpaste',
                  'onpropertychange',
                  'onreadystatechange',
                  'onresize',
                  'onresizeend',
                  'onresizestart',
                  'onrowenter',
                  'onrowexit',
                  'onrowsdelete',
                  'onrowsinserted',
                  'onscroll',
                  'onselect',
                  'onselectionchange',
                  'onselectstart',
                  'onstop',
                  'onunload',
                  'open',
                  'opener',
                  'opsProfile',
                  'options',
                  'outerHTML',
                  'outerText',
                  'overflow',
                  'overflowX',
                  'overflowY',
                  'ownerDocument',
                  'owningElement',
                  'padding',
                  'paddingBottom',
                  'paddingLeft',
                  'paddingRight',
                  'paddingTop',
                  'pageBreakAfter',
                  'pageBreakBefore',
                  'pages',
                  'palette',
                  'parent',
                  'parentElement',
                  'parentNode',
                  'parentStyleSheet',
                  'parentTextEdit',
                  'parentWindow',
                  'parse',
                  'parseFloat',
                  'parseInt',
                  'pasteHTML',
                  'pathname',
                  'pause',
                  'pixelBottom',
                  'pixelHeight',
                  'pixelLeft',
                  'pixelTop',
                  'pixelWidth',
                  'platform',
                  'plugins',
                  'pluginspage',
                  'pop',
                  'port',
                  'posBottom',
                  'posHeight',
                  'posLeft',
                  'posRight',
                  'posTop',
                  'posWidth',
                  'position',
                  'pow',
                  'preference',
                  'previousPage',
                  'previousSibling',
                  'print',
                  'profile',
                  'prompt',
                  'propertyName',
                  'protocol',
                  'protocolLong',
                  'prototype',
                  'pseudoClass',
                  'push',
                  'qualifier',
                  'queryCommandEnabled',
                  'queryCommandIndeterm',
                  'queryCommandState',
                  'queryCommandSupported',
                  'queryCommandValue',
                  'random',
                  'readOnly',
                  'readyState',
                  'reason',
                  'recalc',
                  'recordNumber',
                  'recordset',
                  'referrer',
                  'refresh',
                  'rel',
                  'releaseCapture',
                  'releaseEvents',
                  'reload',
                  'remove',
                  'removeAttribute',
                  'removeAttributeNode',
                  'removeBehavior',
                  'removeChild',
                  'removeExpression',
                  'removeNamedItem',
                  'removeNode',
                  'removeRule',
                  'repeat',
                  'replace',
                  'replaceAdjacentText',
                  'replaceChild',
                  'replaceData',
                  'replaceNode',
                  'reset',
                  'resizeBy',
                  'resizeTo',
                  'result',
                  'resume',
                  'returnValue',
                  'rev',
                  'reverse',
                  'right',
                  'rightContext',
                  'rightMargin',
                  'round',
                  'routeEvent',
                  'rowIndex',
                  'rowSpan',
                  'rows',
                  'rubyAlign',
                  'rubyOverhang',
                  'rubyPosition',
                  'rules',
                  'runtimeStyle',
                  'save',
                  'saveType',
                  'scheme',
                  'scope',
                  'scopeName',
                  'screen',
                  'screenLeft',
                  'screenTop',
                  'screenX',
                  'screenY',
                  'scripts',
                  'scroll',
                  'scrollAmount',
                  'scrollBy',
                  'scrollDelay',
                  'scrollHeight',
                  'scrollIntoView',
                  'scrollLeft',
                  'scrollTo',
                  'scrollTop',
                  'scrollWidth',
                  'scrollbar3dLightColor',
                  'scrollbarArrowColor',
                  'scrollbarBaseColor',
                  'scrollbarDarkShadowColor',
                  'scrollbarFaceColor',
                  'scrollbarHighlightColor',
                  'scrollbarShadowColor',
                  'scrollbarTrackColor',
                  'scrolling',
                  'search',
                  'sectionRowIndex',
                  'security',
                  'select',
                  'selected',
                  'selectedIndex',
                  'selection',
                  'selector',
                  'selectorText',
                  'self',
                  'setActive',
                  'setAttribute',
                  'setAttributeNode',
                  'setCapture',
                  'setData',
                  'setDate',
                  'setEndPoint',
                  'setExpression',
                  'setFullYear',
                  'setHours',
                  'setInterval',
                  'setMilliseconds',
                  'setMinutes',
                  'setMonth',
                  'setNamedItem',
                  'setSeconds',
                  'setTime',
                  'setTimeout',
                  'setUTCDate',
                  'setUTCFullYear',
                  'setUTCHours',
                  'setUTCMilliseconds',
                  'setUTCMinutes',
                  'setUTCMonth',
                  'setUTCSeconds',
                  'setUTCYear',
                  'setYear',
                  'shape',
                  'shift',
                  'shiftKey',
                  'show',
                  'showHelp',
                  'showModalDialog',
                  'showModelessDialog',
                  'sin',
                  'size',
                  'slice',
                  'small',
                  'sort',
                  'source',
                  'sourceIndex',
                  'span',
                  'specified',
                  'splice',
                  'split',
                  'splitText',
                  'sqrt',
                  'src',
                  'srcElement',
                  'srcFilter',
                  'standby',
                  'start',
                  'status',
                  'stop',
                  'strike',
                  'style',
                  'styleFloat',
                  'styleSheets',
                  'style_Str',
                  'sub',
                  'submit',
                  'substr',
                  'substring',
                  'substringData',
                  'summary',
                  'sup',
                  'swapNode',
                  'systemLanguage',
                  'tabIndex',
                  'tabStop',
                  'tableLayout',
                  'tagName',
                  'tagUrn',
                  'tags',
                  'taint',
                  'taintEnabled',
                  'tan',
                  'target',
                  'tbodies',
                  'test',
                  'text',
                  'textAlign',
                  'textAlignLast',
                  'textAutospace',
                  'textDecoration',
                  'textDecorationBlink',
                  'textDecorationLineThrough',
                  'textDecorationNone',
                  'textDecorationOverline',
                  'textDecorationUnderline',
                  'textIndent',
                  'textJustify',
                  'textJustifyTrim',
                  'textKashida',
                  'textKashidaSpace',
                  'textOverflow',
                  'textTransform',
                  'textUnderlinePosition',
                  'tfoot',
                  'thead',
                  'title',
                  'toElement',
                  'toExponential',
                  'toFixed',
                  'toGMTString',
                  'toLocaleString',
                  'toLowerCase',
                  'toPrecision',
                  'toSource',
                  'toString',
                  'toUTCString',
                  'toUpperCase',
                  'toVarDate',
                  'top',
                  'topMargin',
                  'trueSpeed',
                  'type',
                  'typeDetail',
                  'typeof',
                  'unescape',
                  'unicodeBidi',
                  'uniqueID',
                  'uniqueNumber',
                  'units',
                  'unselectable',
                  'unshift',
                  'untaint',
                  'updateInterval',
                  'url',
                  'urn',
                  'urns',
                  'useMap',
                  'userAgent',
                  'userLanguage',
                  'userProfile',
                  'vAlign',
                  'vLink',
                  'value',
                  'valueOf',
                  'valueType',
                  'vcard_name',
                  'version',
                  'verticalAlign',
                  'viewInheritStyle',
                  'viewLink',
                  'viewMasterTab',
                  'visibility',
                  'vlinkColor',
                  'volume',
                  'vrml',
                  'vspace',
                  'wheelDelta',
                  'whiteSpace',
                  'whiteSpace',
                  'width',
                  'window',
                  'wordBreak',
                  'wordSpacing',
                  'wordWrap',
                  'wrap',
                  'write',
                  'writeln',
                  'writingMode',
                  'x',
                  'y',
                  'zIndex',
                  'zOrder',
                  'zoom'
    ];
}
})();
"))

(defun moz-plus-init-MOZPLUS ()
  (moz-plus-send-string-no-prompt moz-plus-init-js)
  (moz-plus-send-string-quietly (moz-plus-build-str-with-repl-print "'\\nMOZPLUS init done. created object repl.MOZPLUS for completion'")))

(define-minor-mode moz-plus "" nil " moz-plus" (moz-plus-setup-keymap) (moz-plus-mode-init))

(provide 'moz-plus)
