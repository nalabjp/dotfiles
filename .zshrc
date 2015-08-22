#################################
# Prepare
#################################

# zcompile
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
   zcompile ~/.zshrc
fi

# dotifiles directory
DOTFILES=$HOME/.dotfiles

# completion
autoload -Uz compinit
compinit

#################################
# antigen
#################################

# Load antigen
source $DOTFILES/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle tmux
antigen bundle z

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell antigen that you're done.
antigen apply

#################################
# aliases
#################################

# ag
alias ag='ag -S'
alias agh='ag --hidden'

# bundler
alias b="bundle"
alias bi="bundle install"
alias be="bundle exec"
alias bl="bundle list"
alias bp="bundle package"
alias bo="bundle open"
alias bu="bundle update"
alias bs="bundle show"

# colordiff
# color config ~/.colordiffrc
# require: export LESS="-R"
alias diff='colordiff -u'

# gitsh
alias gs='gitsh'

# ls
# require coreutils
alias ls='gls --color=auto'
eval $(gdircolors $DOTFILES/themes/dircolors-solarized/dircolors.256dark)

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
alias redis-start='redis-server /etc/redis.conf'

# tmux
alias tsk='tmux send-keys'

# zmv
autoload -Uz zmv
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
bindkey '^]' show_buffer_stack

# history with peco
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

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
bindkey '^g' peco-path

# ag and vim
function agvim () {
  vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}
zle -N agvim

# ag -h and vim
function aghvim () {
  vim $(agh $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}
zle -N aghvim

# git grep and vim
function ggrvim () {
  vim $(git grep -n $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}
zle -N ggrvim


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

# cd && ls
# function cd() {builtin cd $@ && ls -a} 
function cd() {
    if [ $# = 0 ]; then
        builtin cd
    elif [ -f $1 ]; then
        builtin cd $1:h
    else
        builtin cd $*
    fi
    ls -a
}

# ssh with tmux
function ssh() {
  if type tmux > /dev/null 2>&1; then
    tmux new-window "ssh $1"
  else
    builtin ssh $1
  fi
}

#################################
# Configurations
#################################

## カレントディレクトリ中に指定されたディレクトリが見つからなかった場合に移動先を検索するリスト。
cdpath=(~)
## ディレクトリが変わったらディレクトリスタックを表示。
chpwd_functions=($chpwd_functions dirs)

# direnv config
# https://github.com/zimbatm/direnv
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook $SHELL)"
fi


#################################
# Exports
#################################

# history config
export HISTCONTROL=ignoreboth #ignorespace+ignoredups
export HISTIGNORE="fg*:bg*:history*:cd*:ls*"
export HISTTIMEFORMAT='%Y-%m-%d %T ';

# less
export LESS='-gj10 --no-init --quit-if-one-screen -R'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

# Homebrew Cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"

# EDITOR
export EDITOR='vim'

# TERM
export TERM=screen-256color

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# java
export JAVA_HOME="$(/usr/libexec/java_home)"
export PATH=$JAVA_HOME:$PATH

# php-fpm
export PATH="$(brew --prefix)/sbin:$PATH"

# postgresql
export PGDATA=/usr/local/var/postgres

# rbenv
export RBENV_ROOT=$(rbenv root)
export PATH=$RBENV_ROOT/bin:$PATH
eval "$(rbenv init --no-rehash - zsh)"

#################################
# Prompt
#################################

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local date='%{$fg[white]%}❮%{$reset_color%}%{$fg[red]%}%D %*%{$reset_color%}%{$fg[white]%}❯%{$reset_color%}'
local user_host='%{$fg[white]%}❮%{$reset_color%}%{$fg[blue]%}%n%{$fg[white]%}＠%{$reset_color%}%{$fg[blue]%}%M%{$reset_color%}%{$fg[white]%}❯%{$reset_color%}'
local current_dir='%{$fg[white]%}❮%{$reset_color%}%{$fg[yellow]%}%~%{$reset_color%}%{$fg[white]%}❯%{$reset_color%}'
local git_branch='$(git_prompt_info)%{$reset_color%}'

PROMPT="%{$fg[yellow]%}┌──%{$reset_color%} ${date} ${user_host} ${current_dir} ${git_branch}
%{$fg[yellow]%}└──%{$reset_color%} $ "
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$terminfo[bold]$fg[magenta]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

