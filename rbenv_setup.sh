#!/bin/bash

# symlink rbenv-default-gems
echo ""
echo "Setup rbenv-default-gems"

file=default-gems
echo "$file"
ln -s $(brew --prefix rbenv)/$file $HOME/$DOTS_DIR/.rbenv/$file

# Only Ruby version 2.2.x
RUBIES=$(rbenv install --list | awk '
  match($0,/^\ \ 2\.(1\.[4-9]|2\.[0-9])/) {
    print substr($0, RSTART+2,RLENGTH-2)
  }
'| sort | uniq)

# ruby install & gem install to global
for version in $RUBIES
do
    echo ''
    echo '## ruby '$version' ##'
    if [ ! -d $(brew --prefix rbenv)/versions/$version ]; then
        rbenv install $version
        echo 'installed!'
    fi
done
