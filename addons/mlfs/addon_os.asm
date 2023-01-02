jmp after_mlfs_loaded
%include "addons/mlfs/setup_mlfs_structure.asm"
%include "addons/mlfs/new_file.asm"
flength:
db 0x00
fname:
db 0x00, 0x00, 0x00
fdataddr:
db 0x00, 0x00
flocaddr:
db 0x00, 0x00
fdat:
db "Hello, This is very cool!!"
after_mlfs_loaded:

;call setup_mlfs_structure
mov ax, fdat
mov bx, fdataddr
mov [bx], ah
inc bx
mov [bx], al

mov ch, 25
mov bx, flength
mov [bx], ch

call new_file

call write_to_storage

