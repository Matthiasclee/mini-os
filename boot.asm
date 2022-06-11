[org 0x7c00]

jmp main

string1:
  db "ML", 0
cmd1:
  db "clear", 0
prompt:
  db 0x0d, 0x0a, "> ", 0
bufflen:
  db 0
zero:
  db 0
cmdbuffer:
  times 12 db 0
afterbuffer:

main:
  mov ax, 0
  int 0x10
  mov bx, string1
  call print

mainloop:
  mov dh, 0
  mov cx, cmdbuffer + 1
  mov bx, cmd1
  call checkifequal
  cmp dh, 1
  je reset
continueaftercmd:

  mov bx, prompt
  call print
  mov bx, bufflen
  mov ah, [zero]
  mov [bx], ah

  mov bx, cmdbuffer - 1
  mov ah, [zero]
  
clearbuffer:
  inc bx
  cmp bx, afterbuffer
  je continue
  mov [bx], ah
  jmp clearbuffer

continue:

readloop:
  call readchar
  mov bh, [char]
  mov ah, 32
  mov al, 127
  call checkifcontains
  cmp ah, 1
  je charpressed
  mov bh, [scancode]
  cmp bh, 28 
  je mainloop
  jmp readloop

charpressed:
  mov ah, [bufflen]
  cmp ah, 10
  je readloop
  inc ah
  mov bx, bufflen
  mov [bx], ah
  mov bx, cmdbuffer
  add bx, [bufflen]
  mov al, [char]
  mov [bx], al
  mov al, [bx]
  mov ah, 0x0e
  int 0x10
  jmp readloop

char:
  db 0

scancode:
  db 0

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

reset:
  mov ax, 0
  int 0x10
  mov bx, string1
  call print
  jmp continueaftercmd
  
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
  mov dh, 0
  ret
checkifequalzeroal:
  cmp ah, 0
  je return
  mov dh, 0
  ret
checkifequalfail:
  mov dh, 0
  ret

return:
  ret

print:
  pusha
print1:
  mov ah, 0x0e
  mov al, [bx]
  cmp al, 0
  je exitprint
  push bx
  mov bx, 0
  int 0x10
  pop bx
  inc bx
  jmp print1
exitprint:
  popa
  ret

end:
  jmp $
  times 510-($-$$) db 0
  db 0x55, 0xaa
