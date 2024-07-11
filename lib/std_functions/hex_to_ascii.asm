; Convert hex values to ascii for printing
; Arguments:
;   al: hex value
; Returns:
;   [std.hex_to_ascii.result]: result
;   [std.hex_to_ascii.result_with_0x]: result (starts with 0x)

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

  .table:
    db "0123456789ABCDEF"
