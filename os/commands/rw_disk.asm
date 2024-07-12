; Read from disk

os.commands.readdisk:
  .name: db "readdisk", 0
  .code:
    call os.commands.readdisk.set_registers
    call std.read_from_drive
    call os.commands.readdisk.print_result
    call std.cleanreg

    jmp terminal.after_command

os.commands.readdisk.print_result:
  call std.hex_to_ascii
  mov bx, os.commands.readdisk.text.sectors
  call std.print
  call std.hex_to_ascii
  mov bx, std.hex_to_ascii.result
  call std.printwnl

  mov al, ah
  call std.hex_to_ascii
  mov bx, os.commands.readdisk.text.code
  call std.print
  call std.hex_to_ascii
  mov bx, std.hex_to_ascii.result
  call std.printwnl
  ret
os.commands.readdisk.set_registers:
  mov bx, os.commands.readdisk.text.address
  call std.print
  call std.read_hexval
  push cx ; Pop to BX

  mov bx, os.commands.readdisk.text.sectors
  call std.print
  call std.read_hexval.single_byte
  mov al, cl

  mov bx, os.commands.readdisk.text.sector
  call std.print
  call std.read_hexval.single_byte
  mov ah, cl ; Move to cl

  mov bx, os.commands.readdisk.text.drive
  call std.print
  call std.read_hexval.single_byte
  mov dl, cl

  mov bx, os.commands.readdisk.text.cylinder
  call std.print
  call std.read_hexval.single_byte
  push cx ; Pop to ch

  mov bx, os.commands.readdisk.text.head
  call std.print
  call std.read_hexval.single_byte
  mov dh, cl

  pop cx
  mov ch, cl
  mov cl, ah
  pop bx
  ret
os.commands.readdisk.text:
  .address:
    db "ADDR=", 0
  .sectors:
    db "SECTS=", 0
  .sector:
    db "SECT=", 0
  .drive:
    db "DRIVE=", 0
  .cylinder:
    db "CYL=", 0
  .head:
    db "HEAD=", 0
  .code:
    db "CODE=", 0
