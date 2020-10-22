# Compile vim my way
# Works on Archlinux

# Also need to comment out all the gvim trash

all:
	asp update
	asp export vim
	mv vim/* .
	# Required for pasting to X clipboard from vim
	sed -i 's/--with-x=no/--with-x=yes/' PKGBUILD
	# makepkg PKGBUILD
	# sudo pacman -R vim-runtime vim
	# sudo pacman -U vim-*.tar.xz

.PHONY: clean
clean:
	rm -fr PKGBUILD PKGBUILD~ vimrc gvim.desktop gvim.install archlinux.vim *xz *gz pkg src *patch *hook vim/
