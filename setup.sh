#!/bin/bash

# make dirs
mkdir -p $HOME/.vim
mkdir -p $HOME/.rbenv

# dot files dir
DOTS_DIR=.dotfiles
# basic dot files
BASIC_DOTS=(.zprofile .zshrc .gemrc .pryrc .rspec .tmux.conf .vimrc .gvimrc .ideavimrc .vim/colors .vim/conf.d .gitconfig .gitignore .gitscript .bundle .tigrc .colordiffrc .rbenv/default-gems)
# backup dir
BACKUP_DIR=$HOME/.dotfiles_backup/`date +%Y%m%d_%H%M%S`


# Create symbolic link if not exists
create_symlink() {
    local target=$1
    local origin=$2
    create_backup $target
    if [ ! -e "$target" ]; then
        echo "Create symbolic link: $target -> $origin"
        ln -s $origin "$target"
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

# misc
setup_misc() {
    echo ""
    echo "Setup misc"

    echo "themes"
    create_symlink $HOME/themes $HOME/$DOTS_DIR/themes
    # echo "peco"
    # create_symlink $HOME/.peco $HOME/$DOTS_DIR/.peco
    # echo "rubymine"
    # create_symlink $HOME/rubymyine $HOME/$DOTS_DIR/rubymine
    # echo "iterm2"
    # create_symlink $HOME/iterm2 $HOME/$DOTS_DIR/iterm2
    # echo "google-ime"
    # create_symlink $HOME/google-ime $HOME/$DOTS_DIR/google-ime
    if [ -f /Applications/Karabiner.app/Contents/Library/bin/karabiner ]; then
        echo "karabiner"
        create_symlink "$HOME/Library/Application Support/karabiner/private.xml" $HOME/$DOTS_DIR/karabiner/private.xml
        /Applications/Karabiner.app/Contents/Library/bin/karabiner reloadxml
        karabiner be_careful_to_use__clear_all_values_by_name Default
        sh $HOME/$DOTS_DIR/src/karabiner-import.sh
    fi
}

main() {
    setup_basic_dots
    setup_misc
}

main
