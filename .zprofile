# Remove duplicated path
typeset -U path PATH

# sbin
path=(/sbin(N-/) /usr/sbin(N-/) $path)

# Add brew path
path=(/usr/local/bin(N-/) /usr/local/sbin(N-/) $path)

# Add .dotfiles/bin
path=(~/.dotfiles/bin(N-/) $path)

# EDITOR
export EDITOR='vim'

# TERM
export TERM=xterm-256color

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
    path=(~/.rbenv/shims(N-/) $path)
  }
  rbenv_init
  unfunction rbenv_init
fi

# nodebrew
path+=(~/.nodebrew/current/bin(N-/))

# java
export JAVA_HOME="$(/usr/libexec/java_home)"
path+=($JAVA_HOME(N-/))

# postgresql
export PGDATA=/usr/local/var/postgres

# zsh-bundle-exec.zsh
export BUNDLE_EXEC_GEMFILE_CURRENT_DIR_ONLY=yes
export BUNDLE_EXEC_COMMANDS='rails rake rspec spring'

# enhancd
export ENHANCD_COMMAND='c'

# fzf
export FZF_DEFAULT_COMMAND='ag'
export FZF_DEFAULT_OPTS='--extended --cycle --select-1 --exit-0 --multi'

# karabiner
if [ -f /Applications/Karabiner.app/Contents/Library/bin/karabiner ]; then
  path+=(/Applications/Karabiner.app/Contents/Library/bin(N-/))
fi

# only define LC_CTYPE if undefined
if [[ -z "$LC_CTYPE" && -z "$LC_ALL" ]]; then
  export LC_CTYPE=${LANG%%:*} # pick the first entry from LANG
fi

# pager
export PAGER="less"
export LESS='-gj10 -X -F -R'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

# wordchar
export WORDCHARS=''

# homebrew analytics
export HOMEBREW_NO_ANALYTICS=1

# emoji-cli
export EMOJI_CLI_KEYBIND='^Y'

# zplug
export ZPLUG_CLONE_DEPTH=1
