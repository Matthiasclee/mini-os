; Initialize terminal
; Arguments: none
; Returns: none

terminal.init:
terminal.loop:
terminal.after_command:
  mov bx, terminal.text.prompt
  call std.print
  call terminal.read_command

  mov bx, terminal.text.null
  call commands.check_if_command_equal
  je terminal.loop

  jmp commands.check_commands
