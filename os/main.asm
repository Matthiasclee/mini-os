jmp os.start

%include "os/address_table.asm"
%include "lib/std_functions/ext_std_functions.asm"

%include "lib/terminal/terminal.asm"
%include "lib/commands/commands.asm"

%include "os/commands/all.asm"

os.start:
mov bx, terminal.text.prompt

mov ax, 0x13
call os.address_table.get_address

call ax
cli
hlt
;jmp terminal.init
