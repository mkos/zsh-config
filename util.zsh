HELPFILE=$CONFIG/help.txt

function help() {
    less $HELPFILE
}

# modified version of original file taken from
# https://github.com/derekwyatt/dotfiles/blob/master/zshrc

function gitall {
  find -L . -type d -a -name .git | while read d
  do
    local x=${d%.git}
    echo "$fg[yellow]========= $x$reset_color"
    (cd $x; git "$@")
  done
}

# original version from http://blog.thelinuxkid.com/2013/06/automatically-start-tmux-on-ssh.html
# enhanced with checking if shell is login shell (so it won't start tmux
# when working in X terminal)
#
# starts tmux automatically on SSH login and logouts after detach.
# If tmux session exists, attaches to it, creating new one otherwise.
# this should be called from zshrc as a very last command

function tmux_autostart() {
    if [[ -o login ]]; then
        if [[ -z "$TMUX" ]]; then
            tmux has-session &> /dev/null
            if [ $? -eq 1 ]; then
              exec tmux new
              exit
            else
              exec tmux attach
              exit
            fi
        fi
    fi
}

# this fuction is the default action taken on Ctrl-D hit on empty line. If in tmux, it detaches
# client, logging out otherwise
function tmux_detach_logout() {
    if [[ -z "$TMUX" ]]; then
        exit
    else
        tmux detach-client
    fi
}

