#!/bin/bash

SRC=$HOME/.dotfiles/src
source $SRC/utils.sh

# make dirs
mkdir -p $HOME/.vim
mkdir -p $HOME/.rbenv

# dot files dir
DOTS_DIR=.dotfiles
# basic dot files
BASIC_DOTS=(.zprofile .zshenv .zshrc .gemrc .pryrc .rspec .tmux.conf .vimrc .gvimrc .gitconfig .gitignore .gitscript .bundle .tigrc .colordiffrc .rbenv/default-gems)
# backup dir
BACKUP_DIR=$HOME/.dotfiles_backup/`date +%Y%m%d_%H%M%S`


# Create symbolic link if not exists
create_symlink() {
    local target=$1
    local origin=$2
    create_backup $target
    if [ ! -e "$target" ]; then
        log_info "Create symbolic link: $target -> $origin"
        ln -s $origin "$target"
    fi
}

# Backup
create_backup() {
    local target=$1
    if [ -e $target ]; then
        log_warn "Already exists: $target"
        log_warn "Back up to $BACKUP_DIR"
        mkdir -p $BACKUP_DIR
        mv $target $BACKUP_DIR/${target##*/}
    fi
}

# Basic dot files only symbolic link
setup_basic_dots() {
    log_echo ""
    log_echo "Setup basic dot files"
    for file in ${BASIC_DOTS[@]}
    do
        log_echo "$file"
        create_symlink $HOME/$file $HOME/$DOTS_DIR/$file
    done
}

# misc
setup_misc() {
    log_echo ""
    log_echo "Setup misc"

    log_echo "themes"
    create_symlink $HOME/themes $HOME/$DOTS_DIR/themes

    if [ ! -f $HOME/.hushlogin ]; then
        log_info 'create ~/.hushlogin'
        touch $HOME/.hushlogin
    fi

    if [ -f /Applications/Karabiner.app/Contents/Library/bin/karabiner ]; then
        log_echo "karabiner"
        create_symlink "$HOME/Library/Application Support/karabiner/private.xml" $HOME/$DOTS_DIR/karabiner/private.xml
        /Applications/Karabiner.app/Contents/Library/bin/karabiner reloadxml
        karabiner be_careful_to_use__clear_all_values_by_name Default
        sh $HOME/$DOTS_DIR/karabiner/import.sh
    fi
}

main() {
    setup_basic_dots
    setup_misc
}

main
