mov ch, 3 ; number of options

jmp selectloop

; text for options
str1_y:
  db "* Option 1", 0x0d, 0x0a, 0
str1_n:
  db "  Option 1", 0x0d, 0x0a, 0

str2_y:
  db "* Option 2", 0x0d, 0x0a, 0
str2_n:
  db "  Option 2", 0x0d, 0x0a, 0

str3_y:
  db "* Option 3", 0x0d, 0x0a, 0
str3_n:
  db "  Option 3", 0x0d, 0x0a, 0

opt_print:

; repeat for any additional options
cmp cl, 1
je opt1

cmp cl, 2
je opt2

cmp cl, 3
je opt3

; repeat for any additional options
opt1:
  mov bx, str1_y
  call print

  mov bx, str2_n
  call print

  mov bx, str3_n
  call print

  ret
opt2:
  mov bx, str1_n
  call print

  mov bx, str2_y
  call print

  mov bx, str3_n
  call print

  ret
opt3:
  mov bx, str1_n
  call print

  mov bx, str2_n
  call print

  mov bx, str3_y
  call print

  ret
