jmp os.start

%include "lib/terminal/terminal.asm"
%include "lib/commands/commands.asm"

os.start:
call terminal.clear
jmp terminal.init
