; Check given command against all commands
; Arguments: 
;   [terminal.cmd_buffer]: given command
; Returns: none

commands.check_commands:
  mov bx, reset_text
  call commands.check_if_command_equal
  je reset

  jmp commands.bad_command
