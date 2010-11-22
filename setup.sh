#!/bin/sh
# this script will setup dotfiles in repository to your home directory.

HOME_PATH=~
DOTFILES_PATH=`pwd`

if [ -d ${HOME_PATH}/.old_dotfiles ];then
    rm -rf ${HOME_PATH}/.old_dotfiles
fi

mkdir ${HOME_PATH}/.old_dotfiles

for file in functions irbrc login zshrc screenrc gitconfig gitignore elisp emacs.d emacs.el.`uname` skk uim zshrc.`uname` folders gemrc
do
    echo "${file}"
    mv ${HOME_PATH}/.${file} ${HOME_PATH}/.old_dotfiles/.${file}
    ln -s ${DOTFILES_PATH}/${file} ${HOME_PATH}/.${file}
done

for file in bin
do
    echo "${file}"
    mv ${HOME_PATH}/${file} ${HOME_PATH}/.old_dotfiles/${file}
    ln -s ${DOTFILES_PATH}/${file} ${HOME_PATH}/${file}
done

