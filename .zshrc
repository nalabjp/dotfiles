#################################
# Prepare
#################################

# dotifiles directory
DOTFILES=~/.dotfiles

# Remove duplicated path
typeset -U path PATH

# zcompile
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

# emacs mode
bindkey -e

#################################
# zplug
#################################

# Clone zplug if not found
source ~/.zplug/zplug || { curl -fLo ~/.zplug/zplug --create-dirs git.io/zplug && source ~/.zplug/zplug }

zplug "$DOTFILES/zsh", from:local
zplug 'junegunn/fzf-bin', from:gh-r, as:command, file:fzf
zplug "zsh-users/zsh-completions"
zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'zsh-users/zsh-history-substring-search'
zplug 'mollifier/anyframe'
zplug 'b4b4r07/enhancd', of:enhancd.sh
zplug 'stedolan/jq', from:gh-r, as:command, file:jq, if:'! which jq'
zplug 'b4b4r07/emoji-cli', if:'which jq'
zplug "nalabjp/zsh-bundle-exec"

# install any uninstalled plugins
zplug check || zplug install

# load
zplug load

#################################
# autoload
#################################
# add-zsh-hook
autoload -Uz add-zsh-hook

# cdr
autoload -Uz chpwd_recent_dirs cdr

# zmv
autoload -Uz zmv

# color
autoload -Uz colors
colors

# compinit
autoload -Uz compinit
compinit

#################################
# options
#################################

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

#################################
# aliases
#################################

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

# ctags
alias ctags-rails='ctags --exclude="*.js" --exclude=".git*" -R .'

# colordiff
# color config ~/.colordiffrc
# require: export LESS='-R'
alias diff='colordiff -u'

# edit .zshrc
alias ez='v ~/.zshrc'

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
alias ggr='g grep -in'
alias gl='g log --stat'
alias glg='g log --graph --decorate --all'
alias glo='g log --oneline'
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
alias gs='g status'
alias gsh='g show'
alias gst='g stash'
alias gstc='g stash clear'
alias gstl='g stash list'
alias gstp='g stash pop'
alias gwa='g worktree add'
alias gwl='g worktree list'
alias gwp='g worktree prune'

# grep
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'

# history
alias history='fc -l 1'

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

# reload .zshrc .zprofile
alias rz='source ~/.zshrc'
alias rp='source ~/.zprofile'

# rmdir
alias rd=rmdir

# redis
alias redis-start='redis-server'

# restore zcompdump
alias restore-zcompdump='rm ~/.zcompdump && exec zsh'

# gnu-sed
alias sed='gsed'

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
# Configurations
#################################

# karabiner
if which karabiner > /dev/null 2>&1; then
  alias karabiner-export='karabiner export > $DOTFILES/karabiner/import.sh'
fi

# gdircolors
eval $(gdircolors $DOTFILES/themes/dircolors-solarized/dircolors.256dark)

# direnv config
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook $SHELL)"
  export DIRENV_LOG_FORMAT=
fi

# show_buffer_stack
bindkey '^]' show_buffer_stack

# fzf-path
bindkey '^V' fzf-path

# history
bindkey '^R' anyframe-widget-put-history

# cdr
add-zsh-hook chpwd chpwd_recent_dirs

# history-substring-search-up
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# anyframe
bindkey '^V^V' 'anyframe-widget-cd-ghq-repository'
bindkey '^V^B' 'anyframe-widget-checkout-git-branch'
bindkey '^V^K' 'anyframe-widget-kill'

# completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ''
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:*:*:*:*' menu select

#################################
# Prompt
#################################

PROMPT=$'%{$fg[yellow]%}%D{[%H:%M:%S]} %~%{$reset_color%} $(git_prompt_info)\
%{$fg_bold[cyan]%} %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#################################
# .zshrc.local
#################################

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
