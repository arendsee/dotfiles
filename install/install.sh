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
# the Haskell tool stack - needed for H and HaskellR
pacman -S stack

# ---------------------------------------------------------
# --- OCaml stuff
# ocaml compiler and all that
pacman -S ocaml
# ocaml package manager
pacman -S opam

# ---------------------------------------------------------
# --- shell and xmonad stuff
# urxvt
pacman -S rxvt-unicode
# allow zooming etc
yaourt -S urxvt-resize-font-git
# run-like command for xmonad, allows partial matching
pacman -S dmenu

# ---------------------------------------------------------
# --- other
# A totally wicked cool PDF reformater
yaourt -S k2pdfopt


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
