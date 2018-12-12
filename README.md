ZSH config
==========

This is my personal [ZSH](http://www.zsh.org/), [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) config. Started few years back, now in its own git repo. Now it also uses [zplug](https://github.com/b4b4r07/zplug) to manage plugins.
Also contains 
* configuration files
    * `tmux.conf`
        * [color reference (for 256 terms)](http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html)
        * [man tmux](http://man7.org/linux/man-pages/man1/tmux.1.html)
        * [Arch linux wiki - tmux](https://wiki.archlinux.org/index.php/tmux)
    * `gitconfig`
* local config files 
    * make symbolic links to files in `local_config` to `~/.zsh` to activate them (__soon__: use `zplug` to manage them)
* scripts
    * `install.sh` - simple script that prepares my environment

First installation
------------------

```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkos/zsh-config/master/scripts/install.sh)"
```

Running without breaking config of the account
----------------------------------------------

This repo must be cloned to `$HOME/somedir/repos`, `zshrc` has to be linked to `$HOME/somedir/.zshrc`
```
ZDOTDIR=$HOME/somedir ROOTDIR=$HOME/somedir zsh
```
