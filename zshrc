# Path to your oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh
CONFIG=$HOME/repos/zsh-config
LOCAL_CONFIG=$HOME/.zsh

# Set customization directory to this repo
# see: https://github.com/robbyrussell/oh-my-zsh/wiki/Customization#using-another-customization-directory
ZSH_CUSTOM=$CONFIG

# Set name of the theme to load.
# previous themes: gentoo-mod, bira, jonathan
ZSH_THEME="spaceship"

SPACESHIP_RUBY_SHOW=false
SPACESHIP_NVM_SHOW=false

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
#   * zshmarks - git clone git://github.com/jocelynmallon/zshmarks.git
plugins=(git vi-mode screen scala sbt zshmarks virtualenvwrapper)

source $ZSH/oh-my-zsh.sh
source $CONFIG/util.zsh

# stop capturing ctrl-d (for tmux logout)
setopt IGNORE_EOF

# sourcing local config files if exist
if [[ -e $LOCAL_CONFIG ]] && [[ -d $LOCAL_CONFIG ]]; then
    for file in `ls $LOCAL_CONFIG`; do
        source $LOCAL_CONFIG/$file
    done
fi

# other env vars

export EDITOR="vim"
export PYTHONDOCS=/usr/share/doc/python2/html

# for syncname()
export SYNCRC=$HOME/.config/sync/syncrc

# export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';

# eval `dircolors ~/.dir_colors`

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

# ssh-agent aliases
alias keyup="ssh-add $HOME/.ssh/id_rsa.key"
alias keydown="ssh-add -D"
alias keyst="ssh-add -l"
alias agentup="eval `ssh-agent`"

# systemctl aliases
alias sc="systemctl"
alias scu="systemctl --user"
alias slog="journalctl -xn"

# key bindings (to get the bindings, enter 'cat' and push the button)

bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "^D"    tmux-detach-client
bindkey "^R"    history-incremental-search-backward


# python pip autocompletion on
compctl -K _pip_completion pip

# virtualenv config
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/repos
export VIRTUAL_ENV_DISABLE_PROMPT=1

# sourcing other packages
source /usr/local/bin/virtualenvwrapper.sh

# this should be called as a very last command
tmux_autostart
