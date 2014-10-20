#!/bin/sh#
# Requires manual configuration you run the "brew bundle"
#
# before run the "brew bundle":
#   cask env
#     $ export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"
#
# after run the "brew bundle":
#   gnu-tar
#     $ cd /usr/bin
#     $ sudo rm tar
#     $ sudo ln -s /usr/local/bin/gtar tar
#
#   zsh
#     $ sudo vi /etc/shells
#     /usr/local/bin/zsh # add last line
#     $ chsh -s /usr/local/bin/zsh
#

# Update Homebrew
#update

# Upgrade Formula
#upgrade

# ag
brew install the_silver_searcher
# apple-gcc42
brew tap homebrew/dupes
brew install apple-gcc42
# colordiff
brew install colordiff
# coreutils
brew install coreutils
# direnv
brew install direnv
# findutils
brew install findutils
# fontforge
brew install fontforge
# ffmpeg
brew install ffmpeg
# git
brew install git
brew install hub
brew install tig
brew tap thoughtbot/formulae
brew install gitsh
# gnu-tar
brew install --default-names gnu-tar
# heroku
brew install heroku
# htop
brew install htop-osx
# httpie
brew install httpie
# imagemagick
brew install imagemagick
# jq
brew install jq
# libxml2 => 2.8.0 for nokogiri
brew install libxml2
brew pin libxml2
# libxslt
brew install libxslt
# macvim
brew install --with-lua --override-system-vim macvim
# mongodb
brew install mongodb
# mysql
brew install mysql
# nginx
brew install nginx
# nkf
brew install nkf
# nodebrew
brew install nodebrew
# pandoc
brew install pandoc
# phantomjs
brew install phantomjs
# postgresql
brew install postgresql
# pstree
brew install pstree
# pwgen
brew install pwgen
# redis
brew install redis
# rename
brew install rename
# ruby
brew install openssl
brew install readline
brew install rbenv
brew install ruby-build
brew install rsense
# rbenv-default-gems
brew install rbenv-default-gems
# source-highlight
brew install source-highlight
# sqlite
brew install sqlite
# tmux
brew install reattach-to-user-namespace
brew install tmux
# tree
brew install tree
# watch
brew install watch
# wget
brew install wget
# w3m
brew install w3m
# zsh
brew install --disable-etcdir zsh

# brew-cask
brew tap phinze/homebrew-cask
brew install brew-cask
brew cask install alfred
brew cask install clamxav
brew cask install copy
brew cask install dash
brew cask install dropbox
brew cask install evernote
brew cask install firefox
brew cask install gimp
brew cask install github
brew cask install google-chrome
brew cask install google-drive
brew cask install iterm2
brew cask install kobito
brew cask install limechat
brew cask install mysql-workbench
brew cask install slack
brew cask install skitch
brew cask install skype
brew cask install sourcetree
brew cask install teamviewer
brew cask install tinkertool
brew cask install tinyumbrella
brew cask install vagrant
brew cask install virtualbox

# Cleanup
brew cleanup
