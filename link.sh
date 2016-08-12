#!/usr/bin/env bash

# Link all files in dotfiles. If the existing file is a symbolic link, it is
# removed and replaced with a link to the corresponding file from this
# repository. Otherwise, the existing file is moved to a temporary folder.

tmp=/tmp/dotfiles-$(date | tr ' ' '-') 
mkdir -p $tmp


safely-link () {
    src="$PWD/$1"
    [[ -z "$2" ]] && des="$HOME/$1" || des="$2"
    [[ ! -h "$des" && -r "$des" ]] && (mv "$des" "$tmp" && echo "Moving '$des' to $tmp")
    ln -sf "$src" "$des"
}

safely-link .Rprofile
safely-link .bashrc
safely-link .bash_aliases
safely-link .ctags
safely-link .gitconfig
safely-link .gitignore
safely-link .tmux.conf
safely-link .vimrc
safely-link .xinitrc
safely-link .Xresources
safely-link .xmobarrc
safely-link caps2esc.map
safely-link .vim
safely-link .xmonad

rmdir $tmp 2> /dev/null
