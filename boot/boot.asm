jmp bootloader

%include "lib/std_functions/std_functions.asm"

bootloader:
  ; load more data
  ;where to put the data
  pusha
  mov ax, 0
  mov es, ax ;es can not be set directly
  mov bx, 0x7e00
  mov ah, 2
  mov al, [.loadsectors] ;sectors to load
  mov ch, 0 ;cylinder number
  mov cl, 2 ;sector number
  mov dh, 0 ;head number
  int 0x13
  popa

  jmp [.entrypoint]

  .loadsectors:
  db 0x03
  .entrypoint:
  dw entry_point
  db 0x00
  db 0x00
  db 0x00
  db 0x00
  db 0x00
  db 0x00
  db 0x00
  db 0x00
  db 0x00

  times 446-($-$$) db 0

  times 64 db 0

  .boot_singnature:
  db 0x55, 0xAA

  .end:
