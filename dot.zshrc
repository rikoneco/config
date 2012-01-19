# history
setopt append_history extended_history hist_ignore_all_dups
setopt hist_ignore_space hist_no_store hist_reduce_blanks hist_verify
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# shell options
setopt auto_pushd pushd_ignore_dups pushd_silent pushd_to_home
setopt no_beep

# completion
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
autoload -Uz compinit
compinit
setopt always_last_prompt bash_auto_list auto_param_keys auto_param_slash
setopt auto_remove_slash list_ambiguous list_types

# prompt
# HOST: CWD
# %
autoload -Uz vcs_info
precmd() {vcs_info}
setopt prompt_subst prompt_percent prompt_cr prompt_sp
PROMPT=$'%B%F{2}%n@%M:%~%f %F{1}${vcs_info_msg_0_}%f\n%F{2}%#%f%b '

# functions
function cd() {builtin cd $1; ls;}
function alc() {w3m http://eow.alc.co.jp/$1/UTF-8/?ref=sa | less}
function wikipedia() {w3m http://ja.wikipedia.org/wiki/$1 | less}

# aliases
alias ,.=' source ~/.zshrc'
alias ,,=' vim ~/.zshrc'
alias ls=' ls -F --color=auto'
alias ll=' ls -hl'
alias la=' ls -A'
alias lla=' ls -Ahl'
alias le=' less'
alias j=' jobs -l'
alias h=' history'
alias d=' dirs -vpl'
alias cp='cp -pr'
alias mkdir='mkdir -p'
alias v='vim'
alias vi='vim'
alias w='w3m -B'
alias g='git'

alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
if which pbcopy >/dev/null 2>&1; then
  alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1; then
  alias -g C='| xsel --input --clipboard'
fi

# vim installation
function viminstall() {
  [ -d ~/local/src ] || mkdir -p ~/local/src
  cd ~/local/src && \
  hg clone https://vim.googlecode.com/hg ./vim && \
  cd vim/ && \
  vimbuild
}

function vimupdate() {
  cd ~/local/src/vim && \
  if hg incoming; then
    hg pull && \
    hg update && \
    vimbuild
  fi
}

function vimbuild() {
  ./configure \
    --with-features=huge --disable-gui \
    --enable-rubyinterp --enable-pythoninterp --enable-python3interp \
    --enable-multibyte --enable-xim --enable-fontset && \
  make
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
