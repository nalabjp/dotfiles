#!/bin/bash

source $HOME/.dotfiles/bootstrap.d/utils.sh

if [ `which rustc` ]; then
    log_echo 'Update Rust'
    rustup update stable
    log_info 'Updated!!'
else
    log_echo 'Install Rust'
    curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
    log_info 'Installed!!'

    cargo install racer
    rustup component add rust-src
    cargo install rustfmt
fi
