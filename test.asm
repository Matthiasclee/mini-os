[org 0x9000]
start:
mov bx, text
mov ax, 0x08
call 0x7E00
call ax
ret

text:
db "Hello, World!"
