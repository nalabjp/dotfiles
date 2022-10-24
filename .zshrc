# dotifiles directory
DOTFILES=~/ghq/github.com/nalabjp/dotfiles

# arm64
export HOMEBREW_HOME=/opt/homebrew

# Homebrew no auto update
export HOMEBREW_NO_AUTO_UPDATE=1

# sbin
path=(/sbin(N-/) /usr/sbin(N-/) $path)

# Add brew path
path=($HOMEBREW_HOME/bin(N-/) $HOMEBREW_HOME/sbin(N-/) $path)

# Add dotfiles/bin
path=(~/dotfiles/bin(N-/) $path)

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

# rbenv
export RBENV_ROOT=$(rbenv root)
path=($RBENV_ROOT/bin(N-/) $path)

if [ $+commands[rbenv] -ne 0 ]; then
  rbenv_init(){
    # eval "$(rbenv init - --no-rehash)" is crazy slow (it takes arround 100ms)
    # below style took ~2ms
    export RBENV_SHELL=zsh
    source $HOMEBREW_HOME/opt/rbenv/completions/rbenv.zsh
    rbenv() {
      local command
      command="$1"
      if [ "$#" -gt 0 ]; then
        shift
      fi

      case "$command" in
      rehash|shell)
        eval "`rbenv "sh-$command" "$@"`";;
      *)
        command rbenv "$command" "$@";;
      esac
    }
    path=(~/.rbenv/shims(N-/) $path)
  }
  rbenv_init
  unfunction rbenv_init
fi

# nodebrew
path+=(~/.nodebrew/current/bin(N-/))

# nvm
export NVM_DIR="$HOME/.nvm"

# java
# export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
# path+=($JAVA_HOME(N-/))
# OpenJDK
path=($HOMEBREW_HOME/opt/openjdk/bin(N-/) $path)
export CPPFLAGS="-I$HOMEBREW_HOME/opt/openjdk/include"

# zsh-bundle-exec.zsh
export BUNDLE_EXEC_GEMFILE_CURRENT_DIR_ONLY=yes
export BUNDLE_EXEC_COMMANDS='ruby rails rake rspec spring'

# fzf
export FZF_DEFAULT_COMMAND='ag'
export FZF_DEFAULT_OPTS='--extended --cycle --select-1 --exit-0 --multi'

# only define LC_CTYPE if undefined
if [[ -z "$LC_CTYPE" && -z "$LC_ALL" ]]; then
  export LC_CTYPE=${LANG%%:*} # pick the first entry from LANG
fi

# pager
export PAGER="less"
export LESS='-gj10 -X -F -R'
export LESSOPEN='| /opt/homebrew/bin/src-hilite-lesspipe.sh %s'

# wordchar
export WORDCHARS=''

# homebrew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1

# gdircolors
eval $(gdircolors ~/ghq/github.com/nalabjp/mac/themes/dircolors-solarized/dircolors.256dark)

# direnv config
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook $SHELL)"
  export DIRENV_LOG_FORMAT=
fi

# XDG_CONFIG_HOME
export XDG_CONFIG_HOME=~/.config

# enhancd
export ENHANCD_COMMAND=e

# zplug
export ZPLUG_HOME=$HOMEBREW_HOME/opt/zplug
path+=($ZPLUG_HOME/bin(N-/))

# Rust with cargo
path+=(~/.cargo/bin(N-/))
export RUST_SRC_PATH=~/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src/

# Perl5
path+=(~/perl5(N-/))
path+=(~/perl5/bin(N-/))
path+=(~/perl5/lib/perl5(N-/))
export PERL_CPANM_OPT=--local-lib=~/extlib
export PERL5LIB=$HOME/extlib/lib/perl5:$PERL5LIB

# MySQL
path=($HOMEBREW_HOME/opt/mysql@5.7/bin(N-/) $path)
export LDFLAGS="-L$HOMEBREW_HOME/opt/mysql@5.7/lib:$LDFLAGS"
export CPPFLAGS="-I$HOMEBREW_HOME/opt/mysql@5.7/include:$CPPFLAGS"
export PKG_CONFIG_PATH="$HOMEBREW_HOME/opt/mysql@5.7/lib/pkgconfig:$PKG_CONFIG_PATH"

# postgresql
export PGDATA=$HOMEBREW_HOME/var/postgresql@11
path=($HOMEBREW_HOME/opt/postgresql@11/bin(N-/) $path)
export LDFLAGS="-L$HOMEBREW_HOME/opt/postgresql@11/lib:$LDFLAGS"
export CPPFLAGS="-I$HOMEBREW_HOME/opt/postgresql@11/include:$CPPFLAGS"
export PKG_CONFIG_PATH="$HOMEBREW_HOME/opt/postgresql@11/lib/pkgconfig:$PKG_CONFIG_PATH"

# For pkg-config to find libxml2 on nokogiri.gem installation
export PKG_CONFIG_PATH="$HOMEBREW_HOME/opt/libxml2/lib/pkgconfig:$PKG_CONFIG_PATH"

# OpenSSL
path=($HOMEBREW_HOME/opt/openssl@1.1/bin(N-/) $path)
export LDFLAGS="-L$HOMEBREW_HOME/opt/openssl@1.1/lib:$LDFLAGS"
export CPPFLAGS="-I$HOMEBREW_HOME/opt/openssl@1.1/include:$CPPFLAGS"
export PKG_CONFIG_PATH="$HOMEBREW_HOME/opt/openssl@1.1/lib/pkgconfig:$PKG_CONFIG_PATH"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# krew
path+=(~/.krew/bin(N-/))

# Go
export GOPATH=$HOME/go
path=($GOPATH/bin(N-/) $path)

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

# history
bindkey '^R' anyframe-widget-put-history

# cdr
add-zsh-hook chpwd chpwd_recent_dirs

# history-substring-search-up
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# anyframe
bindkey '^V^B' 'anyframe-widget-checkout-git-branch'
bindkey '^V^K' 'anyframe-widget-kill'
bindkey '^V^V' 'anyframe-widget-cd-ghq-repository'

# completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:*:*:*:*' menu select

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

# ag
alias ag='ag -S'
alias agh='ag --hidden'

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

# git
alias g='hub'
alias ga='g add -v'
alias gaa='g add -Av'
alias gb='g branch'
alias gbs='g branches'
alias gbr='g browse'
alias gc='g commit -v'
alias gcb='g checkout -b'
alias gco='g checkout'
alias gcon='g config'
alias gcom='g compare'
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
alias gn='g now --all --stat'
alias gp='g push -v'
alias gpl='g pull'
alias gpr='g pull-request'
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

# grep
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'

# history
alias history='fc -l 1'

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

# memo
alias memo=_memo

# mkdir
alias md='mkdir -p'

# minikube
alias mk='minikube'
alias mks='mk start'

# mysql
alias mysql="mysql --pager='less -S -i -F'"
alias mysql-start='mysql.server start'
alias mysql-stop='mysql.server stop'
alias mysql-restart='mysql.server restart'

# Aliases to stop, start and restart Postgres
# Paths noted below are for Postgress installed via Homebrew on OSX
alias pg-start='pg_ctl -l $HOMEBREW_HOME/var/postgres/server.log start'
alias pg-stop='pg_ctl stop -s -m fast'
alias pg-restart='pg-stop && sleep 1 && pg-start'

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# reload .zshrc
alias rz='source ~/.zshrc'

# rails
alias rr='bin/rails'

# rmdir
alias rd=rmdir

# redis
alias redis-start='redis-server /opt/homebrew/etc/redis.conf --daemonize yes'
alias redis-stop='redis-cli shutdown'

# gnu-sed
alias sed='gsed'

# less +F
alias tailf='LESSOPEN= less +F'

# gnu-tar
alias tar='gtar'

# tig
alias t='tig'
alias ta='tig --all'
alias tb='tig blame'
alias tl='tig log'
alias tg='tig grep'
alias ts='tig status'

# tmux
alias tmuxa='tmux_automatically_attach_session'

# nvim
alias v='_vim'
alias vi='v'
alias vr='v -R'

# edit dotfiles
alias vg='v ~/.gitconfig'
alias vv='v ~/.config/nvim/init.vim'
alias vz='v ~/.zshrc'

# homebrew completions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# zplug
source $ZPLUG_HOME/init.zsh

zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'zsh-users/zsh-history-substring-search'
zplug 'mollifier/anyframe'
zplug 'nalabjp/zsh-bundle-exec'
zplug 'zsh-users/zsh-autosuggestions'

if ! zplug check; then
  zplug install
fi

# load
zplug load

# diff-highlight
if [[ ! -e $HOMEBREW_HOME/bin/diff-highlight ]]; then
  ln -s $HOMEBREW_HOME/opt/git/share/git-core/contrib/diff-highlight/diff-highlight $HOMEBREW_HOME/bin
fi

# autosuggest
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=auto_bundle_exec_accept_line

# kubecolor
# make completion work with kubecolor
source <(kubectl completion zsh)
compdef kubecolor=kubectl

# asdf.sh
[ -f $(brew --prefix asdf)/libexec/asdf.sh ] && source $(brew --prefix asdf)/libexec/asdf.sh

# .zshrc.local

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# starship
eval "$(starship init zsh)"

# nodenv
[ -d /opt/homebrew/opt/nodenv ] && eval "$(nodenv init -)"

# load functions
[ -f ~/.zfunctions ] && source ~/.zfunctions

# Remove duplicated path
typeset -U path PATH

# zcompile
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

