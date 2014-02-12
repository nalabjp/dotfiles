#!/bin/bash

cd ~/.dotfiles
echo "cd $PWD"

echo ''
echo 'start ./before_brew_bundle.sh'
./before_brew_bundle.sh
echo 'finish ./before_brew_bundle.sh'

echo ''
echo 'start brew bundle'
brew bundle
echo 'finish brew bundle'

echo ''
echo 'start after_brew_bundle.sh'
./after_brew_bundle.sh
echo 'finish after_brew_bundle.sh'

echo ''
echo 'start rbenv_setup.sh'
./rbenv_setup.sh
echo 'finish rbenv_setup.sh'

echo ''
echo 'start setup.sh'
./setup.sh
echo 'finish setup.sh'
