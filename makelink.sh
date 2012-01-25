#!/bin/sh

files=(.Xmodmap .gitconfig .pythonstartup .vimrc .vimperatorrc .zshenv .zshrc)


function usage() {
  cat <<END
Usage: $0 [COMMAND]
Create or delete symbolic links of dotfiles.

  create     create links.
  delete     delete existing links.
  help       show this usage. [default]
END
}


function create() {
  delete
  for file in ${files[@]}; do
    echo "create link ~/$file"
    ln -s ~/config/dot$file ~/$file
  done
}


function delete() {
  for file in ${files[@]}; do
    if [ -h ~/$file ]; then
      echo "delete link ~/$file"
      rm -f ~/$file
    elif [ -f ~/$file ]; then
      echo "rename file ~/$file -> ~/$file.orig"
      mv ~/$file ~/$file.orig
    fi
  done
}


case "$1" in
  'create') create ;;
  'delete') delete ;;
  'help') usage ;;
  *) usage >/dev/stderr ;;
esac


exit 0
