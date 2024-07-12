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
