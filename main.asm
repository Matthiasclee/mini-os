[org 0x7c00]

%include "boot/boot.asm"

entry_point:
%include "os/main.asm"

hlt

times (512*10)-($-$$) db 0 ; End OS code

end_os_space:
