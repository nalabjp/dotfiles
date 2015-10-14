#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set remap.left_option_to_option_forward_delete 1
/bin/echo -n .
$cli set repeat.wait 10
/bin/echo -n .
$cli set repeat.initial_wait 200
/bin/echo -n .
$cli set remap.shift_r_to_shift_delete 1
/bin/echo -n .
$cli set remap.jis_unify_eisuu_to_kana 1
/bin/echo -n .
$cli set private.app_slack_swap_enter_with_command_r 1
/bin/echo -n .
$cli set remap.jis_eisuu2delete 1
/bin/echo -n .
$cli set remap.command_r_delete_to_forward_delete 1
/bin/echo -n .
/bin/echo
