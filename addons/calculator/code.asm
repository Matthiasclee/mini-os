calculator_addon_command_code:
  mov bx, calculator_addon_text.title
  call print

  call readchar

  current_eq:
    .firstnum
      db 0
    .secondnum
      db 0
    .operation
      db 0

  calc_character:
    times 2 db 0

  mov bx, calc_character
  mov ah, [char]

  mov [bx], ah

  mov bx, calc_character
  call print

  jmp continueaftercmd
