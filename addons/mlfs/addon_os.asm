jmp after_mlfs_loaded
%include "addons/mlfs/setup_mlfs_structure.asm"
%include "addons/mlfs/new_file.asm"
flength:
db 0x00
fname:
db 0x00, 0x00, 0x00
after_mlfs_loaded:

;call setup_mlfs_structure
mov ch, 0x44
mov bx, flength
mov [bx], ch

call new_file

mov ch, 0x10
mov bx, flength
mov [bx], ch

call new_file

call write_to_storage

