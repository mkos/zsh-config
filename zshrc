# make sure that zplug is installed

ZPLUG_HOME=${ZPLUG_HOME:-$HOME/.zplug}


if [ ! -d $ZPLUG_HOME ]; then
    which git
    if [ $? = 0 ]; then
        git clone https://github.com/b4b4r07/zplug $ZPLUG_HOME
    else
        echo git is not installed.
    fi
fi

# source zplug
source ~/.zplug/init.zsh

# Path setting for gnutils

export PATH=/usr/local/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH

# ZPLUG CONFIG
# version locking for zsh<5.0.4 - at:v2.8.0
zplug "denysdovhan/spaceship-zsh-theme", use:spaceship.zsh, from:github, as:theme
zplug "zplug/zplug"
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "jreese/zsh-titles", from:github
#zplug "jocelynmallon/zshmarks"
#zplug "robbyrussell/oh-my-zsh", use:oh-my-zsh.sh, defer:2

# Path to your oh-my-zsh configuration
CONFIG=$HOME/repos/zsh-config
LOCAL_CONFIG=$HOME/.zsh

# Set customization directory to this repo
# see: https://github.com/robbyrussell/oh-my-zsh/wiki/Customization#using-another-customization-directory
ZSH_CUSTOM=$CONFIG

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# vi mode timeout
export KEYTIMEOUT=1

# load zplug plugins
zplug load

# spaceship
SPACESHIP_EXEC_TIME_SHOW=false
SPACESHIP_TIME_SHOW=false
SPACESHIP_RUBY_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_PHP_SHOW=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false

SPACESHIP_GIT_BRANCH_PREFIX=""
SPACESHIP_GIT_BRANCH_SUFFIX=""
SPACESHIP_GIT_STATUS_PREFIX=" ["

SPACESHIP_PYENV_SYMBOL=@
SPACESHIP_PYENV_COLOR=green

source $CONFIG/util.zsh
source_local_config $LOCAL_CONFIG
set_tmux_version_vars

# other env vars
export EDITOR="vim"
export PYTHONDOCS=/usr/share/doc/python2/html

# less pager config: (-F) quit if file fits in one screen, (-Q) quiet - never ring a bell, (-X) no termcap init
# (-R) show ANSI colors, (-E) exit on EOF
export LESS='-F -X -Q -R -E'

# for syncname()
export SYNCRC=$HOME/.config/sync/syncrc

# ZLE mappings
# maps function from util.zsh to a zle command
zle -N tmux-detach-client tmux_detach_logout

# aliases
alias ll="ls -al"
alias ls="ls --color=auto --group-directories-first"
alias svim="gvim --remote-silent"
alias lx="ls --group-directories-first -AF"
alias cls="clear"
alias ds="du -h --max-depth=1 | sort -h -r"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias rssh="rsync -avz -e \"ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null\" --progress"
alias pipall="pip list --outdated --format=freeze | cut -d = -f 1 | xargs -n1 pip install -U"
alias j=jump

# ssh-agent aliases
alias keyup="ssh-add $HOME/.ssh/id_rsa.key"
alias keydown="ssh-add -D"
alias keyst="ssh-add -l"
alias agentup="eval `ssh-agent`"

# systemctl aliases
alias sc="systemctl"
alias scu="systemctl --user"
alias slog="journalctl -xn"

# virtualenv aliases
alias cdp=cdproject

# key bindings (to get the bindings, enter 'cat' and push the button)
# binds leftarrow and ctrl-w to beginning of line and rightarrow to end of line - ctrl-e is by default
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "^w"    beginning-of-line
bindkey "^D"    tmux-detach-client
bindkey "^R"    history-incremental-search-backward

# python pip autocompletion on
compctl -K _pip_completion pip

# virtualenv config
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/repos
export VIRTUAL_ENV_DISABLE_PROMPT=1
if [[ -r /usr/local/bin/virtualenvwrapper_lazy.sh ]]; then
    source /usr/local/bin/virtualenvwrapper_lazy.sh
fi

# stop capturing ctrl-d (for tmux logout)
setopt IGNORE_EOF

# ssh/scp/slogin autocomplete hosts
# source: https://serverfault.com/questions/170346/how-to-edit-command-completion-for-ssh-on-zsh
h=()
if [[ -r ~/.ssh/config ]]; then
    h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
if [[ -r ~/.ssh/known_hosts ]]; then
    h=($h ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
fi
if [[ $#h -gt 0 ]]; then
    zstyle ':completion:*:ssh:*' hosts $h
    zstyle ':completion:*:scp:*' hosts $h
    zstyle ':completion:*:slogin:*' hosts $h
fi

##
## pyenv
##

# check if it's local installation of pyenv (in ~/.pyenv) and setup proper env vars
if [[ -e $HOME/.pyenv/bin ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
fi

# init pyenv
if which pyenv > /dev/null 2>&1; then
    eval "$(pyenv init -)"

    # Temporary fix for homebrew issue - OSX specific
    if [[ -e /usr/local/share/zsh/site-functions/pyenv.zsh ]]; then
        . /usr/local/share/zsh/site-functions/pyenv.zsh
    fi
fi

# init pyenv-virtualenv
if which pyenv-virtualenv-init > /dev/null 2>&1; then
    eval "$(pyenv virtualenv-init -)"
fi

# History settings

export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTFILE=~/.zhistory

setopt HIST_FIND_NO_DUPS

setopt inc_append_history
setopt share_history

# init fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Google Cloud SDK setup
export CLOUD_SDK_PATH=$HOME/opt/google-cloud-sdk

if [ -d $CLOUD_SDK_PATH ]; then

    # pick the latest 2.x python from pyenv
    export CLOUDSDK_PYTHON=$(pyenv prefix $(pyenv versions --bare --skip-aliases | grep ^2 | grep -v \/))/bin/python

    # The next line updates PATH for the Google Cloud SDK.
    if [ -f $CLOUD_SDK_PATH/path.zsh.inc ]; then
        . $CLOUD_SDK_PATH/path.zsh.inc
    fi

    # The next line enables shell command completion for gcloud.
    if [ -f $CLOUD_SDK_PATH/completion.zsh.inc ]; then
        . $CLOUD_SDK_PATH/completion.zsh.inc
    fi
fi
# this should be called as a very last command
tmux_autostart
