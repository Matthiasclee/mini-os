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
