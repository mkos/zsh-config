HELPFILE=$CONFIG/help.txt

function help() {
    less $HELPFILE
}

# modified version of original file taken from
# https://github.com/derekwyatt/dotfiles/blob/master/zshrc

function gitall
{
  find . -type d -a -name .git | while read d
  do
    local x=${d%.git}
    echo "$fg[yellow]========= $x$reset_color"
    (cd $x; git "$@")
  done
}
