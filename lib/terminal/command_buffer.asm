terminal.cmd_buffer:
  times 10 db 0
terminal.cmd_buffer_end:
  db 0

; Clear command buffer
; Arguments: none
; Returns: none
terminal.clear_cmd_buffer:
  push ax
  push bx
  mov bx, terminal.cmd_buffer
  .loop:
  cmp bx, terminal.cmd_buffer_end
  je .done
  mov ah, 0
  mov [bx], ah
  inc bx
  jmp .loop
  .done:
  pop bx
  pop ax
  ret
