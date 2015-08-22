# Dotifiles directory
DOTFILES=$HOME/.dotfiles

# Load antigen
source $DOTFILES/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle tmux
antigen bundle z

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell antigen that you're done.
antigen apply

# Load my custom configurations
for config_file ($DOTFILES/zsh/*.zsh); do
  source $config_file
done

# Load theme
source $DOTFILES/themes/zdj-custom.zsh-theme
