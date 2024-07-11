; Check if two strings are equal
; Arguments:
;   bx, cx: addresses of strings to compare, must end in 0x00
; Returns:
;   dh: result (0/1)

std.check_if_equal:
  push ax
  mov dh, 1
  jmp .do_comparison
  .loop_start:
    inc bx
    inc cx
  .do_comparison:
    mov ah, [bx]
    push bx
    mov bx, cx
    mov al, [bx]
    pop bx
    cmp ah, 0
    je .ah_null
    cmp al, 0
    je .al_null
    cmp ah, al
    jne .fail
    jmp .loop_start
  .ah_null:
    cmp al, 0
    je .success
    jmp .fail
  .al_null:
    cmp ah, 0
    je .success
  .fail:
    mov dh, 0
  .success:
    pop ax
    ret
