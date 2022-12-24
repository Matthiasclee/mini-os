call reset

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

  mov bx, haltcmd
  call checkifcommandequal
  cmp dh, 1
  je haltcpu

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
  db "Commands", 0x0d, 0x0a, "clear", 0x0d, 0x0a, "halt", 0x0d, 0x0a, "help", 0
haltcmd:
  db "halt", 0
halttext1:
  db "Disabling interrupts and halting CPU", 0x0d, 0x0a, 0

endsector2:
  jmp $
  times 1532-($-$$) db 0

