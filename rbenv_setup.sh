#!/bin/bash

# Enable Ruby version 2.2.x ~ 2.3.x
RUBIES=$(rbenv install --list | awk '
  match($0,/^\ \ 2\.(2\.[0-9]|3\.[0-9])/) {
    print substr($0, RSTART+2,RLENGTH-2)
  }
'| sort | uniq)

# ruby install & gem install to global
for version in $RUBIES
do
    echo ''
    echo '## ruby '$version' ##'
    if [ ! -d $RBENV_ROOT/versions/$version ]; then
        rbenv install $version
        echo 'installed!'
    fi
done
