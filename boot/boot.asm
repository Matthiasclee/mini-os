jmp bootloader

%include "lib/std_functions/std_functions.asm"

bootloader:
  mov bx, 0x7e00
  mov al, [.loadsectors]
  mov cl, 2
  mov ch, 0
  mov dh, 0
  mov dl, 0x80

  call std.read_from_drive

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
