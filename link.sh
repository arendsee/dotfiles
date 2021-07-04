#!/usr/bin/env bash

usage (){
cat << EOF
Build my system
 * link all dotfiles to home directory
 * make ~/.config/ if missing
 * build ~/.vim/
   * make ~/.vim/bundle/ and setup vim package manager
   * setup colorscheme (distinguished)
   * move these files from here to ~/.vim
     * ~/.vim/UltiSnips
     * ~/.vim/ftdetect
     * ~/.vim/ftplugin
     * ~/.vim/syntax
     * ~/.vim/after
 * make ~/.vimundo/
 * install all vim plugins
 * make ~/bin/
 * retrieve dropbox.py

Files already present in home will be copied to a temporary folder
EOF
    exit 0
}

while getopts "h" opt; do
    case $opt in
        h)
            usage ;;
    esac 
done

# Link all files in dotfiles. If the existing file is a symbolic link, it is
# removed and replaced with a link to the corresponding file from this
# repository. Otherwise, the existing file is moved to a temporary folder.

tmp=/tmp/dotfiles-$(date | tr ' ' '-')
mkdir -p $tmp

# Before linking a file, the permissions are set to 644, so as not to let them
safely-link () {
    src="$PWD/$1"
    des=$2
    des=${des:="$HOME/$1"}

    if [[ -f $src ]]
    then
        chmod 644 $src
    fi

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
# --- .config directory
mkdir -p ~/.config
safely-link .config/zathura

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
safely-link .astylerc    # astyle formatter for C/C++/Java code
safely-link .ghci        # ghci customizations
safely-link .irssi       # irssi IRC config

# -------------------------------------------------------------------
# --- haskell setup
safely-link .cabal/config $HOME/.cabal/config
# configuration for Haskell shell
safely-link .ghc/ghci.conf $HOME/.ghc/ghci.conf 
# configureation for Stack
safely-link .stack/config.yaml $HOME/.stack/config.yaml

# -------------------------------------------------------------------
# --- rust setup
mkdir -p .cargo
safely-link .cargo/config

# -------------------------------------------------------------------
# --- guile setup
safely-link .guile

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
safely-link .vim/after     $HOME/.vim/after

mkdir -p $HOME/.vimundo

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugClean +PlugInstall +qall

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
# Filesystem setup

# Make $HOME/bin directory if absent
[[ -d $HOME/bin ]] || mkdir $HOME/bin

# Get dropbox CLI script
if [[ ! -f ~/bin/dropbox.py ]]
then
    wget -O ~/bin/dropbox.py "https://www.dropbox.com/download?dl=packages/dropbox.py"
    chmod 755 ~/bin/dropbox.py
fi


# -------------------------------------------------------------------
# --- cleanup
rmdir $tmp 2> /dev/null
