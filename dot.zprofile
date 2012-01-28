# PATH
PATH=/usr/local/bin:/usr/bin:/bin
MANPATH=/usr/local/man:/usr/local/share/man:/usr/share/man
if [ -d $HOME/local ]; then
  for i in $HOME/local/*; do
    if [ -d $i/bin ]; then PATH=$i/bin:$PATH; fi
    if [ -d $i/share/man ]; then MANPATH=$i/share/man:$MANPATH; fi
    if [ -d $i/man ]; then MANPATH=$i/man:$MANPATH; fi
  done
fi
export PATH MANPATH


# environmental variables
export EDITOR=vim
export LANG=ja_JP.UTF-8
export LC_COLLATE=C
export LC_MESSAGES=C
export LC_TIME=C
export PAGER=less
export SHELL=$(which zsh)


# for python
#export PYTHONSTARTUP=~/.pythonstartup.py


# misc
if [ -d $HOME/.dropbox-dist ]; then
  $HOME/.dropbox-dist/dropboxd &
fi
