start:

jmp bootloader

%include "lib/std_functions/std_functions.asm"

bootloader:
  mov bx, .end
  mov al, [.loadsectors]
  mov cl, 2 ; Sector #
  mov ch, 0 ; Cyl #
  mov dh, 0 ; Head #
  mov dl, [.loaddrive] ; Drive #

  call std.read_from_drive
  jc .load_failed

  .jump_to_entrypoint:
  call std.cleanreg
  jmp [.entrypoint]

  .loaddrive:
    db 0x80 ; Drive to load data from
  .loadsectors:
    db 0x09 ; Number of sectors to load from disk
  .ignore_load_failure:
    db 0x00 ; Jump to entrypoint regardless of load failure
  .entrypoint:
    dw entry_point ; Point to jump to

  .load_failed:
    mov bx, .ignore_load_failure
    mov ch, [bx]
    cmp ch, 1
    je .jump_to_entrypoint

    mov bx, .load_failed_text
    call std.printwnl

    call std.dumpreg
    call std.readchar
    jmp bootloader    

  .load_failed_text: db "Failed to load sectors from disk.", 0

  times 446-($-$$) db 0

  times 64 db 0

  .boot_singnature:
  db 0x55, 0xAA

  .end:
