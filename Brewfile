#
# Requires manual configuration you run the "brew bundle"
#
# before run the "brew bundle":
#   mutt 1.5.20 (2009-06-14)
#     $ cd /usr/local
#     $ git checkout 0476235 Library/Formula/mutt.rb
#     $ mkdir -p ~/.mutt/cache/headers && mkdir ~/.mutt/cache/bodies && touch ~/.mutt/certificates && touch ~/.mutt/signature
#
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
install the_silver_searcher
# apple-gcc42
tap homebrew/dupes
install apple-gcc42
# colordiff
install colordiff
# direnv
install direnv
# findutils
install findutils
# fontforge
install fontforge
# git
install git
install hub
install tig
tap thoughtbot/formulae
install gitsh
# gnu-tar
install --default-names gnu-tar
# htop
install htop-osx
# imagemagick
install imagemagick
# libxml2
install libxml2
# libxslt
install libxslt
# macvim
install --with-lua --override-system-vim macvim
# mongodb
install mongodb
# mutt
# version 1.5.20
# '|| true' ignore already installed error
install gnupg
install msmtp
install urlview
install --sidebar-patch mutt || true
pin mutt
# mysql
install mysql
# nginx
install nginx
# nkf
install nkf
# phantomjs
install phantomjs
# postgresql
install postgresql
# pstree
install pstree
# pwgen
install pwgen
# redis
install redis
# ruby
install openssl
install readline
install rbenv
install ruby-build
install rsense
# source-highlight
install source-highlight
# sqlite
install sqlite
# tmux
install reattach-to-user-namespace
install tmux
# tree
install tree
# watch
install watch
# weechat
install --with-aspell --with-guile --with-lua --with-perl --with-python --with-ruby weechat
# wget
install wget
# w3m
install w3m
# zsh
install --disable-etcdir zsh

# brew-cask
tap phinze/homebrew-cask
install brew-cask
cask install alfred
cask install clamxav
cask install copy
cask install dash
cask install dropbox
cask install evernote
cask install firefox
cask install gimp
cask install github
cask install google-chrome
cask install iterm2
cask install limechat
cask install mysql-workbench
cask install skitch
cask install skype
cask install sourcetree
cask install teamviewer
cask install tinkertool
cask install tinyumbrella
cask install virtualbox

# Cleanup
cleanup
