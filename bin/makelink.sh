#!/bin/sh

files=(.Xmodmap .gitconfig .vimrc .vimperatorrc .zshenv .zshrc)


function usage() {
  cat <<END
Usage: $0 [COMMAND]
Create or delete symbolic links of dotfiles.

  create     create links.
  delete     delete existing links.
  help       show this usage. [default]
END
}


function makelink() {
  for file in ${files[@]}; do
    if [ -h ~/$file ]; then
      echo "delete link ~/$file"
      rm -f ~/$file
    elif [ -f ~/$file ]; then
      echo "rename file ~/$file -> ~/$file.orig"
      mv ~/$file ~/$file.orig
    fi

    if [ "$1" = 'create' ]; then
      echo "create link ~/$file"
      ln -s ~/config/dot$file ~/$file
    fi
  done
}


function main() {
  case "$1" in
    'create') makelink create ;;
    'delete') makelink delete ;;
    'help') usage ;;
    *) usage >/dev/stderr ;;
  esac
}


main "$@"
exit 0
