; Write sectors to drive
; Arguments:
;   bx: address
;   al: number of sectors to write
;   cl: sector number
;   dl: drive number (see below)
;   ch, dh: cylinder number (default 0), head number (default 0)
; Returns:
;   carry flag: set on failure
;   ah: return code
;   al: actual number of sectors written

; Drive numbers:
;   0x80 - 0xFF -- Hard disks
;   0x0 - 0x7F -- Floppy disks
;   0xE0 -- CD/DVD or hard disk

std.write_to_drive:
  push ax
  mov ax, 0 ; Buffer address pointer
  mov es, ax
  pop ax

  mov ah, 3 ; Write to drive

  int 0x13
  ret
