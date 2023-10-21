mov bx, print_storage_command
call checkifcommandequal
cmp dh, 1
je print_storage_code

mov bx, write_storage_command
call checkifcommandequal
cmp dh, 1
je write_storage_code

