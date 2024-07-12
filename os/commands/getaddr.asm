; Get address from address table

os.commands.getaddr:
  .name: db "getaddr", 0
  .code:
    call std.read_hexval.single_byte
    mov ax, cx
    call os.address_table.get_address
    call std.hex_to_ascii.two_bytes
    mov bx, std.hex_to_ascii.tb_result_with_0x
    call std.printwnl
    jmp terminal.after_command
