#!/bin/bash

source $HOME/dotfiles/bootstrap.d/utils.sh

# Enable Ruby version 2.3.x
RUBIES=$(rbenv install --list | awk '
  match($0,/^2\.([6-7]\.[0-9])/) {
    print $0
  }
'| sort | uniq)

# ruby install & gem install to global
for version in $RUBIES
do
    log_echo '## ruby '$version' ##'
    if [ ! -d $RBENV_ROOT/versions/$version ]; then
        rbenv install -s $version
        log_info 'installed!'
    else
        log_info 'Already exists'
    fi
done
