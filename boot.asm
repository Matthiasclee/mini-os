[org 0x7c00]

jmp codestart

db "Matthias Lee"

string1:
  db "Bootloader started", 0x0d, 0x0a, 0
string2:
  db "Configuring registers", 0x0d, 0x0a, 0
string3:
  db "Additional sectors loaded successfully", 0

codestart:
  mov bx, string1
  call print
  jmp setup

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

setup:
  mov bx, string2
  call print

  mov ax, 0
  mov es, ax
  mov ah, 2
  mov al, 1
  mov ch, 0
  mov cl, 2
  mov dh, 0
  mov bx, 0x7e00

continue:
  int 0x13

  mov bx, string3
  call print
  
  jmp $
  times 510-($-$$) db 0
  db 0x55, 0xaa
