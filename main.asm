[org 0x7c00]

%include "boot/boot.asm"
%include "os/main.asm"

endsector3:
  jmp $
  times 2047-($-$$) db 0
check:
  db 0xFF
