#!/bin/bash

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
