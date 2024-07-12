; OS commands
; Format:
;   mov bx, command_name
;   call commands.check_if_command_equal
;   je command_code

mov bx, os.commands.clear.name
call commands.check_if_command_equal
je os.commands.clear.code

mov bx, os.commands.reset.name
call commands.check_if_command_equal
je os.commands.reset.code

mov bx, os.commands.dumpreg.name
call commands.check_if_command_equal
je os.commands.dumpreg.code

mov bx, os.commands.jump.name
call commands.check_if_command_equal
je os.commands.jump.code
