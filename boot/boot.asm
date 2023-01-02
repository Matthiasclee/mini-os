jmp main

%include "lib/os_funcs.asm"

main:
  ; load more data
  ;where to put the data
  mov ax, 0
  mov es, ax ;es can not be set directly
  mov bx, 0x7e00
  mov ah, 2
  mov al, 3 ;sectors to load
  mov ch, 0 ;cylinder number
  mov cl, 2 ;sector number
  mov dh, 0 ;head number
  int 0x13

  mov ah, [check]
  cmp ah, 0xFF
  je beginnext

endsector1:
  jmp $
  times 510-($-$$) db 0
  db 0x55, 0xaa

beginnext:
