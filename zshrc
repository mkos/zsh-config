# make sure that zplug is installed

ZPLUG_HOME=$HOME/.zplug

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

# ZPLUG CONFIG
# previous themes: gentoo-mod, bira, jonathan
zplug "zplug/zplug"
zplug "robbyrussell/oh-my-zsh", use:oh-my-zsh.sh, nice:-14
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh, lazy:true
zplug "plugins/screen", from:oh-my-zsh, lazy:true
zplug "jocelynmallon/zshmarks"
zplug "denysdovhan/spaceship-zsh-theme", use:spaceship.zsh-theme

SPACESHIP_RUBY_SHOW=false
SPACESHIP_NVM_SHOW=false

# Path to your oh-my-zsh configuration
CONFIG=$HOME/repos/zsh-config
LOCAL_CONFIG=$HOME/.zsh

# Set customization directory to this repo
# see: https://github.com/robbyrussell/oh-my-zsh/wiki/Customization#using-another-customization-directory
ZSH_CUSTOM=$CONFIG

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# load zplug plugins
zplug load


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
alias ls="ls --color=auto --group-directories-first"
alias svim="gvim --remote-silent"
alias lx="ls --group-directories-first -AF"
alias cls="clear"
alias ds="du -h --max-depth=1 | sort -h -r"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
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
source /usr/local/bin/virtualenvwrapper_lazy.sh

# stop capturing ctrl-d (for tmux logout)
setopt IGNORE_EOF

# this should be called as a very last command
tmux_autostart
