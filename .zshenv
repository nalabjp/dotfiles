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
export BUNDLE_EXEC_COMMANDS='rails rspec spring'

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

# gdircolors
eval $(gdircolors $DOTFILES/themes/dircolors-solarized/dircolors.256dark)
