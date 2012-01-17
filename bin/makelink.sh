#!/bin/sh

# Usage:
#   % ./linkconfig {create|delete}


files=(.Xmodmap .gitconfig .vimrc .vimperatorrc .zshenv .zshrc)


_create() {
  _backup
  for file in ${files[@]}; do
    ln -s ~/config/dot$file ~/$file && echo "create ~/$file"
  done
}


_delete() {
  for file in ${files[@]}; do
    [ -f ~/$file -o -h ~/$file ] && \
      rm -f ~/$file && echo "delete ~/$file"
  done
}


_backup() {
  for file in ${files[@]}; do
    [ -f ~/$file ] && \
      mv ~/$file ~/$file.orig && echo "rename ~/$file -> ~/$file.orig"
  done
}


if [ $# -eq 1 ] && \
  [ "$1" = "create" -o "$1" = "delete" ]; then
  _$1
else
  echo "ERROR: invalid argument" >/dev/stderr && exit 1
fi

exit 0
