; Reset computer

os.commands.reset:
  .name: db "reset", 0
  .code:
    int 0x19
    jmp terminal.after_command
