#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set remap.doublepresscommandQ 1
/bin/echo -n .
$cli set repeat.wait 20
/bin/echo -n .
$cli set repeat.initial_wait 200
/bin/echo -n .
$cli set remap.jis_kana2return 1
/bin/echo -n .
$cli set remap.jis_unify_kana_to_eisuu 1
/bin/echo -n .
$cli set remap.commandR2commandR_delete_keyrepeat 1
/bin/echo -n .
/bin/echo
