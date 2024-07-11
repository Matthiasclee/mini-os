start:

jmp bootloader

%include "lib/std_functions/std_functions.asm"

bootloader:
  mov bx, .end
  mov al, [.loadsectors]
  mov cl, 2 ; Sector #
  mov ch, 0 ; Cyl #
  mov dh, 0 ; Head #
  mov dl, 0x80 ; Drive #

  call std.read_from_drive
  jc .load_failed

  .jump_to_entrypoint:
  jmp [.entrypoint]

  .loadsectors:
    db 0x01 ; Number of sectors to load from disk
  .ignore_load_failure:
    db 0x00 ; Jump to entrypoint regardless of load failure
  .entrypoint:
    dw entry_point ; Point to jump to
  db 0x00
  db 0x00
  db 0x00
  db 0x00
  db 0x00
  db 0x00
  db 0x00
  db 0x00

  .load_failed:
    mov bx, .ignore_load_failure
    mov ah, [bx]
    cmp ah, 1
    je .jump_to_entrypoint

    mov bx, .load_failed_text
    call std.print
    cli
    hlt
  .load_failed_text: db "Failed to load sectors from disk.", 0

  times 446-($-$$) db 0

  times 64 db 0

  .boot_singnature:
  db 0x55, 0xAA

  .end:
