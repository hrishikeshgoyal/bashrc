# source readable files
function check_and_source {
    if [ -r $1 ]; then source $1; fi
}

check_and_source /usr/local/lib/initfiles/system-bashrc
check_and_source ~/.bash_aliases
check_and_source ~/.bash_completion
check_and_source ~/.bash_exports
check_and_source ~/.bash_functions
check_and_source ~/.bash_palette

function ps2_prompt {
    local indent=$((15+${#USER}+${#SHORTHOST}))
    if [[ ${PWD} == ${HOME}* ]]; then
        ((indent+=$((${#PWD}-${#HOME}+1))))
    else
        ((indent+=${#PWD}))
    fi
    PS2="$(printf ' %.0s' $(eval echo {1..${indent}}))> "
}

# pre-prompt executions - tab name short-hostname:pwd
PROMPT_COMMAND='echo -ne "$E_ESC$SHORTHOST:$(pwd)$E_BEL";'
PROMPT_COMMAND+='ps2_prompt;'
#PROMPT_COMMAND+='printf "\033k$SHORTHOST:$(pwd)\033\\";'

# [time] user@host.site: pwd $ as the primary prompt
PS1="$C_BROWN\u$C_CYAN@$C_BROWN$SHORTHOST$C_CYAN:$C_GREEN \w $C_RED\$$C_OFF "

# shell options
shopt -s cdspell checkwinsize cmdhist histappend no_empty_cmd_completion
[[ ${BASH_VERSINFO} -ge 4 ]] && shopt -s autocd checkjobs dirspell
[[ ${BASH_VERSION} =~ "4.2" ]] && shopt -s direxpand

# use braces instead of parenthesis if you don't want to fork
[[ $- == *i* ]] && [[ $TERM != "screen-256color" ]] && ( if tmux has-session; then exec tmux -2 attach; else exec tmux -2; fi; )


#[[ $- == *i* ]] && [[ $TERM != "screen-256color" ]] && ( exec tmux -2; )

# To remove hostname from tmux statusbar
PROMPT_COMMAND='echo -ne "\033]0;\007"'

export INPUTRC=~/.inputrc



# Adding npm to path

