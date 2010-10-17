# path
export PATH=/usr/local/bin:~/bin:~/co/commands/bin:$PATH
export PATH=/opt/local/bin:$PATH

# flex
export PATH=/Applications/flex_sdk_3.4/bin:$PATH

# android
export PATH=/Users/fkd/Downloads/android-sdk-mac_x86-1.5_r2/tools:$PATH

# ruby
export PATH=~/.gem/ruby/1.8/bin:~/.gem/ruby/1.9/bin:$PATH

# python
export PYTHONPATH="/usr/local/lib/python2.6/site-packages/:$PYTHONPATH"

# rsense
export PATH=~/.emacs.d/etc/rsense-0.3/bin/:$PATH

if [ "$TERM" != "dumb" ]; then
# プロンプトの設定　右にpwd出したり
case $UID in
    0) PROMPT="%# " ;; # root
    *) PROMPT="%% " ;;
esac
PROMPT2="%_> "
SPROMPT="%r is correct? [n,y,a,e]: "

fi

alias emacsclient=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient

# chshとかcrontab -eとかで使うエディタ
export EDITOR=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
#export ALTERNATE_EDITOR=emacs
# svnで使うエディタ
export SVN_EDITOR=emacsclient
#require rubygems
export RUBYOPT="rubygems"

# alias
alias du="du -h"
alias screen="screen -U"
alias l="ls"
alias la="ls -a"
alias ll="ls -lh"
alias lla="ls -lha"
alias emacs="emacs -nw"
alias cp="cp -v"
alias ruby="ruby -Ku"
alias irb="irb -Ku"
alias o="open ."
alias less="/usr/share/vim/vim72/macros/less.sh"

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
source ~/co/gist/630018/set_school

# pb
source ~/co/gist/370647/pb

# load local settings
if [ -f ~/.zshrc.local ]
then
   source ~/.zshrc.local
fi


# screen簡単系
alias sl="screen -ls"
s () {
    name=${1:-${PWD##*/}}
    #echo "\033P\033]0;${name}\007\033\\"
    __session_name=$name screen -x $name || __session_name=$name screen -r $name || __session_name=$name screen -S $name
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

preexec () {
#    osascript -e 'tell application "System Events" to key code 28 using {command down, option down, control down}'
}

precmd () {
#     osascript -e 'tell application "System Events" to key code 28 using {command down, option down, control down}'
    _update_rprompt
#    export PROMPT='$(aa) '
#    export PROMPT='(^q^) '
    #git_status
}

chpwd()
{
  #_set_env_git_current_branch
  #_gprompt
  #git_status
}

if [ -f ~/.zshrc.`uname` ]
then
   source ~/.zshrc.`uname`
fi

# perl
export XDG_DATA_HOME=/opt/local/share

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


function specs {
    echo "# 1.8"
    spec $*
    echo "# 1.9"
    spec1.9 $*
}

function gems {
    echo "# 1.8"
    gem $*
    echo "# 1.9"
    gem1.9 $*
}


# perl
eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)

setopt magic_equal_subst
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
setopt autopushd

# up
source ~/co/gist/607290/up

# java (for cassandra)
export JAVA_HOME=$(/usr/libexec/java_home)