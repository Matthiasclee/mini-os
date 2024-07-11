; Initialize terminal
; Arguments: none
; Returns: none

terminal.init:
terminal.loop:
terminal.after_command:
  mov bx, terminal.text.prompt
  call std.print
  call terminal.read_command

  mov bx, terminal.cmd_buffer
  mov bh, [bx]
  cmp bh, 0
  je terminal.loop

  jmp commands.check_commands
