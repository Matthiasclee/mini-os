; Jump if entered command command is equal
; Arguments:
;   bx: command to check
;   cx: address to jump to if equal
; Returns: none

commands.jump_if_command_equal:
  push cx
  push dx
  push bx
  mov bx, .jmp_command+1
  pop bx
  mov [bx], cx
  mov cx, terminal.cmd_buffer
  call std.check_if_equal
  pop dx
  pop cx
  cmp dh, 1
  .jmp_command:
  je 0x00
