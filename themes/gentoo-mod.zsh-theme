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

# $(prompt_char)
unset PROMPT RPROMPT
PROMPT='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%}%n@)%m %{$fg_bold[blue]%}%(!.%1~.%~)%{$reset_color%} '
RPROMPT='%{$fg_bold[red]%}$(git_prompt_info)%{${fg_bold[yellow]}%}$(venv_name)%{$reset_color%}'

# possible git_* functions:
# git_commits_ahead
# git_prompt_ahead
# git_prompt_info
# git_prompt_remote
# git_prompt_status   
# git_current_branch
# git_prompt_behind
# git_prompt_long_sha
# git_prompt_short_sha
# git_remote_status
# parse_git_dirty

ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_DIRTY="+"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_ADDED="A"
ZSH_THEME_GIT_PROMPT_MODIFIED="M"
ZSH_THEME_GIT_PROMPT_DELETED="D"
ZSH_THEME_GIT_PROMPT_RENAMED="R"
ZSH_THEME_GIT_PROMPT_UNMERGED="U"
ZSH_THEME_GIT_PROMPT_UNTRACKED="!"
ZSH_THEME_GIT_PROMPT_AHEAD=">"
ZSH_THEME_GIT_PROMPT_BEHIND="<"
