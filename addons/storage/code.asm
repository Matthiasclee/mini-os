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
    mov al, [char]
    
    int 0x10

    mov [bx], al
    inc bx
    jmp write_storage_code.writeloop
  .finish:
    call write_to_storage
    jmp continueaftercmd
