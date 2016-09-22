# ---------------------------------------------------------
# --- Haskell stuff
# Haskell compiler 
pacman -S ghc
# Haskell modeule install
pacman -S cabal-install
# A library for improved editor handling of Haskell
pacman -S ghc-mod
# ctags equivalent for haskell
pacman -S hasktags

# ---------------------------------------------------------
# --- shell and xmonad stuff
# urxvt
pacman -S rxvt-unicode
# allow zooming etc
yaourt -S urxvt-resize-font-git
# run-like command for xmonad, allows partial matching
pacman -S dmenu

# ---------------------------------------------------------
# --- utilities
pacman -S zathura zathura-pdf-poppler zathura-ps
# used in vvs alias in bash_aliases
pacman -S pamixer
# A GUI that allows me to turn my damn head phones on
# I really need to find a better solution
pacman -S pavucontrol
# check battery power
pacman -S acpi
# for background images
pacman -S feh

# ---------------------------------------------------------
# --- debugging and coding
# GNU debugger
pacman -S gdb
# Cursed GNU debugger
pacman -S cgdb
# needed for autformat in vim for C, C++, Java
pacman -S astyle
