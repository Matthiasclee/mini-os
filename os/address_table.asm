; Get address from address table
; Arguments:
;   ax: address number
; Returns:
;   ax: address

os.address_table.get_address:
push cx
push bx
mov cx, 2
mul cx
mov dx, .table
add dx, ax
mov bx, dx
mov ax, [bx]
pop bx
pop cx
ret

.table:
dw start ; 0x00 - start
dw bootloader ; 0x01 - bootloader
dw bootloader.end ; 0x02 - bootloader end
dw bootloader.loaddrive ; 0x03 - load drive flag
dw bootloader.loadsectors ; 0x04 - load sectors flag
dw bootloader.ignore_load_failure ; 0x05 - ignore load failure flag
dw bootloader.entrypoint ; 0x06 - entrypoint flag

dw std.print_with_newline ; 0x07 - print with newline
dw std.print ; 0x08 - print
dw std.readchar ; 0x09 - read character
dw std.hex_to_ascii ; 0x0A - convert hex to ascii
dw std.hex_to_ascii.two_bytes ; 0x0B - convert hex to ascii (two bytes)
dw std.dumpreg ; 0x0C - print all registers
dw std.cleanreg ; 0x0D - clear all registers
dw std.check_in_range ; 0x0E - check value is in range
dw std.check_if_equal ; 0x0F - check if values are equal
dw std.read_from_drive ; 0x10 - read from drive

dw std.write_to_drive ; 0x11 - write to drive
dw std.ascii_to_hex ; 0x12 - convert ascii to hex
dw std.read_hexval ; 0x13 - read hex value from user
dw std.read_hexval.single_byte ; 0x14 - read single byte of hex from user

dw std.hex_to_ascii.result ; 0x15 - hex to ascii result
dw std.hex_to_ascii.result_with_0x ; 0x16 - hex to ascii result (with 0x)
dw std.hex_to_ascii.tb_result ; 0x17 - hex to ascii result
dw std.hex_to_ascii.tb_result_with_0x ; 0x18 - hex to ascii result (with 0x)
