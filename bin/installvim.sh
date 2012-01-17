#!/bin/sh

# Usage:
#   % ./vimbuild {install|update|plugin}


_install() {
  [ -d ~/local/src ] || mkdir -p ~/local/src
  cd ~/local/src && \
  hg clone https://vim.googlecode.com/hg ./vim && \
  cd vim/ && \
  _build
}


_update() {
  cd ~/local/src/vim && \
  hg pull && hg update && \
  _build
}


_build() {
  ./configure --with-features=huge --disable-gui \
    --enable-multibyte --enable-xim --enable-fontset  && \
  make && \
  echo "execute 'sudo make install' for installation"
}


_plugin() {
  [ -d ~/.neobundle ] || mkdir ~/.neobundle
  cd ~/.neobundle && \
  git clone git://github.com/Shougo/neobundle.vim.git && \
  vim -u NONE -N \
    -c "filetype off" \
    -c "set runtimepath+=~/.neobundle/neobundle.vim" \
    -c "call neobundle#rc(expand('~/.neobundle'))" \
    -c "NeoBundle 'git://github.com/Shougo/neobundle.vim.git'" \
    -c "NeoBundle 'git://github.com/Shougo/unite.vim.git'" \
    -c "NeoBundle 'git://github.com/Shougo/vimproc.git'" \
    -c "filetype plugin indent on" \
    -c "NeoBundleInstall" \
    -c "helptags ~/.neobundle/neobundle.vim/doc" \
    -c "quit" && \
  cd ~/.neobundle/vimproc && \
  make -f make_gcc.mak
}


if [ $# -eq 1 ] && \
  [ "$1" = "install" -o "$1" = "update" -o "$1" = "plugin" ]; then
  _$1
else
  echo "ERROR: invalid argument" >/dev/stderr && exit 1
fi

exit 0
