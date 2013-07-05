# path
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:~/co/commands/bin:$PATH
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
alias g="magit-status"
alias ig="tig"

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
HISTSIZE=10000000
SAVEHIST=10000000
# 連続して同じコマンドのとき履歴に追加しない
setopt hist_ignore_dups
# 複数のシェルの履歴を共有
setopt share_history

# zmv
autoload -Uz zmv
alias zmv='noglob zmv -W'

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
  GIT_CURRENT_BRANCH=$( git name-rev --name-only --refs=refs/heads/* HEAD )
}

__git_reminder() {
  [ -d "$PWD/.git" ] || return
  M=
  git status | grep -q '^nothing to commit' 2>/dev/null || M=$M'*'
  [ ! -z "$(git log --pretty=oneline  origin..HEAD 2>/dev/null)" ] && M=$M'^'
  echo -n "$M"
}

autoload -Uz add-zsh-hook
autoload -Uz colors
colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  # この check-for-changes が今回の設定するところ
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
  zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
  zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
  zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
fi

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    PROMPT="%(?.%F{green}.%F{red})[${USER}@${HOST}:%~] %1(v|%1v|)
%% %f"

}
add-zsh-hook precmd _update_vcs_info_msg


# _update_rprompt () {
#   RPROMPT="[${USER}@${HOST}:%~]"
# }
# 
# precmd () {
# #     osascript -e 'tell application "System Events" to key code 28 using {command down, option down, control down}'
#     _update_rprompt
# #    export PROMPT='$(aa) '
# #    export PROMPT='(^q^) '
#     #git_status
# }

preexec() {
    # wget "http://bijo-linux.com/girls_images/$(echo $1 | cut -d ' ' -f 1).jpg" >& /dev/null
    # man $(echo $1 | cut -d ' ' -f 1) | echo
    # qlmanage -p "$(echo $1 | cut -d ' ' -f 1).jpg"
    # open "http://bijo-linux.com/girls/$(echo $1 | cut -d ' ' -f 1)/"
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
  hatena
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

# alias git=hub
# compdef hub=git

# 補完キャッシュ
zstyle ':completion:*' use-cache true

[ -e "${HOME}/.ssh/agent-env" ] && . "${HOME}/.ssh/agent-env"


function hatena () {
    if pwd | grep "Hatena" > /dev/null; then
        echo "～ ☆をくれた人に「カラースター」でお返ししよう！ ～"
        rvm use ruby-1.8.7-p352
    fi

    if pwd | grep "Epic" > /dev/null; then
        echo "5.14.2"
        echo "1.9.2"
        rvm use ruby-1.9.2-p290
        perlbrew use perl-5.14.2
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


export HIVE_HOME=/usr/local/Cellar/hive/0.8.0/libexec
export HADOOP_HOME=/usr/local/Cellar/hadoop/0.20.2

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

source ~/co/zaw/zaw.zsh

bindkey '^T' zaw-history

export ZAW_HISTORY_LIMIT=5000


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"



function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    ls
    # ↓おすすめ
    # ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb
    fi
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter
