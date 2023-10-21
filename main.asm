[org 0x7c00]

%include "boot/boot.asm"
%include "os/main.asm"

endsector3:
  jmp $
  times 2046-($-$$) db 0
check:
  db 0x4d, 0x09

storagespace:
  times 512 db 0
endstoragespace:
