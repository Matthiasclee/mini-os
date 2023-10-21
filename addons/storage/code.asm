print_storage_code:
  mov bx, storagetext.print
  call print
  mov bx, storagespace
  call print
  jmp continueaftercmd 

write_storage_code:
  mov bx, storagetext.writer
  call print

  mov ah, 0x0e
  mov bx, storagespace

  .printloop:
    mov al, 0
    cmp [bx], al
    je write_storage_code.writeloop
    mov al, [bx]
    int 0x10
    inc bx
    jmp write_storage_code.printloop

  .writeloop:
    call readchar

    mov bh, [char]
    mov ah, 32
    mov al, 126
    call checkifcontains
    cmp ah, 1
    je write_storage_code.wl_ischar

    mov ah, 0x0e
    mov al, [scancode]
    cmp al, 28
    je write_storage_code.saveandquit
    cmp al, 1
    je write_storage_code.exit
    cmp al, 14
    je write_storage_code.backspace
    jmp write_storage_code.writeloop

    .wl_ischar:
    mov ah, 0x0e
    mov al, [char]
    
    int 0x10

    mov [bx], al
    inc bx
    cmp bx, endstoragespace
    je write_storage_code.storagefull
    jmp write_storage_code.writeloop
  .save:
    call write_to_storage
    jmp write_storage_code.writeloop
  .storagefull:
    mov bx, storagetext.full
    call print
    jmp write_storage_code.saveandquit
  .saveandquit:
    call write_to_storage
  .exit:
    mov dh, 0x55 ; code to return after
    call load_storagedata ; load storage data from disk
    jmp continueaftercmd
  .backspace:
    cmp bx, storagespace
    je write_storage_code.writeloop
    mov al, 0x08
    int 0x10
    mov al, 0
    int 0x10
    mov al, 0x08
    int 0x10
    dec bx
    mov al, 0
    mov [bx], al
    jmp write_storage_code.writeloop
    
clear_storage_code:
  mov bx, storagespace
  mov ah, 0
  .loop:
    mov [bx], ah
    inc bx
    cmp bx, endstoragespace
    jne clear_storage_code.loop
  mov bx, storagetext.cleared
  call print
  jmp continueaftercmd
