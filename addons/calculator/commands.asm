mov bx, calculator_addon_command
call checkifcommandequal
cmp dh, 1
je calculator_addon_command_code
