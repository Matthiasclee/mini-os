[org 0x7c00]

%include "boot/boot.asm"

; Get address from address table
; ALWAYS LOCATED AT 0x7E00
; Arguments:
;   ax: address number
; Returns:
;   ax: address
os.address_table.get_address:
  push cx
  push bx
  mov cx, 2
  mul cx
  mov dx, os.address_table.table
  add dx, ax
  mov bx, dx
  mov ax, [bx]
  pop bx
  pop cx
  ret

entry_point:
mov bx, end_os_space
mov al, 1
mov cl, 11
mov dl, 0x80
mov ch, 0
mov dh, 0
call std.read_from_drive
%include "os/main.asm"

cli
hlt

times (512*10)-($-$$) db 0 ; End OS code

end_os_space:
