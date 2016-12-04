#!/bin/bash

SRC=$HOME/.dotfiles/src
source $SRC/utils.sh

# Enable Ruby version 2.3.x
RUBIES=$(rbenv install --list | awk '
  match($0,/^\ \ 2\.(3\.[0-9])/) {
    print substr($0, RSTART+2,RLENGTH-2)
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
