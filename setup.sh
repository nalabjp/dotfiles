#!/bin/bash

# dot files dir
DOTS_DIR=.dotfiles
# basic dot files
BASIC_DOTS=( .gemrc .pryrc .tmux.conf .screenrc .vimrc .gvimrc .vim/conf.d .vim/snippets .gitconfig .gitignore .muttrc .bundle .tigrc .zshrc .oh-my-zsh )
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

# weechat
setup_weechat() {
    echo ""
    echo "Setup weechat"
    local weechat_dir=.weechat
    local backup_dir=$BACKUP_DIR
    if [ -a $HOME/$weechat_dir ]; then
        local weechat_confs=`find $HOME/$DOTS_DIR/$weechat_dir -name *.conf`
        local file
        BACKUP_DIR=$BACKUP_DIR/$weechat_dir
        for file in ${weechat_confs[@]}
        do
            local weechat_conf=$weechat_dir/${file##*/}
            create_symlink $HOME/$weechat_conf $HOME/$DOTS_DIR/$weechat_conf
        done

        local plugin_dirs=`find $HOME/$DOTS_DIR/$weechat_dir/* -type d`
        local plugin_dir
        BACKUP_DIR=$BACKUP_DIR/${plugin_dir##*/}/autoload
        for plugin_dir in ${plugin_dirs[@]}
        do
            local plugins=`find $plugin_dir/* -type f`
            local plugin
            for plugin in ${plugins[@]}
            do
                create_symlink $HOME/$weechat_dir/${plugin_dir##*/}/autoload/${plugin##*/} $plugin
            done
        done
    else
        echo "Not yet install weecaht..."
    fi
    BACKUP_DIR=$backup_dir
}

main() {
    setup_basic_dots
    setup_weechat
}

main
