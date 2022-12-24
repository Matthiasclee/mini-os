jmp commands
%include "os/command_names.asm"
%include "os/command_text.asm"
%include "os/command_code.asm"

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

  %include "addons/addons.asm"
