; Jump to place in memory

os.commands.jump:
  .name: db "jump", 0
  .code:
    call std.read_hexval
    jmp cx
os.commands.call:
  .name db "call", 0
  .code:
    call std.read_hexval
    call cx
    jmp terminal.after_command
