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
