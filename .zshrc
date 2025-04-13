########################
# General
########################

# homebrew
export HOMEBREW_HOME=/opt/homebrew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
path=($HOMEBREW_HOME/bin(N-/) $HOMEBREW_HOME/sbin(N-/) $path)
if type brew &>/dev/null; then
  # completions
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# package manager
eval "$(sheldon source)"

# Remove duplicated path
typeset -U path PATH

# EDITOR
export EDITOR='nvim'
export GIT_EDITOR=$EDITOR

# TERM
export TERM=screen-256color

# history config
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export HISTCONTROL=ignoreboth #ignorespace+ignoredups
export HISTIGNORE="fg*:bg*:history*:cd*:ls*"
export HISTTIMEFORMAT='%Y-%m-%d %T ';

# only define LC_CTYPE if undefined
if [[ -z "$LC_CTYPE" && -z "$LC_ALL" ]]; then
  export LC_CTYPE=${LANG%%:*} # pick the first entry from LANG
fi

# pager
export PAGER="less"
export LESS='-gj10 -X -F -R'
export LESSOPEN='| src-hilite-lesspipe.sh %s'

# wordchar
export WORDCHARS=''

# XDG_CONFIG_HOME
export XDG_CONFIG_HOME=~/.config

# sbin
path=(/sbin(N-/) /usr/sbin(N-/) $path)

# Add dotfiles/bin
path=(~/dotfiles/bin(N-/) $path)

# .zshrc.local
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# load functions
[ -f ~/.zfunctions ] && source ~/.zfunctions

# zcompile
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

# autoload
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
autoload -Uz zmv

# setopt
setopt always_to_end
setopt append_history
setopt auto_cd
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt auto_pushd
setopt cdablevars
setopt complete_in_word
setopt correct
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt interactivecomments
setopt long_list_jobs
setopt magic_equal_subst
setopt multios
setopt path_dirs
setopt print_eight_bit
setopt prompt_subst
setopt pushd_ignore_dups
setopt pushdminus
setopt share_history

# emacs mode
bindkey -e

# show_buffer_stack
bindkey '^]' show_buffer_stack

# cdr
add-zsh-hook chpwd chpwd_recent_dirs

# Global aliases
alias -g F='| fzf'
alias -g G='| grep'
alias -g GI='| grep -i'
alias -g GV='| grep -v'
alias -g H='| head'
alias -g L='| less'
alias -g PC='| pbcopy'
alias -g S="| sort"
alias -g T='| tail'
alias -g W='| wc -l'
alias -g X='| xargs'
alias -g N=" >/dev/null 2>&1"
alias -g N1=" >/dev/null"
alias -g N2=" 2>/dev/null"
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# sudo
alias _='sudo'

# cd
alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

# grep
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'

# history
alias history='fc -l 1'

# gnu-ln
alias ln='gln'

# gnu-ls
# require coreutils
alias ls='gls --color=auto'
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
alias latr='ls -lAhtr'

# mkdir
alias md='mkdir -p'

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# rmdir
alias rd=rmdir

# gnu-sed
alias sed='gsed'

# less +F
alias tailf='LESSOPEN= less +F'

# gnu-tar
alias tar='gtar'

# dotfiles
alias rz='source ~/.zshrc'
alias vg='v ~/.gitconfig'
alias vv='v $XDG_CONFIG_HOME/nvim/init.vim'
alias vz='v ~/.zshrc $XDG_CONFIG_HOME/sheldon/plugins.toml'

# completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:*:*:*:*' menu select

# zsh-autosuggest
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=auto_bundle_exec_accept_line

########################
# Specific
########################

# ag
alias ag='ag -S'
alias agh='ag --hidden'

# asdf.sh
[ -f $(brew --prefix asdf)/libexec/asdf.sh ] && source $(brew --prefix asdf)/libexec/asdf.sh

# base16 shell
BASE16_SHELL="$XDG_CONFIG_HOME/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"
base16_solarized-dark

# bundler
alias b='bundle'
alias bi='bundle install'
alias be='bundle exec'
alias bl='bundle list'
alias bp='bundle package'
alias bo='bundle open'
alias bu='bundle update'
alias bs='bundle show'

# colordiff
# color config ~/.colordiffrc
# require: export LESS='-R'
alias diff='colordiff -u'

# diff-highlight
if [[ ! -e $HOMEBREW_HOME/bin/diff-highlight ]]; then
  ln -s $HOMEBREW_HOME/opt/git/share/git-core/contrib/diff-highlight/diff-highlight $HOMEBREW_HOME/bin
fi

# direnv config
if type direnv > /dev/null 2>&1; then
  # `eval "$(direnv hook $SHELL)"` doesn't work in RubyMine terminal
  eval "$(direnv hook $0)"
  export DIRENV_LOG_FORMAT=
fi

# fzf
export FZF_DEFAULT_COMMAND='ag'
export FZF_DEFAULT_OPTS='--extended --cycle --select-1 --exit-0 --multi'

# git
export GIT_HOME=$HOME/src
alias g='git'
alias ga='g add -v'
alias gaa='g add -Av'
alias gb='g branch'
alias gbs='g branches'
alias gbr='gh repo view --web'
alias gc='g commit -v'
alias gcb='g checkout -b'
alias gco='g checkout'
alias gcon='g config'
alias gcom='g compare'
alias gcl='g clone-repo'
alias gcp='g cherry-pick'
alias gd='g diff'
alias gdc='g diff --cached'
alias gdp='g diff HEAD^ HEAD'
alias gdm='g diffmerge'
alias gf='g fetch'
alias gfa='g fetch --all'
alias gfu='g fetch upstream'
alias gfo='g fetch origin'
alias ggr='g grep -n -H --heading --break'
alias gl='g log --stat'
alias glg='g log --graph --decorate --oneline'
alias gla='g log --graph --decorate --all'
alias glo='g log --oneline'
alias glsf='g ls-files'
alias gmg='g merge'
alias gn='g now'
alias gna='g now --all'
alias gp='g push -v'
alias gpl='g pull'
alias gpr='gh pr create'
alias gprco='gh pr checkout'
alias grb='g rebase'
alias grbi='g rebase -i'
alias grbih='g rebase -i HEAD^^'
alias grm='g rm'
alias grmc='g rm --cached'
alias grs='g reset'
alias grsh='g reset --hard'
alias grss='g reset --soft'
alias grv='g revert'
alias gs='g status -b -s -u'
alias gsd='g status -u'
alias gsh='g show'
alias gst='g stash'
alias gstc='g stash clear'
alias gstl='g stash list'
alias gstp='g stash pop'

# git checkout
bindkey '^V^B' _fzf_git_checkout_branch
# git repo
bindkey '^V^V' _fzf_cd_git_src

# Go
export GOPATH=$HOME/go
path=($GOPATH/bin(N-/) $path)

# history-substring-search-up
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# java
# export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
# path+=($JAVA_HOME(N-/))
# OpenJDK
path=($HOMEBREW_HOME/opt/openjdk/bin(N-/) $path)
export CPPFLAGS="-I$HOMEBREW_HOME/opt/openjdk/include"

# kill
bindkey '^V^K' _fzf_kill_process

# krew
path+=(~/.krew/bin(N-/))

# kubecolor
# make completion work with kubecolor
source <(kubectl completion zsh)
compdef kubecolor=kubectl

# kubectl
alias _k='kubectl'
alias k='kubecolor'
alias ka='k apply'
alias kat='k attach'
alias kc='k config'
alias kd='k describe'
alias kde='k debug'
alias kdi='k diff'
alias ke='k exec'
alias kg='k get'
alias kk='k kustomize'
alias kl='k logs'
alias kp='k port-forward'
alias krm='k delete'

# kustomize
alias kz='kustomize'
alias kzb='kz build'

# memo
alias memo=_memo

# minikube
alias mk='minikube'
alias mks='mk start'

# mysql
path=($HOMEBREW_HOME/opt/mysql@5.7/bin(N-/) $path)
export LDFLAGS="-L$HOMEBREW_HOME/opt/mysql@5.7/lib:$LDFLAGS"
export CPPFLAGS="-I$HOMEBREW_HOME/opt/mysql@5.7/include:$CPPFLAGS"
export PKG_CONFIG_PATH="$HOMEBREW_HOME/opt/mysql@5.7/lib/pkgconfig:$PKG_CONFIG_PATH"
alias mysql="mysql --pager='less -S -i -F'"
alias mysql-start='mysql.server start'
alias mysql-stop='mysql.server stop'
alias mysql-restart='mysql.server restart'

# nvim
alias v='nvim'
alias vi='v'
alias vr='v -R'

# nodebrew
path+=(~/.nodebrew/current/bin(N-/))

# nodenv
[ -d $HOMEBREW_HOME/opt/nodenv ] && eval "$(nodenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"

# OpenSSL
path=($HOMEBREW_HOME/opt/openssl@3/bin(N-/) $path)
export LDFLAGS="-L$HOMEBREW_HOME/opt/openssl@3/lib:$LDFLAGS"
export CPPFLAGS="-I$HOMEBREW_HOME/opt/openssl@3/include:$CPPFLAGS"
export PKG_CONFIG_PATH="$HOMEBREW_HOME/opt/openssl@3/lib/pkgconfig:$PKG_CONFIG_PATH"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"

# Perl5
path+=(~/perl5(N-/))
path+=(~/perl5/bin(N-/))
path+=(~/perl5/lib/perl5(N-/))
export PERL_CPANM_OPT=--local-lib=~/extlib
export PERL5LIB=$HOME/extlib/lib/perl5:$PERL5LIB

# postgresql
export PGDATA=$HOMEBREW_HOME/var/postgresql@14
path=($HOMEBREW_HOME/opt/postgresql@14/bin(N-/) $path)
export LDFLAGS="-L$HOMEBREW_HOME/opt/postgresql@14/lib/postgresql@14:$LDFLAGS"
export CPPFLAGS="-I$HOMEBREW_HOME/opt/postgresql@14/include/postgresql@14:$CPPFLAGS"
export PKG_CONFIG_PATH="$HOMEBREW_HOME/opt/postgresql@14/lib/postgresql@14/pkgconfig:$PKG_CONFIG_PATH"
alias pg-start='pg_ctl -l $HOMEBREW_HOME/var/postgresql@14/server.log -D $HOMEBREW_HOME/var/postgresql@14 start'
alias pg-stop='pg_ctl stop -s -m fast'
alias pg-restart='pg-stop && sleep 1 && pg-start'

# For pkg-config to find libxml2 on nokogiri.gem installation
export PKG_CONFIG_PATH="$HOMEBREW_HOME/opt/libxml2/lib/pkgconfig:$PKG_CONFIG_PATH"

# rails
alias rr='bin/rails'

# redis
alias redis-start='redis-server $HOMEBREW_HOME/etc/redis.conf --daemonize yes'
alias redis-stop='redis-cli shutdown'

# rust with cargo
path+=(~/.cargo/bin(N-/))
export RUST_SRC_PATH=~/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src/

# starship
eval "$(starship init zsh)"

# tig
alias t='tig'
alias ta='tig --all'
alias tb='tig blame'
alias tl='tig log'
alias tg='tig grep'
alias ts='tig status'

# tmux
alias tmuxa='tmux_automatically_attach_session'

# zsh-autocomplete
zstyle ':autocomplete:*' insert-unambiguous yes
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

# Rancher desktop
path+=(~/.rd/bin(N-/))
