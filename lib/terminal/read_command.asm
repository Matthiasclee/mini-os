; Read command
; Arguments: none
; Returns:
;   [terminal.cmd_buffer]: command

terminal.read_command:
  call terminal.clear_cmd_buffer
  push dx
  mov dx, terminal.cmd_buffer
  .loop:
  call std.readchar

  push ax
  push cx
  mov ch, al
  mov ah, 32
  mov al, 126
  call std.check_in_range
  cmp cl, 1 ; Character is printable
  pop cx
  pop ax
  je .charpressed

  cmp ah, [terminal.scancodes.return]
  je .done
  cmp ah, [terminal.scancodes.backspace]
  ;je .backspace
  je .ctrl_c
  cmp al, [terminal.ascii.ctrl_c]
  je .ctrl_c
  jmp .loop
.charpressed:
  ; Check if at end of line
  cmp dx, terminal.cmd_buffer_end
  je .loop

  push cx
  push ax

  ; Put character in buffer
  mov bx, dx
  mov [bx], al

  ; Increment buffer length
  inc dx

  ; Print character to screen
  mov ah, 0x0e
  int 0x10

  pop ax
  pop cx
  jmp .loop
.backspace:
  push cx
  push bx

  ; Check if at start of line
  cmp dx, terminal.cmd_buffer
  je terminal.read_command

  ; Remove character from screen
  mov ah, 0x0e
  mov al, [terminal.ascii.backspace]
  int 0x10
  mov al, 0
  int 0x10
  mov al, [terminal.ascii.backspace]
  int 0x10

  ; Remove character from buffer
  dec dx
  mov bx, dx
  mov al, 0x00
  mov [bx], al

  pop bx
  pop cx

  jmp .loop
.ctrl_c:
  pop dx
  push bx
  mov bx, terminal.text.ctrl_c
  call std.printwnl
  call terminal.after_command
  pop bx
  ret
.done:
  pop dx
  push bx
  mov bx, terminal.ascii.crlf
  call std.print
  pop bx
  ret
