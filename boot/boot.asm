jmp bootloader

bootloader_messages:
  .init_message:
    db "ML bootloader", 0x0d, 0x0a, 0
  .diskcheckfailed:
    db "Error: disk check failed", 0
bootloader_checks:
  .diskcheckfailed:
    mov bx, bootloader_messages.diskcheckfailed
    call print
    cli
    hlt

%include "lib/os_funcs.asm"

bootloader:
  mov bx, bootloader_messages.init_message
  call print

  ; load more data
  ;where to put the data
  mov ax, 0
  mov es, ax ;es can not be set directly
  mov bx, 0x7e00
  mov ah, 2
  mov al, [boot_opts.loadsectors] ;sectors to load
  mov ch, 0 ;cylinder number
  mov cl, 2 ;sector number
  mov dh, 0 ;head number
  int 0x13

  ; Check if data is valid
  mov ah, [boot_opts.skipdatacheck]
  cmp ah, 1
  je beginnext
  mov ah, [check]
  mov al, [check + 1]
  cmp ax, 0x4D09
  je beginnext
  jne bootloader_checks.diskcheckfailed

endsector1:
  jmp $
  times 500-($-$$) db 0
  ; Boot flags
  boot_opts:
    .skipdatacheck:
      db 0x00
    .loadsectors:
      db 0x03
    db 0x00
    db 0x00
    db 0x00
    db 0x00
    db 0x00
    db 0x00
    db 0x00
    db 0x00

  ; Signature
  db 0x55, 0xaa

beginnext:
