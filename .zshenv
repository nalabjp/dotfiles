#################################
# aliases
#################################

# load functions
source ~/.dotfiles/zsh/alias_functions.zsh

# Global aliases
alias -g F='| fzf'
alias -g G='| grep'
alias -g GI='| grep -i'
alias -g GV='| grep -v'
alias -g H='| head'
alias -g L='| less'
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

alias _='sudo'

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

# anyframe
alias af='anyframe-widget-select-widget'

# bootstrap
alias bst='~/.dotfiles/bootstrap'
alias bstb='bst brew'
alias bstd='bst dotfiles'
alias bstr='bst rbenv'
alias bstu='bst update'

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

# esa
alias ev='esa view --per-page 50 --auto-reload 15'
alias evq='esa view --per-page 50 -q '

# git
alias g='hub'
alias ga='g add -v'
alias gaa='g add -Av'
alias gb='g branch'
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
alias gf='g fetch'
alias gfa='g fetch --all'
alias ggr='g grep -i -n -H --heading --break'
alias gl='g log --stat'
alias glg='g log --graph --decorate --oneline'
alias gla='g log --graph --decorate --all'
alias glo='g log --oneline'
alias glsf='g ls-files'
alias gmg='g merge'
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
alias gwa=_gwa
alias gwac=_gwac
alias gwl='g worktree list'
alias gwp='g worktree prune'

# grep
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'

# history
alias history='fc -l 1'

# karabiner
if which karabiner > /dev/null 2>&1; then
  alias karabiner-export='karabiner export > $DOTFILES/karabiner/import.sh'
fi

# ls
# require coreutils
alias ls='gls --color=auto'
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

# mkdir
alias md='mkdir -p'

# mysql
alias mysql="mysql --pager='less -S -i -F'"
alias mysql-start='mysql.server start'
alias mysql-stop='mysql.server stop'
alias mysql-restart='mysql.server restart'

# Aliases to stop, start and restart Postgres
# Paths noted below are for Postgress installed via Homebrew on OSX
alias pg-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg-stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias pg-restart='pg-stop && sleep 1 && pg-start'

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# reload .zshrc .zshenv .zprofile
alias rz='source ~/.zshrc'
alias rze='source ~/.zshenv'
alias rzp='source ~/.zprofile'

# rmdir
alias rd=rmdir

# redis
alias redis-start='redis-server'

# restore zcompdump
alias restore-zcompdump='rm ~/.zcompdump && exec zsh'

# gnu-sed
alias sed='gsed'

# ctags
alias taggen="sh -c 'ctags  --tag-relative -f .git/tags -R . 2>/dev/null' &; sh -c 'ctags --tag-relative -f .git/Gemfile.lock.tags -R \$(bundle show --paths) 2>/dev/null' &"

# less +F
alias tailf='LESSOPEN= less +F'

# tmux
alias tsk='tmux send-keys'

# vim
alias v='vim'

# edit .dotfiles
alias vg='v ~/.gitconfig'
alias vv='v ~/.vimrc'
alias vz='v ~/.zshrc'
alias vze='v ~/.zshenv'
alias vzp='v ~/.zprofile'

# zmv
alias zmv_='noglob zmv'
alias zmv='zmv_ -W'
alias zcp='zmv_ -C'
alias zln='zmv_ -L'

