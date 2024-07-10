; Read character from keyboard
; Arguments: none
; Returns:
;   al: character
;   ah: scancode

std.readchar:
  mov ah, 0
  int 0x16
  ret
