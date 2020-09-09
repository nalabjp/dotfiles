#!/bin/bash

source $HOME/.dotfiles/bootstrap.d/utils.sh

# make dirs
mkdir -p $HOME/.vim
mkdir -p $HOME/.rbenv
mkdir -p $XDG_CONFIG_HOME/nvim
mkdir -p $XDG_CONFIG_HOME/pry

# dot files dir
DOTS_DIR=.dotfiles
# basic dot files
BASIC_DOTS=(.zprofile .zshenv .zshrc .gemrc .rspec .tmux.conf .gvimrc .gitconfig .gitignore .gitscript .bundle .tigrc .colordiffrc .rbenv/default-gems)
XDG_CONFIGS_DIR=.config
# XDG config files
XDG_CONFIGS=(nvim/init.vim pry/pryrc)
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

# XDG Config files only symbolic link
setup_xdg_configs() {
    log_echo "Setup XDG config files"
    for file in ${XDG_CONFIGS[@]}
    do
        log_info "$file"
        create_symlink $XDG_CONFIG_HOME/$file $HOME/$DOTS_DIR/$XDG_CONFIGS_DIR/$file
    done
}

# misc
setup_misc() {
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
    # mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
    create_symlink $XDG_CONFIG_HOME/nvim ~/.vim

    log_info "zplug"
    zplug install
}

main() {
    setup_basic_dots
    setup_xdg_configs
    setup_misc
}

main
