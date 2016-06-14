# Compile vim my way
# Works on Archlinux

all:
	sudo abs
	cp /var/abs/extra/vim/* .
	# Required for pasting to X clipboard from vim
	sed -i 's/--with-x=no/--with-x=yes/' PKGBUILD
	# I do this to avoid conflicts with my broken perl
	sed -i 's/--enable-perlinterp=dynamic/--disable-perlinterp/' PKGBUILD
	makepkg PKGBUILD
	sudo pacman -R vim-runtime vim
	sudo pacman -U vim-*.tar.xz

.PHONY: clean
clean:
	rm -fr PKGBUILD vimrc gvim.desktop gvim.install archlinux.vim *xz *gz pkg src
