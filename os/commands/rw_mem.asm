; Read from memory address

os.commands.readmem:
  .name: db "readmem", 0
  .code:
    call std.read_hexval
    mov bx, cx
    mov al, [bx]
    call std.hex_to_ascii
    mov bx, std.hex_to_ascii.result_with_0x
    call std.printwnl
    jmp terminal.after_command

; Write to memory address
os.commands.writemem:
  .name db "writemem", 0
  .code:
    call std.read_hexval
    mov bx, cx
    call std.read_hexval.single_byte
    mov [bx], cx
    jmp terminal.after_command
