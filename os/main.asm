jmp os.start

%include "lib/std_functions/ext_std_functions.asm"

%include "lib/terminal/terminal.asm"
%include "lib/commands/commands.asm"

%include "os/commands/all.asm"

os.start:
jmp terminal.init
