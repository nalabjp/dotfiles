#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set repeat.initial_wait 250
/bin/echo -n .
$cli set remap.fkeys_to_consumer_f5 1
/bin/echo -n .
$cli set remap.fkeys_to_consumer_f1 1
/bin/echo -n .
$cli set remap.fkeys_to_consumer_f10 1
/bin/echo -n .
$cli set repeat.wait 15
/bin/echo -n .
$cli set remap.fkeys_to_consumer_f3_lion 1
/bin/echo -n .
$cli set remap.doublepresscommandQ 1
/bin/echo -n .
$cli set remap.fkeys_to_consumer_f7 1
/bin/echo -n .
$cli set private.topre.set_option_to_command_and_eisuu_kana 1
/bin/echo -n .
$cli set private.topre.set_command_to_option 1
/bin/echo -n .
/bin/echo
