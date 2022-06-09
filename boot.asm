[org 0x7c00]

char:
  db 0

scancode:
  db 0

readchar:
  mov ah, 0
  int 0x16
  mov bx, char
  mov [bx], al
  mov bx, scancode
  mov [bx], ah
  ret

print:
  mov ah, 0x0e
  mov al, [bx]
  cmp al, 0
  je return
  int 0x10
  inc bx
  jmp print

return:
  ret

exit:
  jmp $
  times 510-($-$$) db 0
  db 0x55, 0xaa
