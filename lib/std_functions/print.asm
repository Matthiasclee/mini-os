; Print string to screen
; Arguments:
;   bx: address of string to print, string must end in 0x0
; Returns: none

std.print_with_newline:
std.print_w_nl:
std.printwnl:
  call std.print
  push ax
  mov ah, 0x0e
  mov al, 0x0d
  int 0x10
  mov al, 0x0a
  int 0x10
  pop ax
  ret

std.print:
  push ax
  push bx
  mov ah, 0x0e
.loop:
  mov al, [bx]
  cmp al, 0
  .jmp_op:
  je .exit
  int 0x10
  inc bx
  jmp .loop
.exit:
  pop bx
  pop ax
  ret
