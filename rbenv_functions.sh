#!/bin/bash

install_gem_if_not_installed() {
    test ! "${GEM_CMD}" && GEM_CMD='gem'
    local gem=$1
    echo [$gem]
    if [ `$GEM_CMD list $gem -i` = 'false' ]; then
        echo '  now installing...'
        $GEM_CMD install $gem
        rbenv rehash
    else
        echo '  already installed'
    fi

}

install_gem_list_if_not_installed() {
    local gems_list=$@
    for gem in ${gems_list[@]}
    do
        install_gem_if_not_installed $gem
    done
}
