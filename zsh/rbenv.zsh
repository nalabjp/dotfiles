export RBENV_ROOT=$(rbenv root)
export PATH=$RBENV_ROOT/bin:$PATH
eval "$(rbenv init --no-rehash - zsh)"
