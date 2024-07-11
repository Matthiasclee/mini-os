commands.bad_command:
  mov bx, terminal.text.bad_command
  call std.printwnl
  jmp terminal.after_command
