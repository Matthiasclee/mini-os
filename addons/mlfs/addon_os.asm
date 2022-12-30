jmp after_mlfs_loaded
%include "addons/mlfs/setup_mlfs_structure.asm"
after_mlfs_loaded:

call setup_mlfs_structure
