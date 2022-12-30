jmp after_mlfs_loaded
%include "addons/mlfs/setup_mlfs_structure.asm"
%include "addons/mlfs/new_file.asm"
after_mlfs_loaded:

;call setup_mlfs_structure
call new_file
call write_to_storage
