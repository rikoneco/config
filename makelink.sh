#!/bin/bash

files=(
  .Xmodmap
  .gitconfig
  .pythonstartup.py
  .vimperatorrc
  .vimrc
  .zprofile
  .zshrc
  )

for file in ${files[@]}; do
  if [ -h ~/$file ]; then
    echo "delete link ~/$file"
    rm -f ~/$file
  elif [ -f ~/$file ]; then
    echo "rename file ~/$file -> ~/$file.orig"
    mv ~/$file ~/$file.orig
  fi

  echo "create link ~/$file"
  ln -s ~/config/dot$file ~/$file
done
