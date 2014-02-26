#!/bin/bash

RUBIES=(1.9.3-p484 2.0.0-p353 2.1.0 2.1.1)
GEMLIST_TO_SYSTEM=(ruby_gntp weechat terminal-notifier tmuxinator)
GEMLIST_TO_VERSION=(bundler pry pry-byebug pry-doc pry-rescue pry-stack_explorer awesome_print tapp)

install_gem_if_not_installed() {
    local gem=$1
    echo [$gem]
    if [ `gem list $gem -i` = 'false' ]; then
        echo '  now installing...'
        gem install $gem
        rbenv rehash
    else
        echo '  already installed'
    fi

}

install_gem_list_if_not_installed() {
    local gems_list=$@
    for gem in ${gems_list[@]}
    do
        install_gem_if_not_installed $gem
    done
}

# gem install to system
echo ''
echo '## ruby system ##'
rbenv global system
install_gem_list_if_not_installed ${GEMLIST_TO_SYSTEM[*]}

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
