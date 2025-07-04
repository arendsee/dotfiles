#!/bin/bash

# EDITOR=vim

# set editing-mode vi
# set show-mode-in-prompt on

PATH="$HOME/bin:$PATH"
PATH="$PATH:$HOME/.cabal/bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/.gem/ruby/3.0.0/bin"
PATH="$PATH:$HOME/.scarf/bin"
PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin"

# export TERM="xterm-256color"
export VISUAL="vim"

# For fuseki
export FUSEKI_HOME="$HOME/.fuseki"
export FUSEKI_BASE="$FUSEKI_HOME/run"

# # setup autocompletion for stack commands
# eval "$(stack --bash-completion-script stack)"

# # Support for the obscure Ptolemy language
# export PYC_HOME="$HOME/src/ptolemy"
# PATH="$PATH:$PYC_HOME/bin"

# # Support for the cool looking ATS language
# export PATSHOME="$HOME/src/ATS2-Postiats"
# PATH="$PATH:$PATSHOME/bin"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export HISTTIMEFORMAT="%d/%m/%y %T "
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=
HISTFILESIZE=
shopt -s histappend
shopt -s checkwinsize

# Required for opam, the ocaml package manager
source /home/shoggoth/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

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
        if [[ $percent -lt 98 ]]
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

__not_in_kansas() {
    # if there is a '.' in the node hostname, then I am probably not local
    uname -n | grep '\.' &> /dev/null
}

PROMPT_COMMAND=__prompt_cmd
__prompt_cmd() {
    local EXIT=$?
    local NORMAL='\[\033[00m\]'
    local RED='\[\033[0;31m\]'
    local GREEN='\[\033[0;32m\]'
    local YELLOW='\[\033[1;33m\]'
    if __not_in_kansas; then
        # place="${NORMAL}$(uname -n) \$ "
        place="\$${NORMAL} "
    else
        place="\$${NORMAL} "
    fi
    # If ROOT, use a scary red font
    if [[ $HOME == "/root" ]]; then
        PS1="${RED}${EXIT} ROOT \W ${place}"
    # If not in tmux, show an naked yellow dollar sign
    elif [[ -z $TMUX ]]; then
        PS1="${YELLOW}${EXIT} ${place}"
    # If in TMUX, use a nice subdued font with working directory shown
    else
        if [[ ! -z `type -P acpi` ]]
        then
          PS1="\$(__battery-check)${GREEN}${EXIT} \W ${place}"
        else
          PS1="${GREEN}${EXIT} \W ${place}"
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

F="\e[2;49;90" # faint grey
Y="\e[3;49;33" # yellow
P="\e[0;49;35" # purple
T="\e[0;49;36" # teal
U="\e[3;49;90" # underlined grey

# Color fasta files
export LS_COLORS="$LS_COLORS:*.fa=$Y:*.faa=$Y:*.fna=$Y:*.fasta=$Y:"

# Color masked fasta files
export LS_COLORS="$LS_COLORS:*.mfa=$Y:*.mfaa=$Y:*.mfna=$Y:*.mfasta=$Y:"

# Color csv, tsv, and tab files
export LS_COLORS="$LS_COLORS:*.csv=$Y:*.tab=$Y:*.tsv=$Y:"

# Color temporary files
export LS_COLORS="$LS_COLORS:*.gch=$F:*.o=$F:*.so=$F:*.hi=$F:*~=$F:"
# Flex/Bison autogen files
export LS_COLORS="$LS_COLORS:*.yy.c=$F:*.yy.h=$F:*.output=$F"
# latex temporary files
export LS_COLORS="$LS_COLORS:*.aux=$F:*.log=$F:*.fdb_latexmk=$F:*.fls=$F:*.toc=$F:*.out=$F:"

# Darken biolerplate
export LS_COLORS="$LS_COLORS:*LICENSE=$U:*MANIFEST=$U:*MANIFEST.txt=$U:*SOURCE=$U:*SOURCE.txt=$U:*README=$U:*README.txt=$U:*README.md=$U:*INSTALL=$U:*TODO=$U:*DELETEME=$U:*tags=$U:*VERSION=$U:*Makefile=$U:"

# pdf and tex
export LS_COLORS="$LS_COLORS:*.pdf=$P:*.tex=$T"

if [ -f ~/.local_bashrc ]; then
    . ~/.local_bashrc
fi

# added by travis gem
[ ! -s /home/z/.travis/travis.sh ] || source /home/z/.travis/travis.sh

PATH="/home/z/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/z/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/z/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/z/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/z/perl5"; export PERL_MM_OPT;

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/home/z/.local/bin/micromamba";
export MAMBA_ROOT_PREFIX="/home/z/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/home/z/micromamba/etc/profile.d/micromamba.sh" ]; then
        . "/home/z/micromamba/etc/profile.d/micromamba.sh"
    else
        export  PATH="/home/z/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup

# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/home/z/.local/bin/micromamba";
export MAMBA_ROOT_PREFIX="/home/z/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/home/z/micromamba/etc/profile.d/micromamba.sh" ]; then
        . "/home/z/micromamba/etc/profile.d/micromamba.sh"
    else
        export  PATH="/home/z/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<
