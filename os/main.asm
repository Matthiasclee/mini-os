call reset
jmp mainloop

%include "lib/terminal/terminal.asm"

mainloop:


  mov bx, zero
  call checkifcommandequal
  cmp dh, 1
  je continueaftercmd

  mov bx, newline
  call print
  mov dh, 0

  %include "os/commands.asm"

  jmp badcommand

badcommand:
  mov bx, badcmd
  call print
  jmp continueaftercmd

zero:
  db 0
string1:
  db "", 0
prompt:
  db 0x0d, 0x0a, "> ", 0
newline:
  db 0x0d, 0x0a, 0
badcmd:
  db "Invalid command - type 'help' for command list", 0
