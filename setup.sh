#!/bin/bash

# dot files dir
DOTS_DIR=.dotfiles
# basic dot files
BASIC_DOTS=( .gemrc .pryrc .tmux.conf .screenrc .vimrc .gvimrc .gitignore .muttrc )
# use zsh
USE_ZSH=1
# use oh-my-zsh
USE_OHMYZSH=1
# backup dir
BACKUP_DIR=$HOME/.dotfiles_backup/`date +%Y%m%d_%H%M%S`


# Create symbolic link if not exists
create_symlink() {
    local target=$1
    local origin=$2
    create_backup $target
    if [ ! -a $target ]; then
        echo "Create symbolic link: $target -> $origin"
        ln -s $origin $target
    fi
}

# Backup
create_backup() {
    local target=$1
    if [ -a $target ]; then
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


# login shell
setup_sh() {
    if [ $USE_ZSH -eq 1 ]; then
        setup_zsh
    else
        setup_bash
    fi
}

# zsh
setup_zsh() {
    echo ""
    echo "Setup zsh"
    local file=.zshrc
    local ohmyzsh_dir=.oh-my-zsh
    local origin=$HOME/$DOTS_DIR/$file
    if [ -a $HOME/$ohmyzsh_dir ]; then
        echo "Exists $HOME/$ohmyzsh_dir"
        local target=$HOME/$ohmyzsh_dir/custom/${file#\.}.zsh
    else
        echo "Not Exists $HOME/$ohmyzsh_dir"
        if [ $USE_OHMYZSH -eq 1 ]; then
            echo "Install oh-my-zsh"
            git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/$ohmyzsh_dir
            mv $HOME/$file $BACKUP_DIR/$file
            cp $HOME/$ohmyzsh_dir/templates/zshrc.zsh-template $HOME/$file
            local target=$HOME/$ohmyzsh_dir/custom/${file#\.}.zsh
        fi
        local target=$HOME/$file
    fi
    create_symlink $target $origin
    local zsh=/bin/zsh
    if [ ! $SHELL = $zsh ]; then
        echo "Change login shell : $zsh"
        chsh -s $zsh
    fi
}

# bash
setup_bash() {
    echo ""
    echo "Setup bash"
    local file=.bash_profile
    create_symlink $HOME/$file $HOME/$DOTS_DIR/$file
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
    echo "setup.sh start"
    setup_basic_dots
    setup_sh
    setup_weechat
    echo "setup.sh finish"
}

main
