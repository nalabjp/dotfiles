#!/bin/bash

script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

cd $script_dir
echo "cd $PWD"

#
# before brew bundle
#
echo ''
echo 'start before brew bundle'
# brew exist?
if [ -x "`which brew`" ]; then
    echo 'brew already exists!'
    echo 'exiting...'
    exit
fi

# install Homebrew
echo 'brew install'
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#
# run brew bundle
#
echo ''
echo 'start brew brewfile'
brew bundle
echo 'finish brew brewfile'

#
# after brew bundle
#
echo ''
echo 'start after brew bundle'
pwd=$PWD
# change login shell to zsh
if [ -f /usr/local/bin/zsh ]; then
    echo 'change login shell to /usr/local/bin/zsh'
    sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
    chsh -s /usr/local/bin/zsh
fi

# create symlink for diff-highlight
if [ -f /usr/local/share/git-core/contrib/diff-highlight/diff-highlight ]; then
    echo 'create symlink for diff-highlight'
    ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin
fi
echo 'finish after brew bundle'

#
# setup.sh
#
echo ''
echo 'start setup.sh'
./setup.sh
echo 'finish setup.sh'
