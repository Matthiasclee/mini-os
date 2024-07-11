; Check given command against all commands
; Arguments: 
;   [terminal.cmd_buffer]: given command
; Returns: none

commands.check_commands:
  %include "lib/commands/additional_commands.asm"

  jmp commands.bad_command
