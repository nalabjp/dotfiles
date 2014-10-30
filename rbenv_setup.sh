#!/bin/bash

RUBIES=(1.9.3-p484 2.0.0-p353 2.1.0 2.1.1 2.1.2)

# ruby install & gem install to global
for version in ${RUBIES[@]}
do
    echo ''
    echo '## ruby '$version' ##'
    if [ ! -d $(brew --prefix rbenv)/versions/$version ]; then
        rbenv install $version
        echo 'installed!'
    fi
done
