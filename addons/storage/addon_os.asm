%include "addons/storage/load.asm"

jmp after_storagelibs_loaded
%include "addons/storage/write.asm"
after_storagelibs_loaded:
