mov cl, 1

%include "addons/selector/conf.asm"

selectloop:
  call reset
  mov bx, newline
  call print

  call opt_print

continuewithloop:
  call readchar
  mov ah, [scancode]
  cmp ah, 0x48
  je up
  cmp ah, 0x50
  je down
  cmp ah, 28
  je return_pressed
  jmp selectloop
up:
  cmp cl, 1
  je selectloop
  dec cl
  jmp selectloop
down:
  cmp cl, ch
  je selectloop
  inc cl
  jmp selectloop

return_pressed:
  call reset
  mov bx, newline
  call print
  
  cmp cl, 1
  je opt1_sel

  cmp cl, 2
  je opt2_sel

  cmp cl, 3
  je opt3_sel

opt1_sel:
  mov bx, str1_y
  call print
  jmp done

opt2_sel:
  mov bx, str2_y
  call print
  jmp done

opt3_sel:
  mov bx, str3_y
  call print
  jmp done

done:
  jmp continueaftercmd
