load_storagedata:
  ;where to put the data
  mov ax, 0
  mov es, ax ;es can not be set directly
  mov bx, storagespace
  mov ah, 2
  mov al, 1 ;sectors to load
  mov ch, 0 ;cylinder number
  mov cl, 5 ;sector number
  mov dh, 0 ;head number
  int 0x13

