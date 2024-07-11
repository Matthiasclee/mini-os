jmp os.start

%include "lib/terminal/terminal.asm"
%include "lib/commands/commands.asm"

%include "os/commands/all.asm"

os.start:
call terminal.reset
jmp terminal.init
