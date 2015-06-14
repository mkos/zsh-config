#!/bin/bash

REPODIR=$HOME/repos
VIMBUNDLE=$HOME/.vim/bundle

function create_dir_if_not_exists() {
    if [[ ! -d $1 ]]; then
        mkdir $1
        echo creating $1
    fi
}

function clone_git_repo() {
    if [[ ! -d $2 ]]; then
        git clone $1 $2
    fi
}

function exit_if_not_installed() {
    which $1 1>/dev/null
    if [[ $? != 0 ]]; then 
        echo install \'$1\' first and rerun script
        exit 1;
    fi
}

function make_link() {
    if [[ ! -L $2 && ! "$(readlink $2)" = "$1" ]]; then
        ln -sf $1 $2
        echo created link from \'$1\' to \'$2\'
    fi
}

exit_if_not_installed git
exit_if_not_installed gvim
exit_if_not_installed zsh

create_dir_if_not_exists $REPODIR
create_dir_if_not_exists $VIMBUNDLE
clone_git_repo https://github.com/mkos/zsh-config.git $REPODIR/zsh-config
clone_git_repo https://github.com/mkos/vim-config.git $VIMBUNDLE/vim-config
clone_git_repo https://github.com/gmarik/Vundle.vim.git $VIMBUNDLE/Vundle.vim
clone_git_repo https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
make_link $REPODIR/zsh-config/zshrc $HOME/.zshrc
make_link $VIMBUNDLE/vim-config/vimrc $HOME/.vimrc

echo "installing Source Code Pro font"
create_dir_if_not_exists ~/.fonts
clone_git_repo https://github.com/adobe-fonts/source-code-pro.git ~/.fonts/source-code-pro
fc-cache -f -v ~/.fonts/source-code-pro
