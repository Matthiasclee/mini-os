; Check if number is in range (inclusive)
; Arguments:
;   ch: number to check
;   ah: range start
;   al: range end
; Returns:
;   cl: result (0/1)

std.check_in_range:
  mov cl, 1
  cmp ch, ah
  je .success
  ja .greater_than
  jmp .fail
.greater_than:
  cmp ch, al
  ja .fail
  jmp .success
.fail:
  mov cl, 0
.success:
  ret
