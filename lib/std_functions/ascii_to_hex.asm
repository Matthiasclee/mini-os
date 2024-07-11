; Convert hex values to ascii for printing
; Arguments:
;   [std.ascii_to_hex.input]: ascii input (doesn't start with 0x)
;     [std.ascii_to_hex.input_first_chr]
;     [std.ascii_to_hex.input_second_chr]
; Returns:
;   al: hex value

std.ascii_to_hex:
  push bx
  push cx
  push dx

  mov dh, ah
  mov bx, .set_first
  mov cx, .input_first_chr

  .offset_ch:
  push bx
  mov bx, cx
  mov ah, [bx]
  pop bx

  push cx
  mov ch, ah
  push ax
  mov ah, 48
  mov al, 57
  call std.check_in_range
  pop ax
  cmp cl, 1
  pop cx
  je .int

  push cx
  mov ch, ah
  push ax
  mov ah, 65
  mov al, 70
  call std.check_in_range
  pop ax
  cmp cl, 1
  pop cx
  je .u_alpha

  push cx
  mov ch, ah
  push ax
  mov ah, 97
  mov al, 102
  call std.check_in_range
  pop ax
  cmp cl, 1
  pop cx
  je .l_alpha

  .badval:
    mov ah, 0
    jmp bx
  .int:
    mov dl, 48
    sub ah, dl
    jmp bx
  .u_alpha:
    mov dl, 55
    sub ah, dl
    jmp bx
  .l_alpha:
    mov dl, 87
    sub ah, dl
    jmp bx

  .set_first:
    mov al, ah
    shl al, 4
    mov bx, .set_second
    mov cx, .input_second_chr
    jmp .offset_ch

  .set_second:
    or al, ah

  mov ah, dh
  pop dx
  pop cx
  pop bx

  ret

  .input_first_chr:
  .input: db "0"
  .input_second_chr:
    db "0"
  db 0
