call terminal.clear
jmp mainloop

%include "lib/terminal/terminal.asm"
%include "lib/commands/commands.asm"

mainloop:
  mov bx, terminal.text.prompt
  call std.print
  call terminal.read_command

  jmp badcommand

badcommand:
  mov bx, terminal.text.bad_command
  call std.print
  jmp mainloop
