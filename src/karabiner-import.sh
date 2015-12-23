#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set remap.doublepresscommandQ 1
/bin/echo -n .
$cli set repeat.wait 10
/bin/echo -n .
$cli set repeat.initial_wait 200
/bin/echo -n .
$cli set remap.shift_r_to_shift_delete 1
/bin/echo -n .
$cli set remap.commandR2commandR_delete_keyrepeat 1
/bin/echo -n .
/bin/echo
