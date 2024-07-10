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

