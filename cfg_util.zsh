DEFAULT_LOCAL_CONFIG_SOURCE=$HOME/repos/zsh-config/local_config
LOCAL_CONFIG_SOURCE=${LOCAL_CONFIG_SOURCE:-$DEFAULT_LOCAL_CONFIG_SOURCE}

function cfg_read {
    module_source=($(ls $LOCAL_CONFIG_SOURCE))
    active_module=($(ls $LOCAL_CONFIG))

    for module in $module_source; do
        if [[ ${active_module[@]} =~ "${module}" ]]; then
            echo " $fg_bold[white]* " $module "$reset_color"
        else
            echo "   " $module
        fi
    done
}

