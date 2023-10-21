print_storage_code:
  mov bx, storagespace
  call print
  jmp continueaftercmd 

write_storage_code:
  mov ah, 0x0e
  mov bx, storagespace

  .writeloop:
    call readchar
    mov al, [scancode]
    cmp al, 28
    je write_storage_code.finish
    cmp al, 14
    je write_storage_code.backspace
    mov al, [char]
    
    int 0x10

    mov [bx], al
    inc bx
    cmp bx, endstoragespace
    je write_storage_code.storagefull
    jmp write_storage_code.writeloop
  .finish:
    call write_to_storage
    jmp continueaftercmd
  .storagefull:
    mov bx, storagetext.full
    call print
    jmp write_storage_code.finish
  .backspace:
    mov al, 0x08
    int 0x10
    mov al, 0
    int 0x10
    mov al, 0x08
    int 0x10
    mov [bx], al
    dec bx
    jmp write_storage_code.writeloop
    
