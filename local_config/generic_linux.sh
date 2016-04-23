# for systemd/User ssh-agent
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/${UID:-$(id -u)}}/ssh_auth_sock"

# setting path

export HOMEBIN=$HOME/bin
export SBIN=/sbin:/usr/local/sbin:/usr/sbin

export PATH=/bin:/usr/bin:/usr/local/bin:/usr/games:$SBIN:$HOMEBIN:$ANDROIDBIN:$JAVABIN:$SCRIPTS

