setup_mlfs_structure:
  mov bx, storagespace

  ; File Location Table

  ; Table size
  mov al, 0
  mov [bx], al
  
  inc bx

  ; Allocate space for table
  mov al, 0
  alloctableloop:
  mov [bx], al
  cmp bx, storagespace+80
  je tablemade
  inc bx
  jmp alloctableloop
  tablemade:

  mov bx, storagespace

  call write_to_storage
  ret

