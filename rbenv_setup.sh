#!/bin/bash

RUBIES=(1.9.3-p484 2.0.0-p353 2.1.0)
GEMLIST_TO_VERSION='bundler pry pry-byebug pry-doc pry-stack_explorer awesome_print tapp'
GEMLIST_TO_SYSTEM='ruby_gntp weechat terminal-notifier tmuxinator'

# ruby install & gem install to global
for version in ${RUBIES[@]}
do
    if [ ! -d $(brew --prefix rbenv)/versions/$version ]; then
        rbenv install $version
        rbenv global $version
        rbenv rehash
    fi
    gem install $GEMLIST_TO_VERSION
done

# gem install to system
rbenv shell system
gem install $GEMLIST_TO_SYSTEM
rbenv shell --unset
