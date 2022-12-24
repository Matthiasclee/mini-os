char:
  db 0
scancode:
  db 0

checkifcommandequal:
  mov cx, cmdbuffer + 1
  call checkifequal
  ret

reset1:
  call reset
  jmp continueaftercmd
reset:
  mov ah, 0
  mov al, 2
  int 0x10
  mov bx, string1
  call print
  ret

continueaftercmd:
  mov bx, posinline
  mov ah, 0
  mov [bx], ah 
  mov bx, prompt
  call print
  mov bx, bufflen
  mov ah, 0
  mov [bx], ah

  mov bx, cmdbuffer - 1
  mov ah, 0
clearbuffer:
  inc bx
  cmp bx, afterbuffer
  je readloop
  mov [bx], ah
  jmp clearbuffer

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
  cmp ah, 30
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
  mov al, 0
  mov [bx], al
  dec ah
  mov bx, bufflen
  mov [bx], ah

  jmp readloop

