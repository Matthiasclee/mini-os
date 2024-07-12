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

; Jump to address from table
os.commands.jumpaddr:
  .name: db "jumpaddr", 0
  .code:
    call std.read_hexval.single_byte
    mov ax, cx
    call os.address_table.get_address
    jmp ax

; Jump to address from table
os.commands.calladdr:
  .name: db "calladdr", 0
  .code:
    call std.read_hexval.single_byte
    mov ax, cx
    call os.address_table.get_address
    call ax
    jmp terminal.after_command
