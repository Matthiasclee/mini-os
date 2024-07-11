; Print contents of all registers
; Arguments: none
; Returns: none

std.dumpreg:
  push ax
  push bx

  mov bx, .al_text
  call .print_register
  
  mov al, ah
  mov bx, .ah_text
  call .print_register

  pop bx
  mov al, bl
  push bx
  mov bx, .bl_text
  call .print_register

  pop bx
  mov al, bh
  push bx
  mov bx, .bh_text
  call .print_register

  mov al, cl
  mov bx, .cl_text
  call .print_register
  
  mov al, ch
  mov bx, .ch_text
  call .print_register

  mov al, dl
  mov bx, .dl_text
  call .print_register

  mov al, dh
  mov bx, .dh_text
  call .print_register

  pop bx
  pop ax

  ret

.print_register:
  ; AL: value of register to print
  ; BX: address of register text
  call std.hex_to_ascii
  call std.print
  mov bx, std.hex_to_ascii.result_with_0x
  call std.printwnl
  ret


  .al_text: db "AL=", 0
  .ah_text: db "AH=", 0
  .bl_text: db "BL=", 0
  .bh_text: db "BH=", 0
  .cl_text: db "CL=", 0
  .ch_text: db "CH=", 0
  .dl_text: db "DL=", 0
  .dh_text: db "DH=", 0
