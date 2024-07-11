; Print contents of all registers

os.commands.dumpreg:
  .name: db "dumpreg", 0
  .code:
    call std.dumpreg
    jmp terminal.after_command
