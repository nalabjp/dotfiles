#!/bin/sh#
# Requires manual configuration you run the "brew bundle"
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
# colordiff
brew install colordiff
# cmake
brew install cmake
# coreutils
brew install coreutils
# ctags
brew install ctags
# direnv
brew install direnv
# findutils
brew install findutils
# fontforge
brew install fontforge
# ffmpeg
brew install ffmpeg
# ghq
brew tap motemen/ghq
brew install ghq
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
# mecab
brew install mecab
brew install mecab-ipadic
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
# peco
brew install peco
# phantomjs
brew install phantomjs
# php55
brew tap josegonzalez/homebrew-php
brew install --without-apache --with-fpm --with-mysql php55
# phpunit
brew install phpunit
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

# for brew versions
brew tap homebrew/boneyard

# Cleanup
brew cleanup
