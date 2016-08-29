#!/usr/bin/env bash
set -u

# Link all files in dotfiles. If the existing file is a symbolic link, it is
# removed and replaced with a link to the corresponding file from this
# repository. Otherwise, the existing file is moved to a temporary folder.

tmp=/tmp/dotfiles-$(date | tr ' ' '-') 
mkdir -p $tmp

safely-link () {
    src="$PWD/$1"

    [[ -z "$2" ]] && des="$HOME/$1" || des="$2"

    # to avoid recurse madness
    [[ -h "$des" ]] && rm $des

    if [[ -f "$des" || -d "$des"  ]]
    then
        mv "$des" "$tmp"
        echo "Moving '$des' to $tmp"
    fi

    ln -sf "$src" "$des"
}

clone () {
    [[ -d ~/src/git ]] || mkdir -p ~/src/git
    if [[ ! -d "~/src/git/$1" ]]
    then
        git clone "https://github.com/arendsee/$1" "~/src/git/$1"
    fi
}


# -------------------------------------------------------------------
# --- miscellaneous scripts
# a script for mapping CAPS to ESC outside X
safely-link caps2esc.map

# -------------------------------------------------------------------
# --- login scripts
safely-link .xinitrc
safely-link .xsessionrc
safely-link .Xresources
safely-link .xmonad

# -------------------------------------------------------------------
# --- shell and multiplexer configs
safely-link .inputrc
safely-link .bashrc
safely-link .bash_aliases
safely-link .tmux.conf

# -------------------------------------------------------------------
# --- configs for various programs
safely-link .gitconfig   # git
safely-link .infokey     # the info pages
safely-link .gdbinit     # GNU debugger
safely-link .cgdb        # A GUI for GDB
safely-link .Rprofile    # R
safely-link .ctags       # ctags
safely-link .xmobarrc    # xmobar

# -------------------------------------------------------------------
# --- vim setup
safely-link .vimrc
safely-link .goyo.vimrc

[[ -h $HOME/.vim ]] && rm $HOME/.vim
mkdir -p $HOME/.vim/bundle
safely-link .vim/UltiSnips $HOME/.vim/UltiSnips
safely-link .vim/ftdetect  $HOME/.vim/ftdetect
safely-link .vim/ftplugin  $HOME/.vim/ftplugin
safely-link .vim/syntax    $HOME/.vim/syntax

mkdir -p $HOME/.vimundo

vundledir=$HOME/.vim/bundle/Vundle.vim
vundlerep=https://github.com/VundleVim/Vundle.vim.git
[[ -r $vundledir ]] || git clone $vundlerep $vundledir
vim +PluginClean +PluginInstall +qall

colorscheme=distinguished
colorscheme_path=$HOME/.vim/bundle/vim-distinguished/colors
if [[ -f "${colorscheme_path}/${colorscheme}.vim" ]]
then
    mkdir -p $HOME/.vim/colors
    cp -sf ${colorscheme_path}/${colorscheme}.vim $HOME/.vim/colors
else
    echo "Colorscheme '$colorscheme' not found in directory '$colorscheme_path'" >&2
fi


# -------------------------------------------------------------------
# --- cleanup
rmdir $tmp 2> /dev/null
