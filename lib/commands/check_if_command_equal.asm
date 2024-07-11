; Jump if entered command command is equal
; Arguments:
;   bx: command to check
;   cx: address to jump to if equal
; Returns: none

commands.check_if_command_equal:
  push cx
  mov cx, terminal.cmd_buffer
  push dx
  call std.check_if_equal
  cmp dh, 1
  pop dx
  pop cx
  ret
