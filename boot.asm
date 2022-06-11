[org 0x7c00]

main:
  call reset
  jmp continueaftercmd

mainloop:
  mov bx, newline
  call print
  mov dh, 0
  mov cx, cmdbuffer + 1
  mov bx, cmd1
  call checkifequal
  cmp dh, 1
  je reset1
  mov cx, cmdbuffer + 1
  mov bx, cmd2
  call checkifequal
  cmp dh, 1
  je help
  mov cx, cmdbuffer + 1
  mov bx, cmd3
  call checkifequal
  cmp dh, 1
  je btc
  jmp badcommand
continueaftercmd:
  
  mov bx, posinline
  mov ah, [zero]
  mov [bx], ah 
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
  mov al, 126
  call checkifcontains
  cmp ah, 1
  je charpressed
  mov bh, [scancode]
  cmp bh, 28
  je mainloop
  cmp bh, 14
  je backspace
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
  mov ah, [posinline]
  inc ah
  mov bx, posinline
  mov [bx], ah
  jmp readloop

backspace:
  mov ah, [posinline]
  cmp ah, 0
  je readloop
  mov ah, 0x0e
  mov al, 0x08
  int 0x10
  mov al, 0
  int 0x10
  mov al, 0x08
  int 0x10
  mov bx, posinline
  mov ah, [posinline]
  dec ah
  mov [bx], ah 
  mov ah, [bufflen]
  mov bx, cmdbuffer
  add bx, [bufflen]
  mov al, [zero]
  mov [bx], al
  dec ah
  mov bx, bufflen
  mov [bx], ah

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

reset1:
  call reset
  jmp continueaftercmd
reset:
  mov ax, 0
  int 0x10
  mov bx, string1
  call print
  ret
badcommand:
  mov bx, badcmd
  call print
  jmp continueaftercmd
help:
  mov bx, helptxt
  call print
  jmp continueaftercmd
btc:
  mov bx, btcaddr
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

string1:
  db "ML", 0
cmd1:
  db "clear", 0
cmd2:
  db "help", 0
prompt:
  db 0x0d, 0x0a, "> ", 0
newline:
  db 0x0d, 0x0a, 0
badcmd:
  db "Bad command", 0
helptxt:
  db "Commands", 0x0d, 0x0a, "clear", 0x0d, 0x0a, "btc", 0
btcaddr:
  db "1Q4Ba61mT7C6EtMRSyDj6HSxPsxXkgLPU3", 0
cmd3:
  db "btc", 0
bufflen:
  db 0
cmdbuffer:
zero:
  db 0
  db "clear"
  times 6 db 0
posinline:
  db 0
afterbuffer:

end:
  jmp $
  times 448-($-$$) db 0
  times 62 db 0
  db 0x55, 0xaa
