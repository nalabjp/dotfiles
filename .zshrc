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
# autoload
#################################
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
autoload -Uz zmv
autoload -Uz colors
colors
autoload -Uz compinit
compinit

#################################
# zplug
#################################
source $(brew --prefix zplug)/init.zsh

zplug "$DOTFILES/zsh", from:local
zplug 'junegunn/fzf-bin', from:gh-r, as:command, rename-to:fzf
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'zsh-users/zsh-history-substring-search'
zplug 'mollifier/anyframe'
zplug 'b4b4r07/enhancd', use:enhancd.sh
zplug 'stedolan/jq', from:gh-r, as:command, rename-to:jq, if:'! which jq'
zplug 'b4b4r07/emoji-cli', if:'which jq'
zplug 'nalabjp/zsh-bundle-exec'

# install any uninstalled plugins
zplug check || zplug install

# load
zplug load

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
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:*:*:*:*' menu select

# cache git status
precmd () {
  [ -d .git ] && git status &>/dev/null
}

#################################
# Prompt
#################################

PROMPT=$'%F{yellow}%D{[%H:%M:%S]} %~\
%F{blue} %f'

#################################
# travis.sh
#################################

[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

#################################
# .zshrc.local
#################################

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
