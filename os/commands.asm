jmp commands
%include "os/command_strings.asm"
commands:
  mov bx, clearcmd
  call checkifcommandequal
  cmp dh, 1
  je reset1

  mov bx, helpcmd
  call checkifcommandequal
  cmp dh, 1
  je help

  mov bx, haltcmd
  call checkifcommandequal
  cmp dh, 1
  je haltcpu


