#!/bin/sh

function usage() {
  cat <<END
Usage: $0 [COMMAND]
Install or update vim.

  install       install vim.
  update        update vim.
  neobundle     install neobundle.vim
  help          show this usage. [default]
END
}


function install() {
  [ -d ~/local/src ] || mkdir -p ~/local/src
  cd ~/local/src && \
  hg clone https://vim.googlecode.com/hg ./vim && \
  cd vim/ && \
  build
}


function update() {
  if hg incoming >/dev/null; then
    cd ~/local/src/vim && \
    hg pull && hg update && \
    build
  fi
}


function build() {
  ./configure --prefix=$HOME/local --with-features=huge \
    --enable-multibyte --enable-xim --enable-fontset \
    --disable-gui && \
  make && \
  make install
}


function neobundle() {
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


function main() {
  case "$1" in
    'install') install ;;
    'update') update ;;
    'neobundle') neobundle ;;
    'help') usage ;;
    *) usage >/dev/stderr ;;
  esac
}


main "$@"
exit 0
