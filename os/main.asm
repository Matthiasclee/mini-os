call reset
jmp mainloop


mainloop:
  mov bx, zero
  call checkifcommandequal
  cmp dh, 1
  je continueaftercmd

  mov bx, newline
  call print
  mov dh, 0

  %include "os/commands.asm"

  mov bx, cmdbuffer + 1
  mov al, '~'
  cmp [bx], al
  je rawjump

  jmp badcommand

badcommand:
  mov bx, badcmd
  call print
  jmp continueaftercmd
help:
  mov bx, helptxt
  call print
  jmp continueaftercmd
haltcpu:
  mov bx, halttext1
  call print
  cli
  hlt
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

zero:
  db 0
string1:
  db "ML", 0
prompt:
  db 0x0d, 0x0a, "> ", 0
newline:
  db 0x0d, 0x0a, 0
badcmd:
  db "Invalid command - type 'help' for command list", 0
helptxt:
  db "Commands", 0x0d, 0x0a, "clear", 0x0d, 0x0a, "halt", 0x0d, 0x0a, "help", 0
halttext1:
  db "Disabling interrupts and halting CPU", 0x0d, 0x0a, 0

endsector2:
  jmp $
  times 1532-($-$$) db 0
