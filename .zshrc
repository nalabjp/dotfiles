#################################
# Prepare
#################################

# Add brew path
export PATH=/usr/local/bin:$PATH

# dotifiles directory
DOTFILES=$HOME/.dotfiles

# EDITOR
export EDITOR='vim'

# TERM
export TERM=xterm-256color

# history config
export HISTCONTROL=ignoreboth #ignorespace+ignoredups
export HISTIGNORE="fg*:bg*:history*:cd*:ls*"
export HISTTIMEFORMAT='%Y-%m-%d %T ';

# Homebrew Cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"

# rbenv
export RBENV_ROOT=$(rbenv root)
export PATH=$RBENV_ROOT/bin:$PATH

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# java
export JAVA_HOME="$(/usr/libexec/java_home)"
export PATH=$JAVA_HOME:$PATH

# php-fpm
export PATH="$(brew --prefix)/sbin:$PATH"

# postgresql
export PGDATA=/usr/local/var/postgres

# zsh-bundle-exec.zsh
export BUNDLE_EXEC_GEMFILE_CURRENT_DIR_ONLY=yes
export BUNDLE_EXEC_COMMANDS='rails rake rspec spring'

if [ $+commands[rbenv] -ne 0 ]; then
  rbenv_init(){
    # eval "$(rbenv init - --no-rehash)" is crazy slow (it takes arround 100ms)
    # below style took ~2ms
    export RBENV_SHELL=zsh
    source "$(brew --prefix rbenv)/completions/rbenv.zsh"
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
    path=($HOME/.rbenv/shims $path)
  }
  rbenv_init
  unfunction rbenv_init
fi

# karabiner
if [ -f /Applications/Karabiner.app/Contents/Library/bin/karabiner ]; then
  export PATH=/Applications/Karabiner.app/Contents/Library/bin:$PATH
  alias karabiner-export='karabiner export > $DOTFILES/src/karabiner-import.sh'
fi

# gdircolors
eval $(gdircolors $DOTFILES/themes/dircolors-solarized/dircolors.256dark)

# tmux launch
[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux

# zcompile
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile $HOME/.zshrc
fi

BASE16_SHELL=$DOTFILES/src/base16-solarized.dark.sh
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# compinit
autoload -Uz compinit
compinit

# add-zsh-hook
autoload -Uz add-zsh-hook

# cdr
autoload -Uz chpwd_recent_dirs cdr

# zmv
autoload -Uz zmv

#################################
# antigen
#################################

# Load antigen
source $DOTFILES/src/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle tmux
antigen bundle z

# framework of peco
antigen bundle mollifier/anyframe

# enhanced cd
antigen bundle b4b4r07/enhancd

# emoji-cli
antigen bundle b4b4r07/emoji-cli

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell antigen that you're done.
antigen apply

#################################
# src
#################################
# auto bundle exec
source $DOTFILES/src/zsh-bundle-exec.zsh

#################################
# aliases
#################################

# ag
alias ag='ag -S'
alias agh='ag --hidden'

# anyframe
alias af='anyframe-widget-select-widget'
alias afg='_anyframe-widget-cd-ghq-repository'
alias afga='anyframe-widget-git-add'
alias afgb='anyframe-widget-checkout-git-branch'
alias afc='_anyframe-widget-cdr'
alias afr='anyframe-widget-execute-history'
alias afp='anyframe-widget-put-history'
alias afkl='anyframe-widget-kill'
alias afi='anyframe-widget-insert-git-branch'
alias aff='anyframe-widget-insert-filename'

# bundler
alias b='bundle'
alias bi='bundle install'
alias be='bundle exec'
alias bl='bundle list'
alias bp='bundle package'
alias bo='bundle open'
alias bu='bundle update'
alias bs='bundle show'

# ctags
alias ctags-rails='ctags --exclude="*.js" --exclude=".git*" -R .'

# colordiff
# color config ~/.colordiffrc
# require: export LESS='-R'
alias diff='colordiff -u'

# git
alias ggr='git grep'

# gitsh
alias gs='gitsh'

# ls
# require coreutils
alias ls='gls --color=auto'

# mysql
alias mysql-start='mysql.server start'
alias mysql-stop='mysql.server stop'
alias mysql-restart='mysql.server restart'

# Aliases to stop, start and restart Postgres
# Paths noted below are for Postgress installed via Homebrew on OSX
alias pg-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg-stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias pg-restart='pg-stop && sleep 1 && pg-start'

# redis
alias redis-start='redis-server ~/conf.d/redis.conf'

# tmux
alias tsk='tmux send-keys'

# vim
alias v='vim'

# zmv
alias zmv_='noglob zmv'
alias zmv='zmv_ -W'
alias zcp='zmv_ -C'
alias zln='zmv_ -L'

#################################
# functions
#################################

# command line stack
show_buffer_stack() {
  POSTDISPLAY="
stack: $LBUFFER"
  zle push-line-or-edit
}
zle -N show_buffer_stack

# path with peco
function peco-path() {
  local filepath="$(find . | grep -v '/\.' | peco --prompt 'PATH>')"
  [ -z "$filepath" ] && return
  if [ -n "$LBUFFER" ]; then
    BUFFER="$LBUFFER$filepath"
  else
    if [ -d "$filepath" ]; then
      BUFFER="cd $filepath"
    elif [ -f "$filepath" ]; then
      BUFFER="$EDITOR $filepath"
    fi
  fi
  CURSOR=$#BUFFER
}
zle -N peco-path

# ag and vim
function agvim () {
  vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

# ag -h and vim
function aghvim () {
  vim $(agh $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

# git grep and vim
function ggrvim () {
  vim $(git grep -n $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

# php dev
function phpdev() {
  mysql.server start
  php-fpm -D
  nginx
}

# rake
_cachefile_updated_at() {
  echo $(stat -f%m .rake_tasks)
}

_rakefile_updated_at() {
  echo $(stat -f%m Rakefile)
}

_gemfile_updated_at() {
  echo $(stat -f%m Gemfile)
}

_generate_cachefile() {
  rake --silent --tasks 2> /dev/null | cut  -f 2 -d " " > .rake_tasks
}

_rake() {
  if [ -f Rakefile ]; then
    if [ ! -f .rake_tasks ] || \
       [ "`cat .rake_tasks | wc -l`" = "0" ] || \
       [ `_cachefile_updated_at` -lt `_rakefile_updated_at` ] || \
       [ -f Gemfile -a `_cachefile_updated_at` -lt `_gemfile_updated_at` ]; then
      _generate_cachefile
    fi
    compadd `cat .rake_tasks`
  fi
}

compdef _rake rake

# w3m config
# w3m google search
function ggrks() {
  local str opt
  if [ $ != 0 ]; then
    for i in $*; do
      str="$str+$i"
    done
    str=`echo $str | sed 's/^\+//'`
    opt='search?num=50&h1=ja&lr=lang_ja'
    opt="${opt}&q=${str}"
  fi
  w3m http://www.google.co.jp/$opt
}

# w3m でGoogle translate English->Japanese
function gte() {
  google_translate "$*" "en-ja"
}

# w3m でGoogle translate Japanese->English
function gtj() {
  google_translate "$*" "ja-en"
}

# 実行方法
# google_translate "検索文字列" [翻訳オプション(en-ja 英語->日本語)]
function google_translate() {
  local str opt cond

  if [ $# != 0 ]; then
    str=`echo $1 | sed -e 's/  */+/g'` # 1文字以上の半角空白を+に変換
    cond=$2
    if [ $cond = "ja-en" ]; then
      # ja -> en 翻訳
      opt='?hl=ja&sl=ja&tl=en&ie=UTF-8&oe=UTF-8'
    else
      # en -> ja 翻訳
      opt='?hl=ja&sl=en&tl=ja&ie=UTF-8&oe=UTF-8'
    fi
  else
    opt='?hl=ja&sl=en&tl=ja&ie=UTF-8&oe=UTF-8'
  fi

  opt="${opt}&text=${str}"
  w3m +13 "http://translate.google.com/${opt}"
}

# exec alias enhancd
function alias_enhancd() {
  alias cd='cd::cd'
}

# anyframe-widget-cdr without enhancd
function _anyframe-widget-cdr() {
  unalias cd
  add-zsh-hook chpwd alias_enhancd
  anyframe-widget-cdr
}
zle -N _anyframe-widget-cdr

# anyframe-widget-cd-ghq-repository without enhancd
function _anyframe-widget-cd-ghq-repository() {
  unalias cd
  add-zsh-hook chpwd alias_enhancd
  anyframe-widget-cd-ghq-repository
}

# lgtm
function lgtm() {
  $DOTFILES/src/lgtm.sh -m | pbcopy
}

#################################
# Configurations
#################################

# direnv config
# https://github.com/zimbatm/direnv
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook $SHELL)"
fi

# show_buffer_stack
bindkey '^]' show_buffer_stack

# peco-path
bindkey '^g' peco-path

# history
bindkey '^r' anyframe-widget-put-history

# cdr
add-zsh-hook chpwd chpwd_recent_dirs

#################################
# Export
#################################

# less
export LESS='-gj10 --no-init --quit-if-one-screen -R'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

#################################
# Prompt
#################################

source $DOTFILES/src/pygmalion.zsh-theme

#################################
# .zshrc.local
#################################

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
