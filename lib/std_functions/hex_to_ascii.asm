; Convert hex values to ascii for printing
; Arguments:
;   al/ax: hex value
;   std.hex_to_ascii.two_bytes: Convert two bytes
; Returns:
;   [std.hex_to_ascii.result]: result
;   [std.hex_to_ascii.result_with_0x]: result (starts with 0x)
;   [std.hex_to_ascii.tb_result]: result (two bytes)
;   [std.hex_to_ascii.tb_result_with_0x]: result (starts with 0x) (two bytes)

std.hex_to_ascii:
  push ax
  push bx
  push cx

  mov cl, al
  mov ah, 0

  and al, 0xF0
  shr al, 4

  mov bx, .table
  add bx, ax

  mov ch, [bx]
  mov bx, .result_first_chr
  mov [bx], ch

  mov al, cl
  and al, 0x0F

  mov bx, .table
  add bx, ax

  mov ch, [bx]
  mov bx, .result_second_chr
  mov [bx], ch

  pop cx
  pop bx
  pop ax

  ret

  .result_with_0x: db "0x"
  .result_first_chr:
  .result: db "0"
  .result_second_chr:
    db "0"
  db 0

.two_bytes:
  push bx

  push ax

  mov al, ah
  call std.hex_to_ascii
  mov bx, .result_first_chr
  mov ah, [bx]
  mov bx, .tb_result_first_byte_1c
  mov [bx], ah
  mov bx, .result_second_chr
  mov ah, [bx]
  mov bx, .tb_result_first_byte_2c
  mov [bx], ah

  pop ax

  push ax

  call std.hex_to_ascii
  mov bx, .result_first_chr
  mov ah, [bx]
  mov bx, .tb_result_second_byte_1c
  mov [bx], ah
  mov bx, .result_second_chr
  mov ah, [bx]
  mov bx, .tb_result_second_byte_2c
  mov [bx], ah

  pop ax

  pop bx

  ret

  .tb_result_with_0x: db "0x"
  .tb_result:
  .tb_result_first_byte_1c: db "0"
  .tb_result_first_byte_2c: db "0"
  .tb_result_second_byte_1c: db "0"
  .tb_result_second_byte_2c: db "0"
  db 0

  .table:
    db "0123456789ABCDEF"
