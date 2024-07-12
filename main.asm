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

; Call function from address table
; ALWAYS LOCATED AT 0x7E13
; Arguments:
;   ax: address/function number
; Returns:
;   ax: address or result from function
os.address_table.call_address:
  call os.address_table.get_address
  call ax 
  ret

entry_point:
%include "os/main.asm"

hlt

times (512*10)-($-$$) db 0 ; End OS code

end_os_space:
