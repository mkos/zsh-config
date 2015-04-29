HELPFILE=$CONFIG/help.txt

function help() {
    less $HELPFILE
}

# modified version of original file taken from
# https://github.com/derekwyatt/dotfiles/blob/master/zshrc
#   - added coloring output (ZSH only)
#   - added checking for number of parameters

function gitall {
    if [[ $# -gt 0 ]]; then
        find -L . -type d -a -name .git | while read d
        do
            local x=${d%.git}
            echo "$fg[yellow]========= $x$reset_color"
            (cd $x; git "$@")
        done
    else
        echo "function needs parameters passed to git"
    fi
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

# reloads shell config file
function reload_config() {
    source $HOME/.zshrc
}

# rsync parameters tuned up to remote filesystem being NTFS - due to NTFS driver on linux
# root account on the other side is required for proper sync. Option --modify-window is
# required due to network delays and clock time differences and resolution of a NTFS
# timestamps.
#
# function arguments
#   - local dir
#   - remote dir
function syncdir() {

    local localdir=$1
    local remotedir=$2
    rsync -rvtW \
        --delete \
        --modify-window=30 \
        --progress \
        -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" \
        $localdir \
        $remotedir

}

# this function synchronizes either single entry or all of the entries in the
# config file defined in $SYNCRC global variable. If the parameter is equal to
# "all", all entries are synced
function syncname() {

    [[ $# == 0 ]] && { echo "Name not given."; return 1 }
    [[ -z $SYNCRC ]] && { echo "Global variable \$SYNCRC is not set"; return 1 }
    [[ ! -f $SYNCRC ]] && { echo "config file $SYNCRC does not exist"; return 1 }

    name_found=0
    while IFS="," read name src dest; do
        if [[ $1 == $name ]] || [[ $1 == "all" ]]; then
            name_found=1
            echo "syncing $src to $dest"
            syncdir $src $dest
        fi
    done < $SYNCRC

    [[ $name_found == 0 ]] && { echo "Name $1 not found in $syncrc config file"; return 1 }

}
