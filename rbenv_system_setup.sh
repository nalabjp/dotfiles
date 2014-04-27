#!/bin/bash

# require system gem command path
GEM_CMD='sudo /usr/bin/gem'

source ./rbenv_functions.sh

GEMLIST_TO_SYSTEM=(ruby_gntp weechat terminal-notifier tmuxinator)

# gem install to system
echo ''
echo '## ruby system ##'
install_gem_list_if_not_installed ${GEMLIST_TO_SYSTEM[*]}

unset GEM_CMD
