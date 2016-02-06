export VIRTUAL_ENV_DISABLE_PROMPT=yes

function prompt_char {
	if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}

function venv_name {
    if [[ -z $VIRTUAL_ENV ]]; then
        echo
    else
        echo \(`basename $VIRTUAL_ENV`\)\  
    fi
}

PROMPT='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%}%n@)%m %{$fg_bold[blue]%}%(!.%1~.%~) %{$fg_bold[red]%}$(git_prompt_info)%_%{${fg_bold[yellow]}%}$(venv_name)%_%{$fg_bold[blue]%}$(prompt_char)%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=") "
