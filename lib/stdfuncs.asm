char:
  db 0
scancode:
  db 0

print:
  mov ah, 0x0e
  mov al, [bx]
  cmp al, 0
  je exitprint
  push bx
  mov bx, 0
  int 0x10
  pop bx
  inc bx
  jmp print
exitprint:
  ret

checkifcontains:
  pusha
checkifcontains1:
  cmp bh, ah
  je checkifcontainssuccess
  cmp ah, al
  je checkifcontainsfail
  inc ah
  jmp checkifcontains1 
checkifcontainssuccess:
  popa
  mov ah, 1
  ret
checkifcontainsfail:
  popa
  mov ah, 0
  ret

checkifequal:
  mov dh, 1
  jmp checkifequal2
checkifequal1:
  inc bx
  inc cx
checkifequal2:
  mov ah, [bx]
  push bx
  mov bx, cx
  mov al, [bx]
  pop bx
  cmp ah, 0
  je checkifequalzeroah
  cmp al, 0
  je checkifequalzeroal
  cmp ah, al
  jne checkifequalfail
  jmp checkifequal1
checkifequalzeroah:
  cmp al, 0
  je return
  jmp checkifequalfail
checkifequalzeroal:
  cmp ah, 0
  je return
  jmp checkifequalfail
checkifequalfail:
  mov dh, 0
  ret

return:
  ret

readchar:
  pusha
  mov ah, 0
  int 0x16
  mov bx, char
  mov [bx], al
  mov bx, scancode
  mov [bx], ah
  popa
  ret

