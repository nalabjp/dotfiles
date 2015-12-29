# sbin
export PATH=/sbin:/usr/sbin:$PATH

# Add brew path
export PATH=/usr/local/bin:$PATH

# Add .dotfiles/bin
export PATH=~/.dotfiles/bin:$PATH

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
    path=(~/.rbenv/shims $path)
  }
  rbenv_init
  unfunction rbenv_init
fi

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

# less
export LESS='-gj10 --no-init --quit-if-one-screen -R'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

# enhancd
export ENHANCD_COMMAND='c'

# fzf
export FZF_DEFAULT_COMMAND='ag'
export FZF_DEFAULT_OPTS='--select-1 --exit-0 --multi'

# karabiner
if [ -f /Applications/Karabiner.app/Contents/Library/bin/karabiner ]; then
  export PATH=/Applications/Karabiner.app/Contents/Library/bin:$PATH
fi

