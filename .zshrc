#################################
# Prepare
#################################

# dotifiles directory
DOTFILES=~/.dotfiles

# Remove duplicated path
typeset -U path PATH

# tmux attach
[ -f $DOTFILES/zsh/tmux_attach.zsh ] && source $DOTFILES/zsh/tmux_attach.zsh

# zcompile
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

# emacs mode
bindkey -e

#################################
# autoload
#################################
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
autoload -Uz zmv
autoload -U promptinit; promptinit
prompt pure

#################################
# zplug
#################################
source $(brew --prefix zplug)/init.zsh

zplug 'junegunn/fzf-bin', from:gh-r, as:command, rename-to:fzf
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'zsh-users/zsh-history-substring-search'
zplug 'mollifier/anyframe'
zplug 'b4b4r07/emoji-cli', if:'which jq'
zplug 'b4b4r07/enhancd', use:init.sh
zplug 'nalabjp/zsh-bundle-exec'
zplug 'nalabjp/esa-cli', as:command, use:esa, rename-to:esa, hook-build:'bundle install'
zplug 'zsh-users/zsh-autosuggestions'

# load
zplug load
# for zplug load v2.4.0
# now fixed v2.1.0
# @see https://github.com/zplug/zplug/issues/322
# setopt monitor

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
# Configurations
#################################

# load functions
[ -f $DOTFILES/zsh/functions.zsh ] && source $DOTFILES/zsh/functions.zsh

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

# autosuggest
bindkey '^ ' autosuggest-clear

#################################
# travis.sh
#################################

[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

#################################
# .zshrc.local
#################################

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
