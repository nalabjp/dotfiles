#!/bin/bash

local script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

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
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"

# prepare for mutt for version 1.5.20 (2009-06-14)
# see brew versions mutt
echo 'prepare for mutt'
git checkout 0476235 /usr/local/Library/Formula/mutt.rb
mkdir -p ~/.mutt/cache/headers && mkdir -p ~/.mutt/cache/bodies
if [ ! -e ~/.mutt/certificates ]; then
    touch ~/.mutt/certificates
fi
if [ ! -e ~/.mutt/signature ]; then
    touch ~/.mutt/signature
fi

# prepare for homebrew-cask
echo 'prepare for homebrew-cask'
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"
echo 'finish before brew bundle'

#
# brew bundle
#
echo ''
echo 'start brew bundle'
brew bundle
echo 'finish brew bundle'

#
# after brew bundle
#
echo ''
echo 'start after brew bundle'
pwd=$PWD
# create symlink for gnu-tar
if [ -f /usr/local/bin/gtar ]; then
    echo 'create symlink for gnu-tar'
    cd /usr/bin
    sudo rm tar
    sudo ln -s /user/local/bin/gtar tar
    cd $pwd
fi

# change login shell to zsh
if [ -f /usr/local/bin/zsh ]; then
    echo 'change login shell to /usr/local/bin/zsh'
    sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
    chsh -s /usr/local/bin/zsh
fi
echo 'finish after brew bundle'

#
# rbenv_setup.sh
#
echo ''
echo 'start rbenv_setup.sh'
./rbenv_setup.sh
echo 'finish rbenv_setup.sh'

#
# setup.sh
#
echo ''
echo 'start setup.sh'
./setup.sh
echo 'finish setup.sh'
