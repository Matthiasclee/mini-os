; Clear screen

os.commands.clear:
  .name: db "clear", 0
  .code:
    call terminal.reset
    jmp terminal.after_command
