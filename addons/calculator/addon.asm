jmp calc_command

%include "addons/calculator/names.asm"
%include "addons/calculator/text.asm"
%include "addons/calculator/code.asm"

calc_command:
  %include "addons/calculator/commands.asm"

