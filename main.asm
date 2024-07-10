[org 0x7c00]

%include "boot/boot.asm"

entry_point:
%include "os/main.asm"

hlt
