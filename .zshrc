source ~/.dotfiles/.commonshrc

if [ -f ~/.dotfiles/.zshrc.local ] ; then
    . ~/.dotfiles/.zshrc.local
fi

# z.sh
if [ -f $(brew --prefix)/etc/profile.d/z.sh ]; then
  _Z_CMD=j
  source $(brew --prefix)/etc/profile.d/z.sh
  function precmd () {
    _z --add "$(pwd -P)"
  }
fi

# command line stack
show_buffer_stack() {
  POSTDISPLAY="
stack: $LBUFFER"
  zle push-line-or-edit
}
zle -N show_buffer_stack
bindkey '^]' show_buffer_stack
