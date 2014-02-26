#!/bin/bash

source ./rbenv_functions.sh

RUBIES=(1.9.3-p484 2.0.0-p353 2.1.0 2.1.1)
GEMLIST_TO_VERSION=(bundler pry pry-byebug pry-doc pry-rescue pry-stack_explorer awesome_print tapp rubocop)

# gem install to system
#echo ''
#echo '## ruby system ##'
#rbenv global system
#install_gem_list_if_not_installed ${GEMLIST_TO_SYSTEM[*]}

# ruby install & gem install to global
for version in ${RUBIES[@]}
do
    echo ''
    echo '## ruby '$version' ##'
    if [ ! -d $(brew --prefix rbenv)/versions/$version ]; then
        rbenv install $version
    fi
    rbenv global $version
    rbenv rehash
    install_gem_list_if_not_installed ${GEMLIST_TO_VERSION[*]}
done
