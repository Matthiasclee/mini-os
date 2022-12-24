mov bx, default_addon_command
call checkifcommandequal
cmp dh, 1
je default_addon_command_code
