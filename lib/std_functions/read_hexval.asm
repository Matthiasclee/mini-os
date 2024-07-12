; Read two-byte hex value from user
; Arguments:
;   [std.read_hexval.single_byte]: Only read one byte
; Returns:
;   cx: hex value

std.read_hexval:
  push ax
  push bx

  mov cx, 0x0000
  mov bx, .0x_prompt
  call std.print  

  .val1:
  mov bx, std.ascii_to_hex.input_first_chr
  .val1_loop:
  call std.readchar
  mov ah, 0x0e
  int 0x10
  mov [bx], al
  call std.ascii_to_hex
  mov ch, al
  inc bx
  cmp bx, std.ascii_to_hex.input_done
  je .val2
  jmp .val1_loop

  .single_byte:
  push ax
  push bx

  mov bx, .0x_prompt
  call std.print  

  .val2:
  mov bx, std.ascii_to_hex.input_first_chr
  .val2_loop:
  call std.readchar
  mov ah, 0x0e
  int 0x10
  mov [bx], al
  call std.ascii_to_hex
  mov cl, al
  inc bx
  cmp bx, std.ascii_to_hex.input_done
  je .done
  jmp .val2_loop

  .done:
  mov bx, terminal.ascii.crlf
  call std.print

  pop bx
  pop ax

  ret

  .0x_prompt: db "0x", 0
