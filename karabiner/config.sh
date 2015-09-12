#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set remap.app_vm_commandL2optionL 1
/bin/echo -n .
$cli set repeat.wait 20
/bin/echo -n .
$cli set repeat.initial_wait 100
/bin/echo -n .
$cli set parameter.mouse_key_scroll_not_natural_direction 1
/bin/echo -n .
$cli set option.mousekeys_mode_uio2click 1
/bin/echo -n .
$cli set remap.sands.classic 1
/bin/echo -n .
$cli set remap.simultaneouskeypresses_mouse_keys_mode_df 1
/bin/echo -n .
/bin/echo
