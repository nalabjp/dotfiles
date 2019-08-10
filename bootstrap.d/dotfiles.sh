#!/bin/bash

source $HOME/.dotfiles/bootstrap.d/utils.sh

# make dirs
mkdir -p $HOME/.vim
mkdir -p $HOME/.rbenv

# dot files dir
DOTS_DIR=.dotfiles
# basic dot files
BASIC_DOTS=(.zprofile .zshenv .zshrc .gemrc .pryrc .rspec .tmux.conf .vimrc .gvimrc .gitconfig .gitignore .gitscript .git_template .bundle .tigrc .colordiffrc .rbenv/default-gems .rbenv/plugins)
# backup dir
BACKUP_DIR=$HOME/.dotfiles_backup/`date +%Y%m%d_%H%M%S`


# Create symbolic link if not exists
create_symlink() {
    local target=$1
    local origin=$2
    if [ ! -e "$target" ]; then
        log_pass "Create symbolic link: $target -> $origin"
        ln -s $origin "$target"
    fi
}

# Basic dot files only symbolic link
setup_basic_dots() {
    log_echo "Setup basic dot files"
    for file in ${BASIC_DOTS[@]}
    do
        log_info "$file"
        create_symlink $HOME/$file $HOME/$DOTS_DIR/$file
    done
}

# misc
setup_misc() {
    log_echo ""
    log_echo "Setup misc"

    log_info "themes"
    create_symlink $HOME/themes $HOME/$DOTS_DIR/themes

    if [ ! -f $HOME/.hushlogin ]; then
        log_info 'create ~/.hushlogin'
        touch $HOME/.hushlogin
    fi

    if [ -e /Applications/Karabiner-Elements.app ]; then
        log_info "Karabiner-Elements"
        cp -r $HOME/$DOTS_DIR/karabiner $HOME/.config/
    fi

    log_info "neovim"
    mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
    create_symlink $XDG_CONFIG_HOME/nvim ~/.vim
    create_symlink $XDG_CONFIG_HOME/nvim/init.vim ~/.vimrc
}

main() {
    setup_basic_dots
    setup_misc
}

main
