if [ -f ~/.dotfiles/.bashrc ] ; then
  . ~/.dotfiles/.bashrc
fi
if [ -f ~/.dotfiles/.bashrc.local ] ; then
  . ~/.dotfiles/.bashrc.local
fi

if [ -f $(brew --prefix)/etc/bash_completion ] ; then
  . $(brew --prefix)/etc/bash_completion
fi
