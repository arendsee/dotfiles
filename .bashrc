#!/bin/bash

EDITOR=vim

set editing-mode vi
set show-mode-in-prompt on

PATH="$PATH:$HOME/bin"

export TERM="screen-256color"
export VISUAL="vim"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export HISTTIMEFORMAT="%d/%m/%y %T "
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=
HISTFILESIZE=
shopt -s histappend
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# requires installation of acpi
__battery-check_() {
    operation=$1
    percent=$2
    time_remaining=$3
    if [[ $time_remaining == "Unknown" ]]
    then
        time_remaining='???'
    fi
    if [[ $operation == "Discharging" ]]
    then
        if [[ $percent -lt 20 ]]
        then
            # if low powered (red)
            echo -ne "\x01\e[1;31m\x02$time_remaining \x01\e[0;32m\x02"
        elif [[ $percent -lt 50 ]]
        then
            # if half-powered (yellow)
            echo -ne "\x01\e[0;33m\x02$percent \x01\e[0;32m\x02"
        else
            # if half-powered (yellow)
            echo -ne "\x01\e[0;33m\x02$percent \x01\e[0;32m\x02"
            # # if mostly powered, but discharging (green)
            # echo -ne "\e[0;32m.\e[0;32m"
        fi
    elif [[ $operation == "Charging" ]]
    then
        if [[ $percent -lt 75 ]]
        then
            echo -ne "\x01\e[1;32m\x02$percent \x01\e[0;32m\x02"
        fi
    elif [[ $operation == "Unknown" ]]
    then
        # if half-powered (yellow)
        echo -ne "\x01\e[0;33m\x02$time_remaining \x01\e[0;32m\x02"
    else
        echo ""
    fi
}
parse-acpi () {
    acpi -b |
    sed 's/.*: //' |
    awk '
        BEGIN{FS=", "}
        {
            if($3 ~ /..:..:../){
                $3 = gensub(/.*(..:..:..).*/, "\\1", "g", $3)
            }
            else{
                $3 = "Unknown"
            }
            $2 = gensub(/([0-9]+).*/, "\\1", "g", $2)
        }
        END{ print $1, $2, $3 }
    '
}

__battery-check() {
    __battery-check_ `parse-acpi`
}

PROMPT_COMMAND=__prompt_cmd
__prompt_cmd() {
    local EXIT=$?
    local NORMAL='\[\033[00m\]'
    local RED='\[\033[0;31m\]'
    local GREEN='\[\033[0;32m\]'
    local YELLOW='\[\033[1;33m\]'
    # If ROOT, use a scary red font
    if [[ $HOME == "/root" ]]; then
        PS1="${RED}${EXIT} ROOT \W \$ ${NORMAL}"
    # If not in tmux, show an naked yellow dollar sign
    elif [[ -z $TMUX ]]; then
        PS1="${YELLOW}${EXIT} \$ ${NORMAL}"
    # If in TMUX, use a nice subdued font with working directory shown
    else
        if [[ ! -z `type -P acpi` ]]
        then
          PS1="\$(__battery-check)${GREEN}${EXIT} \W \$ ${NORMAL}"
        else
          PS1="${GREEN}${EXIT} \W \$ ${NORMAL}"
        fi
    fi
}

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Read aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Check for local bash aliasas and bashrc files
# This allows me to keep a single set of files synced across all my computers
# AND certain settings that are uniq to one place
if [ -f ~/.local_bash_aliases ]; then
    . ~/.local_bash_aliases
fi

if [ -f ~/.local_bashrc ]; then
    . ~/.local_bashrc
fi

# Color fasta files
export LS_COLORS="$LS_COLORS:*.fa=00;33:*.faa=00;33:*.fna=00;33:*.fasta=00;33:"

# Color masked fasta files
export LS_COLORS="$LS_COLORS:*.mfa=00;33:*.mfaa=00;33:*.mfna=00;33:*.mfasta=00;33:"

# Color csv, tsv, and tab files
export LS_COLORS="$LS_COLORS:*.csv=38;5;106:*.tab=38;5;106:*.tsv=38;5;106:"

# Embolden MANIFEST, SOURCE, README, and TODO files
export LS_COLORS="$LS_COLORS:*MANIFEST=01;39:*MANIFEST.txt=01;39:*SOURCE=01;39:*SOURCE.txt=01;39:*README=01;39:*README.txt=01;39:*README.md=01;39:*INSTALL=01;39:*TODO=01;39:"

# pdf and tex
export LS_COLORS="$LS_COLORS:*.pdf=00;35:*.tex=00;36"
