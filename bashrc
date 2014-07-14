export WINEARCH="win32"
export WINEPREFIX="$HOME/.wine32"
export JAVA_HOME="/opt/java/jre1.7.0_60"
export GITSITE="https://github.com/zbwrnz"
export LIGHTNING='jenchang@lightning3.its.iastate.edu'
export HISTTIMEFORMAT="%d/%m/%y %T "
export VIMRC="$HOME/.vimrc"
export BASHRC="$HOME/.bashrc"
export BASH_ALIASES="$HOME/.bash_aliases"

PATH="$PATH:~/bin"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000000
HISTFILESIZE=1000000
shopt -s histappend
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=no
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1="\[\033[0;32m\]\$? \w \$ \[\033[00m\]"
else
    PS1='\w $ '
fi
unset color_prompt force_color_prompt

# Read aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
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
