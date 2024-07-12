; Get address: 0x7E00
os.address_table:
.table:
dw start                                             ; 0x00 - start
dw bootloader                                        ; 0x01 - bootloader
dw bootloader.end                                    ; 0x02 - bootloader end
dw bootloader.loaddrive                              ; 0x03 - load drive flag
dw bootloader.loadsectors                            ; 0x04 - load sectors flag
dw bootloader.ignore_load_failure                    ; 0x05 - ignore load failure flag
dw bootloader.entrypoint                             ; 0x06 - entrypoint flag
dw end_os_space                                      ; 0x07 - end of OS space

dw std.print_with_newline                            ; 0x08 - print with newline
dw std.print                                         ; 0x09 - print
dw std.readchar                                      ; 0x0A - read character
dw std.hex_to_ascii                                  ; 0x0B - convert hex to ascii
dw std.hex_to_ascii.two_bytes                        ; 0x0C - convert hex to ascii (two bytes)
dw std.dumpreg                                       ; 0x0D - print all registers
dw std.cleanreg                                      ; 0x0E - clear all registers
dw std.check_in_range                                ; 0x0F - check value is in range
dw std.check_if_equal                                ; 0x10 - check if values are equal
dw std.read_from_drive                               ; 0x11 - read from drive

dw std.write_to_drive                                ; 0x12 - write to drive
dw std.ascii_to_hex                                  ; 0x13 - convert ascii to hex
dw std.read_hexval                                   ; 0x14 - read hex value from user
dw std.read_hexval.single_byte                       ; 0x15 - read single byte of hex from user

dw std.hex_to_ascii.result                           ; 0x16 - hex to ascii result
dw std.hex_to_ascii.result_with_0x                   ; 0x17 - hex to ascii result (with 0x)
dw std.hex_to_ascii.tb_result                        ; 0x18 - hex to ascii result (two bytes)
dw std.hex_to_ascii.tb_result_with_0x                ; 0x19 - hex to ascii result (with 0x) (two bytes)

dw std.ascii_to_hex.input                            ; 0x1A - ascii to hex input

dw terminal.reset                                    ; 0x1B - reset terminal
dw terminal.after_command                            ; 0x1C - continue after command
