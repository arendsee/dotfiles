#!/bin/sh

setxkbmap -option "caps:escape"

# # Merge xterm configurations
# [[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
#
# exec xmonad
