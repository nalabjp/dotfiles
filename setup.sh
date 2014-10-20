#!/bin/bash

# dot files dir
DOTS_DIR=.dotfiles
# basic dot files
BASIC_DOTS=(.zshrc .oh-my-zsh .gemrc .pryrc .rspec .tmux.conf .tmuxinator .vimrc .gvimrc .vim/conf.d .gitconfig .gitignore .bundle .tigrc .colordiffrc .rbenv/default-gems)
# backup dir
BACKUP_DIR=$HOME/.dotfiles_backup/`date +%Y%m%d_%H%M%S`


# Create symbolic link if not exists
create_symlink() {
    local target=$1
    local origin=$2
    create_backup $target
    if [ ! -e $target ]; then
        echo "Create symbolic link: $target -> $origin"
        ln -s $origin $target
    fi
}

# Backup
create_backup() {
    local target=$1
    if [ -e $target ]; then
        echo "Already exists: $target"
        echo "Back up to $BACKUP_DIR"
        mkdir -p $BACKUP_DIR
        mv $target $BACKUP_DIR/${target##*/}
    fi
}

# Basic dot files only symbolic link
setup_basic_dots() {
    echo ""
    echo "Setup basic dot files"
    for file in ${BASIC_DOTS[@]}
    do
        echo "$file"
        create_symlink $HOME/$file $HOME/$DOTS_DIR/$file
    done
}

main() {
    setup_basic_dots
}

main
