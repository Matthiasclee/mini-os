mov bx, print_storage_command
call checkifcommandequal
cmp dh, 1
je print_storage_code

