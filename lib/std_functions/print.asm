; Print string to screen
; Arguments:
;   bx: address of string to print, string must end in 0x00
; Returns: none

std.print:
  push ax
  push bx
  mov ah, 0x0e
.loop:
  mov al, [bx]
  cmp al, 0
  je .exit
  int 0x10
  inc bx
  jmp .loop
.exit:
  pop bx
  pop ax
  ret
