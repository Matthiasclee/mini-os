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
after_mlfs_loaded:
