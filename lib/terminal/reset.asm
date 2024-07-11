; Reset terminal
; Arguments: none
; Returns: none

terminal.reset:
  push ax
  mov ah, 0
  mov al, 2
  int 0x10
  pop ax
  ret
