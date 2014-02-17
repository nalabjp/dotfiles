#!/bin/bash

# ruby install
rbenv install 1.9.3-p484
rbenv install 2.0.0-p353
rbenv install 2.1.0
rbenv global 2.1.0

# gem install to global
gem install bundler pry pry-byebug pry-doc pry-stack_explorer awesome_print tapp

# gem install to system for weechat/ruby/notification_center.rb
rbenv shell system
gem install ruby_gntp weechat terminal-notifier tmuxinator
rbenv shell --unset
