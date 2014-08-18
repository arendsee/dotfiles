export WINEARCH="win32"
export WINEPREFIX="$HOME/.wine32"
export JAVA_HOME="/opt/java/jre1.7.0_60"
export GITSITE="https://github.com/zbwrnz"
export LIGHTNING='jenchang@lightning3.its.iastate.edu'
export HISTTIMEFORMAT="%d/%m/%y %T "
export VIMRC="$HOME/.vimrc"
export BASHRC="$HOME/.bashrc"
export BASH_ALIASES="$HOME/.bash_aliases"

PATH="$PATH:~/bin:."

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000000
HISTFILESIZE=1000000
shopt -s histappend
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PS1="\[\033[0;32m\]\$? \W \$ \[\033[00m\]"

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

