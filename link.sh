#!/usr/bin/env bash

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
safely-link .xmonad

[[ -h $HOME/.vim ]] && rm $HOME/.vim
mkdir -p $HOME/.vim/bundle
safely-link .vim/UltiSnips $HOME/.vim/UltiSnips
safely-link .vim/ftdetect  $HOME/.vim/ftdetect
safely-link .vim/ftplugin  $HOME/.vim/ftplugin
safely-link .vim/syntax    $HOME/.vim/syntax

vundledir=$HOME/.vim/bundle/Vundle.vim
vundlerep=https://github.com/VundleVim/Vundle.vim.git
[[ -r $vundledir ]] || git clone $vundlerep $vundledir
vim +PluginClean +PluginInstall +qall

colorscheme=$HOME/.vim/bundle/vim-distinguished/colors/distinguished.vim
if [[ -f $colorscheme ]]
then
    mkdir -p $HOME/.vim/colors
    cp -sf $colorscheme $HOME/.vim/colors
else
    echo "Color scheme not found" >&2
fi

rmdir $tmp 2> /dev/null
