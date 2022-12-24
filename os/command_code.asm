help:
  mov bx, helptxt
  call print
  jmp continueaftercmd
haltcpu:
  mov bx, halttext1
  call print
  cli
  hlt
