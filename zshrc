# path
export PATH=/usr/local/bin:~/bin:~/co/commands/bin:$PATH
# export PATH=/opt/local/bin:$PATH

# mactex
export PATH=/usr/texbin:$PATH

# flex
export PATH=/Applications/flex_sdk_3.4/bin:$PATH

# android
export PATH=/Users/fkd/Downloads/android-sdk-mac_x86-1.5_r2/tools:$PATH

# ruby
export PATH=~/.gem/ruby/1.9.1/bin:/usr/local/Cellar/ruby/1.9.2-p0/bin:~/.gem/ruby/1.8/bin:~/.gem/ruby/1.9/bin:$PATH

# python
export PYTHONPATH="/usr/local/lib/python2.6/site-packages/:$PYTHONPATH"

# rsense
export PATH=~/.emacs.d/etc/rsense-0.3/bin/:$PATH

# pkg-config
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:${PKG_CONFIG_PATH}

# npm
export PATH=/usr/local/share/npm/bin:$PATH

if [ "$TERM" != "dumb" ]; then
# プロンプトの設定　右にpwd出したり
case $UID in
    0) PROMPT="%# " ;; # root
    *) PROMPT="%% " ;;
esac
PROMPT2="%_> "
SPROMPT="%r is correct? [n,y,a,e]: "

fi


# chshとかcrontab -eとかで使うエディタ
#export ALTERNATE_EDITOR=emacs
# svnで使うエディタ
export SVN_EDITOR=emacsclient
#require rubygems
# export RUBYOPT="rubygems"

# alias
alias du="du -h"
alias screen="screen -U"
alias l="ls"
alias la="ls -a"
alias ll="ls -lh"
alias lla="ls -lha"
# alias emacs="emacs -nw"
alias cp="cp -v"
# alias ruby="ruby -Ku"
# alias irb="irb -Ku"
alias o="open ."
alias perlcode="perldoc -m"
alias killf="kill -9"

function e()
{
    emacsclient -n ${*:-.} 2>/dev/null || open -a /Applications/Emacs.app ${*:-.}
}

# proxy設定
# export http_proxy=http://proxy.ritsumei.ac.jp:3128
# export ftp_proxy=http://proxy.ritsumei.ac.jp:3128

# LANG
# export LANG=ja_JP.UTF-8
export LANG=en_US.UTF-8

fpath=(~/.functions ${fpath})

# 色をロード
autoload -U colors
colors
# compinit
autoload -U compinit
compinit
# cdを省略してchange directory
setopt auto_cd
# cd [tab]で履歴を表示
setopt auto_pushd
# コマンドを間違ったとき訂正する
setopt correct
# リストを詰めて表示
setopt list_packed
# ディレクトリを補完したとき/を付ける
setopt auto_param_slash
# 色を使う
setopt prompt_subst
# コマンドの途中で勝手に履歴から補完
# (上級者向き)
# なぜか学校では動かない
#autoload predict-on
#predict-on
# emacs風のキーバインド
bindkey -e
# サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする
setopt auto_resume
# {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst
# ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
# beepを消す
setopt no_beep
# nohup
setopt nocheckjobs

# 履歴の設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
# 連続して同じコマンドのとき履歴に追加しない
setopt hist_ignore_dups
# 複数のシェルの履歴を共有
setopt share_history

# C-p,C-nで履歴を出す
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# emacsでも動くようにする
[[ $EMACS = t ]] && unsetopt zle

function pcolor() {
    for ((f = 0; f < 255; f++)); do
        printf "\e[38;5;%dm %3d#\e[m" $f $f
        if [[ $f%8 -eq 7 ]] then
            printf "\n"
        fi
    done
    echo
} 

# http://d.hatena.ne.jp/mollifier/20090502/p1
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case'

autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match \
  '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey '^]' insert-last-word

zstyle ':completion:*:default' menu select=1

bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# screenを使っているとき直前のコマンドをtitleにする
# http://web.archive.org/web/20060207103240/http://www.nijino.com/ari/diary/?20020614&to=200206141S1
# ^[は制御文字でコピペだと動かないので注意
# emacsだとCtrl+q esc，viだとCtrl+v escで入力可
# if [ "$TERM" = "screen" ]; then
#     chpwd () { echo -n "_`dirs`\\" }
#     preexec() {
# 	# see [zsh-workers:13180]
# 	# http://www.zsh.org/mla/workers/2000/msg03993.html
# 	emulate -L zsh
# 	local -a cmd; cmd=(${(z)2})
# 	case $cmd[1] in
# 	    fg)
# 		if (( $#cmd == 1 )); then
# 		    cmd=(builtin jobs -l %+)
# 		else
# 		    cmd=(builtin jobs -l $cmd[2])
# 		fi
# 		;;
# 	    %*) 
# 		cmd=(builtin jobs -l $cmd[1])
# 		;;
# 	    cd)
# 		if (( $#cmd == 2)); then
# 		    cmd[1]=$cmd[2]
# 		fi
# 		;&
# 		*)
#     echo -n "k$cmd[1]:t\\"
#     return
#     ;;
#     esac
# 
#     local -A jt; jt=(${(kv)jobtexts})
# 
#     $cmd >>(read num rest
# 	cmd=(${(z)${(e):-\$jt$num}})
# 	echo -n "k$cmd[1]:t\\") 2>/dev/null
#     }
#     chpwd
# fi

# set_proxy
if [ -f ~/co/gist/630018/set_proxy ]
then
    source ~/co/gist/630018/set_proxy
fi

# pb
if [ -f ~/co/gist/370647/pb ]
then
    source ~/co/gist/370647/pb
fi

# load local settings
if [ -f ~/.zshrc.local ]
then
   source ~/.zshrc.local
fi


# screen簡単系
alias sl="screen -ls"
function s () {
    name=${1:-${PWD##*/}}
    screen -x $name \
      || screen -r $name \
      || __session_name=$name screen -S $name
}

export __session_from=$PWD

rpwd () {
    path_diff.rb $__session_from $(pwd)
}

_set_env_git_current_branch() {
  GIT_CURRENT_BRANCH=$( git branch &> /dev/null | grep '^\*' | cut -b 3- )
}

__git_reminder() {
  [ -d "$PWD/.git" ] || return
  M=
  git status | grep -q '^nothing to commit' 2>/dev/null || M=$M'*'
  [ ! -z "$(git log --pretty=oneline  origin..HEAD 2>/dev/null)" ] && M=$M'^'
  echo -n "$M"
}

_update_rprompt () {
  RPROMPT="[${USER}@${HOST}:%~]"
}

precmd () {
#     osascript -e 'tell application "System Events" to key code 28 using {command down, option down, control down}'
    _update_rprompt
#    export PROMPT='$(aa) '
#    export PROMPT='(^q^) '
    #git_status
}

function set_screen_title () {
  echo -ne "\ek$1\e\\"
}

function set_screen_title_pwd () {
  if [ "$TERM" = "screen" ]; then
    set_screen_title $(rpwd)
  fi
}

function chpwd()
{
  #_set_env_git_current_branch
  #_gprompt
  #git_status
  set_screen_title_pwd
}

set_screen_title_pwd

if [ -f ~/.zshrc.`uname` ]
then
   source ~/.zshrc.`uname`
fi

# perl
# export XDG_DATA_HOME=/opt/local/share

export GISTY_DIR="$HOME/co/gist"


function ruby_command_not_found_handler() {
    new=`echo $* | ruby -pe 'sub(/[A-Z]/){" "+$&.downcase}'`
    if [ "$*" != "$new" ]; then
        echo "=> $new"
        eval $new
        return 0
    fi
    return 127
}

function command_not_found_handler() {
    new=`~/bin/expand $*`
    if [ $? -ne 0 ]; then
        echo "=> $new"
        eval $new
        return 0
    fi
    return 127
}

# リポジトリのrootにcd
function u()
{
    cd ./$(git rev-parse --show-cdup)
}



function u()
{
    cd ./$(git rev-parse --show-cdup)
    if [ $# = 1 ]; then
        cd $1
    fi
}

function f()
{
    cd $__session_from
    if [ $# = 1 ]; then
        cd $1
    fi
}

function h()
{
    cd
    if [ $# = 1 ]; then
        cd $1
    fi
}


function git () {
	if [[ -e '.svn' ]]; then
		if [[ $1 == "log" ]]; then
			command svn $@ | $PAGER
		else
			command svn $@
		fi
		echo
		echo "x| _ |x < .svn があったので svn コマンドにしました!"
	else
		if [[ $1 == "" ]]; then
			# git ってだけうったときは status 表示
			command git --no-pager branch-recent && \
			command git --no-pager diff --stat --color-words && \
			command git --no-pager status \
			| $PAGER
		elif [[ $1 == "log" ]]; then
			# 常に diff を表示してほしい
			command git log -p ${@[2, -1]}
		elif [[ $1 == "pull" ]]; then
			if [[ ( -x '.git/pull-chain' ) ]]; then
				command git $@
				asyncrun ./.git/pull-chain
			else
				command git $@
			fi
		else
			command git $@
		fi
	fi
}


setopt magic_equal_subst
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
setopt autopushd

# up
if [ -f ~/co/gist/607290/up ]
then
    source ~/co/gist/607290/up
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

if [ -f $HOME/perl5/perlbrew/etc/bashrc ]
then
    source $HOME/perl5/perlbrew/etc/bashrc
fi

which perlbrew >& /dev/null && perlbrew use perl-5.8.9

export PERL5LIB=~/perl5/lib

# gitの補完切る
compdef -d _git; compdef -d git

# 補完キャッシュ
zstyle ':completion:*' use-cache true

[ -e "${HOME}/.ssh/agent-env" ] && . "${HOME}/.ssh/agent-env"


function hatena () {
    if pwd | grep "Hatena" > /dev/null; then
        echo "～ ☆をくれた人に「カラースター」でお返ししよう！ ～"
        rvm use ruby-1.8.7
    fi
}

hatena

###begin-jump-bash_profile
#
# Installation:
# jump >> ~/.bash_profile && source ~/.bash_profile
#

function jump {
  local newDir=$(JUMPPROFILE=1 command jump "$@");
  cd "$newDir";
}
alias j="jump -a"

###end-jump-bash_profile


export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH



## 実行したプロセスの消費時間が3秒以上かかったら
## 自動的に消費時間の統計情報を表示する。
REPORTTIME=3

## 「/」も単語区切りとみなす。
WORDCHARS=${WORDCHARS:s,/,,}


## ディレクトリ名だけでcdする。
setopt auto_cd
## cdで移動してもpushdと同じようにディレクトリスタックに追加する。
setopt auto_pushd
## カレントディレクトリ中に指定されたディレクトリが見つからなかった場合に
## 移動先を検索するリスト。
cdpath=(~)
## ディレクトリが変わったらディレクトリスタックを表示。
chpwd_functions=($chpwd_functions dirs)


## 補完方法毎にグループ化する。
### 補完方法の表示方法
###   %B...%b: 「...」を太字にする。
###   %d: 補完方法のラベル
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''


## 補完侯補をメニューから選択する。
### select=2: 補完候補を一覧から選択する。
###           ただし、補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*:default' menu select=2

## 補完候補に色を付ける。
### "": 空文字列はデフォルト値を使うという意味。
zstyle ':completion:*:default' list-colors ""

## 補完候補がなければより曖昧に候補を探す。
### m:{a-z}={A-Z}: 小文字を大文字に変えたものでも補完する。
### r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'

## 補完方法の設定。指定した順番に実行する。
### _oldlist 前回の補完結果を再利用する。
### _complete: 補完する。
### _match: globを展開しないで候補の一覧から補完する。
### _history: ヒストリのコマンドも補完候補とする。
### _ignored: 補完候補にださないと指定したものも補完候補とする。
### _approximate: 似ている補完候補も補完候補とする。
### _prefix: カーソル以降を無視してカーソル位置までで補完する。
zstyle ':completion:*' completer \
    _oldlist _complete _match _history _ignored _approximate _prefix

## 補完候補をキャッシュする。
zstyle ':completion:*' use-cache yes
## 詳細な情報を使う。
zstyle ':completion:*' verbose yes
## sudo時にはsudo用のパスも使う。
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"

## カーソル位置で補完する。
setopt complete_in_word
## globを展開しないで候補の一覧から補完する。
setopt glob_complete
## 補完時にヒストリを自動的に展開する。
setopt hist_expand
## 補完候補がないときなどにビープ音を鳴らさない。
setopt no_beep
## 辞書順ではなく数字順に並べる。
setopt numeric_glob_sort