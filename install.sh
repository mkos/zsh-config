#!/bin/bash

REPODIR=$HOME/repos
VIMBUNDLE=$HOME/.vim/bundle
DROPBOX=$HOME/Dropbox

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

function exit_if_pip_pkg_not_installed() {
    pip list | egrep "^$1\s" 1>/dev/null
    if [[ $? != 0 ]]; then
        echo install pip package \`$1\` and rerun the script
        exit 1;
    fi
}

function make_link() {
    if [[ ! -L $2 && ! "$(readlink $2)" = "$1" ]]; then
        ln -sf $1 $2
        echo created link from \'$1\' to \'$2\'
    fi
}

## check if required packages are available
exit_if_not_installed git
exit_if_not_installed gvim
exit_if_not_installed zsh
exit_if_not_installed xsel
exit_if_not_installed pip

## check if required python packages are avaliable
exit_if_pip_pkg_not_installed virtualenv
exit_if_pip_pkg_not_installed virtualenvwrapper
exit_if_pip_pkg_not_installed Markdown
exit_if_pip_pkg_not_installed ipython

## create required dirs
create_dir_if_not_exists $REPODIR
create_dir_if_not_exists $VIMBUNDLE
create_dir_if_not_exists ~/.fonts
create_dir_if_not_exists ~/.virtualenvs

## public and third party repos
clone_git_repo https://github.com/mkos/zsh-config.git           $REPODIR/zsh-config
clone_git_repo https://github.com/mkos/vim-config.git           $VIMBUNDLE/vim-config
clone_git_repo https://github.com/gmarik/Vundle.vim.git         $VIMBUNDLE/Vundle.vim
clone_git_repo https://github.com/robbyrussell/oh-my-zsh.git    $HOME/.oh-my-zsh
clone_git_repo https://github.com/adobe-fonts/source-code-pro.git \
               ~/.fonts/source-code-pro
clone_git_repo https://github.com/muennich/urxvt-perls.git      $REPODIR/urxvt-perls.git

## private repos
clone_git_repo $DROPBOX/repos/scripts                           $REPODIR/scripts
clone_git_repo $DROPBOX/repos/dotfiles                          $REPODIR/dotfiles

## create links to config files
make_link $REPODIR/zsh-config/zshrc                 $HOME/.zshrc
make_link $VIMBUNDLE/vim-config/vimrc               $HOME/.vimrc
make_link $REPODIR/dotfiles/gitconfig               $HOME/.gitconfig
make_link $REPODIR/dotfiles/xorg/xresources         $HOME/.Xresources
make_link $REPODIR/dotfiles/systemd                 $HOME/.config/systemd
make_link $REPODIR/dotfiles/conky/conky_horizontal  $HOME/.conkyrc
make_link $REPODIR/zsh-config/tmux.conf             $HOME/.tmux.conf

echo "installing Source Code Pro font"
fc-cache -f -v ~/.fonts/source-code-pro 1>/dev/null
