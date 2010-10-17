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
*日本語入力を自動的にoffにしたい「コンテキスト」にいればtを返す関数を登録する。")

(custom-autoload (quote context-skk-context-check-hook) "context-skk" t)

(defvar context-skk-custumize-functions (quote (context-skk-customize-kutouten)) "\
*skkによる入力開始直前に、入力のカスタマイズを行うための関数を登録する。
関数は以下の形式のデータを要素とするリストを返すものとする: 

  (VARIABLE VALUE)

`skk-insert'をかこむ`let'によってVARIABLEはVALUEに束縛される。
特にその場でカスタマイズすべき変数がない場合 `nil'を返せば良い。
関数には何も引数が渡されない。")

(custom-autoload (quote context-skk-custumize-functions) "context-skk" t)

(defvar context-skk-programming-mode (quote (ada-mode antlr-mode asm-mode autoconf-mode awk-mode c-mode objc-mode java-mode idl-mode pike-mode cperl-mode delphi-mode f90-mode fortran-mode icon-mode idlwave-mode inferior-lisp-mode lisp-mode m4-mode makefile-mode metafont-mode modula-2-mode octave-mode pascal-mode perl-mode prolog-mode ps-mode postscript-mode ruby-mode scheme-mode sh-mode simula-mode tcl-mode vhdl-mode emacs-lisp-mode)) "\
*context-skkにて「プログラミングモード」とみなすモードのリスト")

(custom-autoload (quote context-skk-programming-mode) "context-skk" t)
 (autoload 'context-skk-mode "context-skk" "文脈に応じて自動的にskkの入力モードをlatinに切り換えるマイナーモード。" t)

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
最後に確定した語に annotation を付ける。
既に付けられている annotation があればそれを編集バッファに出力する。
no-previous-annotation を指定すると (C-u M-x skk-annotation-add で指定可)
既に付けられている annotation を編集バッファに出力しない。

\(fn &optional NO-PREVIOUS-ANNOTATION)" t nil)

(autoload (quote skk-annotation-remove) "skk-annotation" "\
最後に確定した語から annotation を取り去る。

\(fn)" t nil)

(autoload (quote skk-annotation-display-p) "skk-annotation" "\
Not documented

\(fn TEST)" nil nil)

(autoload (quote skk-annotation-toggle-display-p) "skk-annotation" "\
Not documented

\(fn)" t nil)

(autoload (quote skk-annotation-quote) "skk-annotation" "\
最後に確定した語に含まれる `;' を候補の一部として quote する。

\(fn &optional QUIET)" t nil)

(autoload (quote skk-annotation-wikipedia) "skk-annotation" "\
Wiktionary/Wikipedia の WORD に相当する記事からアノテーションを取得する。

\(fn WORD &optional SOURCES)" nil nil)

(autoload (quote skk-annotation-treat-wikipedia) "skk-annotation" "\
WORD が挿入されるときに表示されるべき注釈を生成する。
生成した注釈を返す。

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
▽モードで読みの補完を行なった後、変換する。
それ以外のモードではオリジナルのキーマップに割り付けられたコマンドをエミュレー
トする。

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
SKK 辞書フォーマットの FILE から補完候補を得る。

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
入力が空の時に履歴から補完する。
対象は現在の Emacs のセッションにおいて行なった送り無し変換のうち、
`skk-kakutei-history-limit' で指定される最近のものである。

\(fn)" nil nil)

(autoload (quote skk-comp-smart-find) "skk-comp" "\
`smart-find' が見つけたファイル名で補完する

\(fn &optional PATH)" nil nil)

(autoload (quote skk-search-smart-find) "skk-comp" "\
`smart-find'を利用した変換を行なう。
SKK abbrev モードにて、英文字 + skk-completion-search-char (~)で
未完スペルを指定して変換すると、補完候補が変換候補として出現する。
デフォルトでは SKK abbrev モードのみで有効な機能だが、
NOT-ABBREV-ONLY を指定する事で常に有効となる。

\(fn &optional PATH NOT-ABBREV-ONLY WITHOUT-CHAR-MAYBE)" nil nil)

(autoload (quote skk-comp-lisp-symbol) "skk-comp" "\
Lisp symbol 名で補完する。
PREDICATE に引数 1 個の関数を指定すれば、PREDICATE を満たすシンボル
に限って補完する。PREDICATE には `fboundp', `boundpp', `commandp'
などが指定できる。指定しなければ関数または変数に限って補完する。

\(fn &optional PREDICATE)" nil nil)

(autoload (quote skk-search-lisp-symbol) "skk-comp" "\
Lisp symbol 名で補完した結果を検索結果として返す。
PREDICATE に引数 1 個の関数を指定すれば、PREDICATE を満たすシンボル
に限って補完する。PREDICATE には `fboundp', `boundpp', `commandp'
などが指定できる。指定しなければ関数または変数に限って補完する。
SKK abbrev モードにて、英文字 + skk-completion-search-char (~)で
未完スペルを指定して変換すると、補完候補が変換候補として出現する。
デフォルトでは SKK abbrev モードのみで有効な機能だが、
NOT-ABBREV-ONLY を指定する事で常に有効となる。

\(fn &optional PREDICATE NOT-ABBREV-ONLY WITHOUT-CHAR-MAYBE)" nil nil)

(autoload (quote skk-completion-search) "skk-comp" "\
変換キーで補完を行い、得られた各見出しでさらに検索する。
COMP-PROG-LIST は `skk-completion-prog-list' と同じ形式で、
これに含まれる補完関数によって、まず変換キーから見出しのリストを得る。
SEARCH-PROG-LIST は `skk-search-prog-list' と同じ形式で、
補完関数によって得た見出しをこれに含まれる検索関数により変換候補を得る。
デフォルトでは、補完によって得られた見出しと対応する候補はセットであるが、
WITHOUT-MIDASI を指定すると見出しは省かれる。

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
SKK のバグレポートを書くメールバッファを用意する。
mail-user-agent を設定することにより好みのメールインターフェイスを使用すること
ができる。例えば、Wanderlust を使用したい場合は下記のように設定する。

    (setq mail-user-agent 'wl-user-agent) 

\(fn)" t nil)

(add-hook (quote before-init-hook) (function (lambda nil (eval-after-load "font-lock" (quote (setq lisp-font-lock-keywords-2 (nconc (list (list (concat "(\\(\\(skk-\\)?def\\(" "\\(un-cond\\|subst-cond\\|advice\\|" "macro-maybe\\|alias-maybe\\|un-maybe\\)\\|" "\\(var\\|localvar\\)" "\\)\\)\\>" "[ 	'(]*" "\\(\\sw+\\)?") (quote (1 font-lock-keyword-face)) (quote (6 (cond ((match-beginning 4) font-lock-function-name-face) ((match-beginning 5) font-lock-variable-name-face)) nil t)))) (list (list (concat "(" (regexp-opt (quote ("skk-save-point" "skk-with-point-move" "skk-loop-for-buffers" "static-if" "static-when" "static-unless" "static-cond")) t) "\\>") (quote (1 font-lock-keyword-face)))) (list (list "(\\(skk-error\\)\\>" (quote (1 font-lock-warning-face)))) lisp-font-lock-keywords-2)))) (put (quote skk-deflocalvar) (quote doc-string-elt) 3) (put (quote skk-defadvice) (quote doc-string-elt) 3) (put (quote defun-maybe) (quote doc-string-elt) 3) (put (quote defmacro-maybe) (quote doc-string-elt) 3) (put (quote defalias-maybe) (quote doc-string-elt) 3))))

;;;***

;;;### (autoloads (skk-dic-setup-buffer skk-search-small-dic) "skk-dic"
;;;;;;  "skk-dic.el" (17962 51878))
;;; Generated autoloads from skk-dic.el

(autoload (quote skk-search-small-dic) "skk-dic" "\
`skk-henkan-key' について `skk-dic-buffer' を検索し、候補のリストを返す。
`skk-search-prog-list' の要素に `(skk-search-small-dic)' を指定して利用する。
SKK インストール時にインストーラが SKK-JISYO.S を見つけたら、skk-dic.el
ロード時に `skk-dic-buffer' は自動的に設定される。

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
`current-time-string' の出力を加工し、現在の日時 (string)を返す。
オプショナル引数の PP-FUNCTION を指定すると、`skk-current-date-1'
の返り値、FORMAT と AND-TIME を引数にして `funcall' する。
PP-FUNCTION の指定がない場合は `skk-default-current-date-function' を
`funcall' する。
FORMAT は `format' の第一引数の様式 (string)による出力指定テンプレート。
AND-TIME (boolean) を指定すると時刻も返す。
`skk-today' と `skk-clock' のサブルーチン。

\(fn &optional PP-FUNCTION FORMAT AND-TIME)" nil nil)

(autoload (quote skk-default-current-date) "skk-gadget" "\
日付情報の標準的な出力をする他、ユーザにある程度のカスタマイズ機能を提供する。
この関数の引数でカスタマイズできない出力を希望する場合は、
`skk-default-current-date-function' に自前の関数を指定する。

DATE-INFORMATION は `current-time-string' が返した文字列を

  (year month day day-of-week hour minute second)

の形式で変換したリスト (各要素は文字列)。
FORMAT は `format' の第一引数の様式による出力形態を指定する文字列。
  nil であれば \"%s年%s月%s日(%s)%s時%s分%s秒\" (もしくは
  \"%s年%s月%s日(%s)\" が使われる。
NUM-TYPE (number) は
  0 -> 無変換,
  1 -> 全角数字へ変換,
  2 -> 漢数字へ変換 (位取りなし),
  3 -> 漢数字へ変換 (位取りをする),
  4 -> その数字そのものをキーにして辞書を再検索,
  5 -> 漢数字 (手形などで使用する文字を使用)へ変換 (位取りをする),
  9 -> 将棋で使用する数字 (\"３四\" など) に変換
GENGO は元号表示するかどうか (boolean)。
GENGO-INDEX は `skk-gengo-alist' の各要素の cadr を 0 とする index
 (number)。nil であれば `current-time-string' の出力のまま無変換。
MONTH-ALIST-INDEX は `skk-month-alist' の各要素の cadr を 0 とする
 index (number)。nil であれば `current-time-string' の出力のまま無変換。
DAYOFWEEK-ALIST-INDEX は `skk-day-of-week-alist' の各要素の cadr を
 0 とする index (number)。nil であれば `current-time-string' の出力のま
ま無変換。
AND-TIME は時刻も表示するかどうか (boolean)。

\(fn DATE-INFORMATION FORMAT NUM-TYPE GENGO GENGO-INDEX MONTH-ALIST-INDEX DAYOFWEEK-ALIST-INDEX &optional AND-TIME)" nil nil)

(autoload (quote skk-today) "skk-gadget" "\
`current-time-string' の出力を加工し、現在の日時を表す文字列を作り、挿入する。
実質的に today エントリの呼出しなので、個人辞書の today エントリによりカスタマ
イズすることができる。

\(fn ARG)" t nil)

(autoload (quote skk-clock) "skk-gadget" "\
デジタル時計をミニバッファに表示する。
quit するとその時点の日時を候補として挿入する。
quit したときに起動してからの経過時間をミニバッファに表示する。
interactive に起動する他、\"clock /(skk-clock)/\" などのエントリを SKK の辞書
に加え、\"/clock\"+ SPC で変換することによっても起動可。C-g で止まる。
実行変換で起動した場合は、C-g した時点の時点の日時を挿入する。
オプショナル引数の KAKUTEI-WHEN-QUIT が non-nil であれば C-g したときに確
定する。
オプショナル引数の TIME-SIGNAL が non-nil であれば、NTT の時報風に ding する。
それぞれ \"clock /(skk-clock nil t)/\" のようなエントリを辞書に挿入すれば良い。
skk-date-ad と skk-number-style によって表示方法のカスタマイズが可能。

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
`skk-units-alist'を参照し、換算を行なう。
NUMBER について UNIT-FROM から UNIT-TO への換算を行なう。

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
SKK のモードを JIS X 0201 モードに変更する。

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
領域の漢字、送り仮名を全てひらがなに変換する。
オプショナル引数の ALL が non-nil ならば、複数の候補がある場合は、\"{}\" でく
くって表示する。
例えば、
    中島 -> {なかしま|なかじま}

\(fn START END &optional ALL)" t nil)

(autoload (quote skk-gyakubiki-message) "skk-kakasi" "\
領域の漢字、送り仮名を全てひらがなに変換後、エコーする。
オプショナル引数の ALL が non-nil ならば、複数の候補がある場合は、\"{}\" でく
くって表示する。
例えば、
    中島 -> {なかしま|なかじま}

\(fn START END &optional ALL)" t nil)

(autoload (quote skk-gyakubiki-katakana-region) "skk-kakasi" "\
領域の漢字、送り仮名を全てカタカナに変換する。
オプショナル引数の ALL が non-nil ならば、複数の候補がある場合は、\"{}\" でく
くって表示する。
例えば、
    中島 -> {ナカシマ|ナカジマ}

\(fn START END &optional ALL)" t nil)

(autoload (quote skk-gyakubiki-katakana-message) "skk-kakasi" "\
領域の漢字、送り仮名を全てカタカナに変換後、エコーする。
オプショナル引数の ALL が non-nil ならば、複数の候補がある場合は、\"{}\" でく
くって表示する。
例えば、
    中島 -> {ナカシマ|ナカジマ}

\(fn START END &optional ALL)" t nil)

(autoload (quote skk-hurigana-region) "skk-kakasi" "\
領域の漢字に全てふりがなを付ける。
例えば、
   \"変換前の漢字の脇に\" -> \"変換前[へんかんまえ]の漢字[かんじ]の脇[わき]に\"

オプショナル引数の ALL が non-nil ならば、複数の候補がある場合は、\"{}\" でく
くって表示する。
例えば、
    \"中島\" -> \"中島[{なかしま|なかじま}]\"

\(fn START END &optional ALL)" t nil)

(autoload (quote skk-hurigana-message) "skk-kakasi" "\
領域の漢字に全てふりがなを付け、エコーする。
例えば、
   \"変換前の漢字の脇に\" -> \"変換前[へんかんまえ]の漢字[かんじ]の脇[わき]に\"

オプショナル引数の ALL が non-nil ならば、複数の候補がある場合は、\"{}\" でく
くって表示する。
例えば、
    \"中島\" -> \"中島[{なかしま|なかじま}]\"

\(fn START END &optional ALL)" t nil)

(autoload (quote skk-hurigana-katakana-region) "skk-kakasi" "\
領域の漢字に全てフリガナを付ける。
例えば、
   \"変換前の漢字の脇に\" -> \"変換前[ヘンカンマエ]の漢字[カンジ]の脇[ワキ]に\"

オプショナル引数の ALL が non-nil ならば、複数の候補がある場合は、\"{}\" でく
くって表示する。
例えば、
    \"中島\" -> \"中島[{ナカシマ|ナカジマ}]\"

\(fn START END &optional ALL)" t nil)

(autoload (quote skk-hurigana-katakana-message) "skk-kakasi" "\
領域の漢字に全てフリガナを付け、エコーする。
例えば、
   \"変換前の漢字の脇に\" -> \"変換前[ヘンカンマエ]の漢字[カンジ]の脇[ワキ]に\"

オプショナル引数の ALL が non-nil ならば、複数の候補がある場合は、\"{}\" でく
くって表示する。
例えば、
    \"中島\" -> \"中島[{ナカシマ|ナカジマ}]\"

\(fn START END &optional ALL)" t nil)

(autoload (quote skk-romaji-region) "skk-kakasi" "\
領域の漢字、ひらがな、カタカナ、全英文字を全てローマ字に変換する。
変換には、ヘボン式を用いる。
例えば、
   \"漢字かな混じり文をローマ字に変換\"
    -> \"  kan'zi  kana  ma  ziri  bun'  woro-ma  zi ni hen'kan' \"

skk-romaji-*-by-hepburn が nil であれば、ローマ字への変換様式を訓令式に変更す
る。例えば、\"し\" はヘボン式では \"shi\" だが、訓令式では \"si\" となる。

\(fn START END)" t nil)

(autoload (quote skk-romaji-message) "skk-kakasi" "\
領域の漢字、ひらがな、カタカナ、全英文字を全てローマ字に変換し、エコーする。
変換には、ヘボン式を用いる。
例えば、
   \"漢字かな混じり文をローマ字に変換\"
    -> \"  kan'zi  kana  ma  ziri  bun'  woro-ma  zi ni hen'kan' \"

skk-romaji-*-by-hepburn が nil であれば、ローマ字への変換様式を訓令式に変更す
る。例えば、\"し\" はヘボン式では \"shi\" だが、訓令式では \"si\" となる。

\(fn START END)" t nil)

;;;***

;;;### (autoloads (skk-display-code-for-char-at-point skk-input-by-code-or-menu)
;;;;;;  "skk-kcode" "skk-kcode.el" (18210 32971))
;;; Generated autoloads from skk-kcode.el

(autoload (quote skk-input-by-code-or-menu) "skk-kcode" "\
7bit もしくは 8bit もしくは 区点コードに対応する 2byte 文字を挿入する。

\(fn &optional ARG)" t nil)

(autoload (quote skk-display-code-for-char-at-point) "skk-kcode" "\
ポイントにある文字の区点コード、JIS コード、EUC コード及びシフト JIS コード を表示する。

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
UNIX look コマンドを利用した変換を行なう。
SKK abbrev モードにて、英文字 + アスタリスクで uncompleted spelling を指定する。
詳しくは skk-look.el ファイルのコメントや Info を参照の事。
CONVERSION-ARGUMENTS は `skk-look-conversion-arguments' を
一時的に置き換えたい時に指定する。
デフォルトでは SKK abbrev モードのみで有効な機能だが、
NOT-ABBREV-ONLY を指定する事で常に有効となる。
EXPAND-NULL を指定すると、入力が \"*\" のみの時は
words ファイルにある全ての見出しが対象となる。
`skk-look-recursive-search', `skk-look-expanded-word-only',
`skk-look-use-ispell' を一時的に変更したい場合には
`let' により束縛して使う事。

\(fn &optional CONVERSION-ARGUMENTS NOT-ABBREV-ONLY EXPAND-NULL)" nil nil)

(autoload (quote skk-look-completion) "skk-look" "\
look コマンドを利用して補完候補を得る。
COMPLETION-ARGUMENTS は `skk-look-completion-arguments' を
一時的に置き換えたい時に指定する。
デフォルトでは SKK abbrev モードのみで有効な機能だが、
NOT-ABBREV-ONLY を指定する事で常に有効となる。
EXPAND-NULL を指定すると、入力が空である時に
words ファイルにある全ての見出しを返す。
`skk-look-use-ispell' を一時的に変更したい場合には
`let' により束縛して使う事。

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
KEY の中の連続する数字を現わす文字列を \"#\" に置き換えた文字列を返す。
\"12\" や \"０９\" など連続する数字を 1 つの \"#\" に置き換えることに注意。
置き換えた数字を `skk-num-list' の中にリストの形で保存する。
例えば、KEY が \"へいせい7年12がつ\" であれば、\"へいせい#ねん#がつ\"
と変換し、`skk-num-list' に (\"7\" \"12\") というリストを代入する。
辞書の見出し語の検索に使用する。

\(fn KEY)" nil nil)

(autoload (quote skk-num-convert) "skk-num" "\
INDEX が指す `skk-henkan-list' の要素を数値変換のために加工する。
`skk-henkan-list' の INDEX が指している候補 (数値変換キーの)を
  \"#2\" -> (\"#2\" .\"一\")
のように変換する。

\(fn INDEX)" nil nil)

(autoload (quote skk-num-multiple-convert) "skk-num" "\
Not documented

\(fn &optional COUNT)" nil nil)

(autoload (quote skk-num-exp) "skk-num" "\
ascii 数字 (string) の NUM を TYPE に従い変換し、変換後の文字列を返す。
TYPE は下記の通り。
0 -> 無変換
1 -> 全角数字へ変換
2 -> 漢数字へ変換 (位取りなし)
3 -> 漢数字へ変換 (位取りをする)
4 -> その数字そのものをキーにして辞書を再検索
5 -> 漢数字 (手形などで使用する文字を使用) へ変換 (位取りをする)
9 -> 将棋で使用する数字 (\"３四\" など) に変換

\(fn NUM TYPE)" nil nil)

(autoload (quote skk-num-uniq) "skk-num" "\
Not documented

\(fn)" nil nil)

(autoload (quote skk-num-initialize) "skk-num" "\
`skk-use-numeric-conversion' 関連の変数を初期化する。

\(fn)" nil nil)

(autoload (quote skk-num-henkan-key) "skk-num" "\
適切な変換キーを返す。
type4 の数値再変換が行なわれたときは、数値自身を返し、それ以外の数値変換
では、`skk-henkan-key' の数値を \"#\" で置き換えたキーを返す。

\(fn)" nil nil)

(autoload (quote skk-num-update-jisyo) "skk-num" "\
数字自身を見出し語として辞書のアップデートを行なう。

\(fn NOCONVWORD WORD &optional PURGE)" nil nil)

(autoload (quote skk-num) "skk-num" "\
数字を `skk-number-style' の値に従い変換する。
`skk-current-date' のサブルーチン。

\(fn STR)" nil nil)

;;;***

;;;### (autoloads (skk-obsolete-put-obsolete-mark skk-obsolete-check-all-files
;;;;;;  skk-obsolete-check) "skk-obsolete" "skk-obsolete.el" (18147
;;;;;;  14268))
;;; Generated autoloads from skk-obsolete.el

(autoload (quote skk-obsolete-check) "skk-obsolete" "\
FILE 内の obsolete 変数名と obsolete 関数名をチェックし、書換える。

\(fn FILE)" t nil)

(autoload (quote skk-obsolete-check-all-files) "skk-obsolete" "\
関連ファイル全ての obsolete 変数名と obsolete 関数名をチェックし、書換える。
C-u M-x skk-obsolete-check-all-files のように起動したときは、ディフォルトディレ
クトリにある SKK プログラムファイルもチェックを行なう。

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
サーバーコンプリーションを行い、得られた各見出しでさらに検索する。
送り有り変換には非対応。

\(fn)" nil nil)

(autoload (quote skk-comp-by-server-completion) "skk-server-completion" "\
Server completion に対応した SKK サーバを利用する補完プログラム。
`skk-completion-prog-list' の要素に指定して使う。

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
skk-search-server のサブルーチン。

\(fn FILE LIMIT)" nil nil)

(autoload (quote skk-adjust-search-prog-list-for-server-search) "skk-server" "\
変数 `skk-search-prog-list' を調整する。
`skk-server-host' もしくは `skk-servers-list' が nil であれば、
`skk-search-prog-list' から `skk-search-server' を car に持つリストを消す。
non-nil であれば、加える。

\(fn &optional NON-DEL)" nil nil)

(autoload (quote skk-disconnect-server) "skk-server" "\
サーバーを切り離す。

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
Non-nil ならば、SKK を前もってロードする。
これによって初回起動が高速になる。")

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
日本語入力モード。
マイナーモードの一種で、オリジナルのモードには影響を与えない。
負の引数を与えると SKK モードから抜ける。

An input mode for Japanese, converting romanized phonetic strings to kanji.

A minor mode, it should not affect the use of any major mode or
orthogonal minor modes.

In the initial SKK mode, hiragana submode, the mode line indicator is
\"かな\".  Lowercase romaji inputs are automatically converted to
hiragana where possible.  The lowercase characters `q' and `l' change
submodes of SKK, and `x' is used as a prefix indicating a small kana.

`q' is used to toggle between hiragana and katakana (mode line
indicator \"カナ\") input submodes.

`l' is used to enter ASCII submode (mode line indicator \"SKK\").
Uppercase `L' enters JISX0208 latin (wide ASCII) submode (mode line
indicator \"全英\").  `
' returns to hiragana submode from either
ASCII submode.

Kanji conversion is complex, but the basic principle is that the user
signals the appropriate stem to be matched against dictionary keys by
the use of uppercase letters.  Because SKK does not use grammatical
information, both the beginning and the end of the stem must be marked.

For non-inflected words (eg, nouns) consisting entirely of kanji, the
simplest way to invoke conversion is to enter the reading of the kanji,
the first character only in uppercase.  A leading \"▽\" indicates that
kanji conversion is in progress.  After entering the reading, press
space.  This invokes dictionary lookup, and the hiragana reading will be
redisplayed in kanji as the first candidate.  Pressing space again gives
the next candidate.  Further presses of space produce further candidates,
as well as a list of the next few candidates in the minibuffer.  Eg,
\"Benri\" => \"▽べんり\", and pressing space produces \"▼便利\" (the
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
=> \"▼強い\".  If no candidate is available at that point, the inflection
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
日本語入力モード。自動折り返し機能付き。
マイナーモードの一種で、オリジナルのモードには影響を与えない。
正の引数を与えると、強制的に `auto-fill-mode' 及び SKK モードに入る。
負の引数を与えると `auto-fill-mode' 及び SKK モードから抜ける。

\(fn &optional ARG)" t nil)

(autoload (quote skk-compile-rule-list) "skk" "\
rule list を木の形にコンパイルする。

\(fn &rest RULE-LISTS)" nil nil)

(autoload (quote skk-henkan-on-message) "skk" "\
Not documented

\(fn)" nil nil)

(autoload (quote skk-remove-duplicates) "skk" "\
LIST から重複をなくしたリストを返す。

\(fn LIST)" nil nil)

(autoload (quote skk-preload) "skk" "\
変数 `skk-preload' が非 nil のとき、`after-init-hook' から呼ばれる。
あらかじめ SKK を呼んでおくことで、 SKK の初回起動を速くする。

\(fn)" nil nil)

(add-hook (quote after-init-hook) (function (lambda nil (when (and (symbol-value (quote init-file-user)) skk-preload) (skk-preload)))) t)

;;;***

;;;### (autoloads (skk-study-read skk-study-save skk-study-update
;;;;;;  skk-study-search) "skk-study" "skk-study.el" (17962 51878))
;;; Generated autoloads from skk-study.el

(autoload (quote skk-study-search) "skk-study" "\
学習データを参照して ENTRY を加工し、関連性のある語の優先順位を上げて返す。

\(fn HENKAN-BUFFER MIDASI OKURIGANA ENTRY)" nil nil)

(autoload (quote skk-study-update) "skk-study" "\
MIDASI と WORD について `skk-study-data-ring' の最初の関連語を関連付けて学習する。

\(fn HENKAN-BUFFER MIDASI OKURIGANA WORD PURGE)" nil nil)

(autoload (quote skk-study-save) "skk-study" "\
`skk-study-file' に学習結果を保存する。
オプショナル引数の NOMSG が non-nil であれば、保存メッセージを出力しない。

\(fn &optional NOMSG)" t nil)

(autoload (quote skk-study-read) "skk-study" "\
`skk-study-file' から学習結果を読み込む。
オプショナル引数の FORCE が non-nil であれば、破棄の確認をしない。

\(fn &optional NOMSG FORCE)" t nil)

;;;***
(provide 'skk-autoloads)
;;; skk-autoloads.el ends here
