#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set repeat.wait 15
/bin/echo -n .
$cli set repeat.initial_wait 250
/bin/echo -n .
$cli set remap.doublepresscommandQ 1
/bin/echo -n .
/bin/echo
