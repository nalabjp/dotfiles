#!/bin/bash

# brew exist?
if [ -x "`which brew`" ]; then
    echo 'brew already exists!'
    echo 'exiting...'
    exit
fi

# install Homebrew
echo 'brew install...'
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"

# prepare for mutt for version 1.5.20 (2009-06-14)
echo 'prepare for mutt...'
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
