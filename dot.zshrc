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
# reset=%{\e[00m%}
# red=%{\e[1;31m%}
# green=%{\e[1;32m%}
# yellow=%{\e[1;33m%}
# blue=%{\e[1;34m%}
# purple=%{\e[1;35m%}
# cyan=%{\e[1;36m%}
PROMPT=$'%{\e[1;32m%}%n@%M:%~\n%#%{\e[00m%} '
RPROMPT=$'%{\e[1;31m%}${vcs_info_msg_0_}%{\e[00m%}'

# functions
cd() {builtin cd $@; ls;}

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
alias w='w3m -B'

