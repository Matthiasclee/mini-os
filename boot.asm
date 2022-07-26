[org 0x7c00]

jmp main

failcheck:
  mov bx, failcheckstring
  call print
  cli
  hlt
failcheckstring:
  db "Check failed.", 0

main:
  ; load more data
  ;where to put the data
  mov ax, 0
  mov es, ax ;es can not be set directly
  mov bx, 0x7e00
  mov ah, 2
  mov al, 2 ;sectors to load
  mov ch, 0 ;cylinder number
  mov cl, 2 ;sector number
  mov dh, 0 ;head number
  int 0x13
  
  mov bx, check
  mov ah, [bx]
  cmp ah, 0x11
  jne failcheck
  mov bx, check + 1
  mov ah, [bx]
  cmp ah, 0x17
  jne failcheck
  mov bx, check + 2
  mov ah, [bx]
  cmp ah, 0x20
  jne failcheck
  mov bx, check + 3
  mov ah, [bx]
  cmp ah, 0x09
  jne failcheck

  call reset
  jmp continueaftercmd

char:
  db 0
scancode:
  db 0

checkifcommandequal:
  mov cx, cmdbuffer + 1
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

endsector1:
  jmp $
  times 446-($-$$) db 0
  times 64 db 0
  db 0x55, 0xaa

mainloop:
  mov bx, string1 + 2
  call checkifcommandequal
  cmp dh, 1
  je continueaftercmd

  mov bx, newline
  call print
  mov dh, 0

  mov bx, cmd1
  call checkifcommandequal
  cmp dh, 1
  je reset1

  mov bx, cmd2
  call checkifcommandequal
  cmp dh, 1
  je help

  mov bx, cmd3
  call checkifcommandequal
  cmp dh, 1
  je btc

  mov bx, haltcmd
  call checkifcommandequal
  cmp dh, 1
  je haltcpu

  mov bx, shutdowncmd
  call checkifcommandequal
  cmp dh, 1
  je shutdown

  mov bx, cmdbuffer + 1
  mov al, '~'
  cmp [bx], al
  je rawjump

  mov bx, printallcharscmd
  call checkifcommandequal
  cmp dh, 1
  je printallchars

  jmp badcommand

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
haltcpu:
  mov bx, halttext1
  call print
  cli
  hlt
shutdown:
  mov bx, shutdowntxt1
  call print
  mov ax, 0x5307
  mov bx, 0x0001
  mov cx, 0x0003
  int 0x15
  mov bx, shutdownfailtxt
  call print
  cli
  hlt
printallchars:
  mov al, 0
printallchars1:
  mov ah, 0x0e
  int 0x10
  cmp al, 0xff
  inc al
  je continueaftercmd
  jmp printallchars1
rawjump:
  mov bx, cmdbuffer + 2
  mov al, [bx]
  cmp al, 0
  je badcommand
  mov bx, cmdbuffer + 3
  mov al, [bx]
  cmp al, 0
  je badcommand
  mov bx, cmdbuffer + 4
  mov al, [bx]
  cmp al, 0
  je badcommand
  mov bx, cmdbuffer + 5
  mov al, [bx]
  cmp al, 0
  je badcommand
  jmp continueaftercmd
  
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
  db "Invalid command - type 'help' for command list", 0
helptxt:
  db "Commands", 0x0d, 0x0a, "clear", 0x0d, 0x0a, "shutdown", 0x0d, 0x0a, "printall", 0x0d, 0x0a, "halt", 0x0d, 0x0a, "help", 0
btcaddr:
  db "1Q4Ba61mT7C6EtMRSyDj6HSxPsxXkgLPU3", 0
cmd3:
  db "btc", 0
haltcmd:
  db "halt", 0
shutdowncmd:
  db "shutdown", 0
printallcharscmd:
  db "printall", 0
shutdowntxt1:
  db "Shutting down...", 0
shutdownfailtxt:
  db "Failed to shut down. Halting CPU", 0
halttext1:
  db "Disabling interrupts and halting CPU", 0x0d, 0x0a, 0
bufflen:
  db 0
cmdbuffer:
  db 0, "clear"
  times 26 db 0
posinline:
  db 0
afterbuffer:

endsector2:
  jmp $
  times 1532-($-$$) db 0

check:
  db 0x11, 0x17, 0x20, 0x09
