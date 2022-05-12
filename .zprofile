# arm64?
if [ $(uname -m) = 'arm64' ]; then
  export HOMEBREW_HOME=/opt/homebrew
else
  export HOMEBREW_HOME=/usr/local
fi

# Remove duplicated path
typeset -U path PATH

# sbin
path=(/sbin(N-/) /usr/sbin(N-/) $path)

# Add brew path
path=($HOMEBREW_HOME/bin(N-/) $HOMEBREW_HOME/sbin(N-/) $path)

# Add dotfiles/bin
path=(~/dotfiles/bin(N-/) $path)

# zfunctions
fpath=(~/dotfiles/zfunctions(N-/) $fpath)

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
# for update
#[ -s "$HOMEBREW_HOME/opt/nvm/nvm.sh" ] && . "$HOMEBREW_HOME/opt/nvm/nvm.sh"

# java
# export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
# path+=($JAVA_HOME(N-/))
# OpenJDK
path=($HOMEBREW_HOME/opt/openjdk/bin(N-/) $path)
export CPPFLAGS="-I$HOMEBREW_HOME/opt/openjdk/include"


# postgresql
export PGDATA=/usr/local/var/postgres

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
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

# wordchar
export WORDCHARS=''

# homebrew analytics
export HOMEBREW_NO_ANALYTICS=1

# emoji-cli
export EMOJI_CLI_KEYBIND='^Y'

# gdircolors
eval $(gdircolors ~/dotfiles/themes/dircolors-solarized/dircolors.256dark)

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
export ZPLUG_HOME=~/.zplug
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

# diff-highlight
if [[ ! -e $HOMEBREW_HOME/bin/diff-highlight ]]; then
  ln -s $HOMEBREW_HOME/opt/git/share/git-core/contrib/diff-highlight/diff-highlight $HOMEBREW_HOME/bin
fi

# For configuration files where environment variables are not available
if [[ ! -e /usr/local/opt ]]; then
  echo Run \'sudo ln -s $HOMEBREW_HOME/opt /usr/local/opt\'
fi
if [[ ! -e /usr/local/var ]]; then
  echo Run \'sudo ln -s $HOMEBREW_HOME/var /usr/local/var\'
fi
