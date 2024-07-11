call terminal.clear
jmp mainloop

%include "lib/terminal/terminal.asm"
%include "lib/commands/commands.asm"

mainloop:
  mov bx, terminal.text.prompt
  call std.print
  call terminal.read_command

  mov bx, terminal.text.null
  call commands.check_if_command_equal
  je mainloop

  jmp badcommand

badcommand:
  mov bx, terminal.text.bad_command
  call std.printwnl
  jmp mainloop
