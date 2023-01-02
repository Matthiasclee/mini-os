jmp main

bootup_message:
  db "ML bootloader", 0x0d, 0x0a, 0
diskcheckfailedtext:
  db "Error: disk check failed", 0
diskcheckfailed:
  mov bx, diskcheckfailedtext
  call print
  cli
  hlt

%include "lib/os_funcs.asm"

main:
  mov bx, bootup_message
  call print

  ; load more data
  ;where to put the data
  mov ax, 0
  mov es, ax ;es can not be set directly
  mov bx, 0x7e00
  mov ah, 2
  mov al, [loadsectors] ;sectors to load
  mov ch, 0 ;cylinder number
  mov cl, 2 ;sector number
  mov dh, 0 ;head number
  int 0x13

  ; Check if data is valid
  mov ah, [skipdatacheck]
  cmp ah, 1
  je beginnext
  mov ah, [check]
  mov al, [check + 1]
  cmp ax, 0x4D09
  je beginnext
  jne diskcheckfailed

endsector1:
  jmp $
  times 500-($-$$) db 0
  ; Boot flags
  skipdatacheck:
    db 0x00
  loadsectors:
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
