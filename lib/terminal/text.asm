terminal.text:
  .null: db 0
  .prompt: db 0x0d, 0x0a, "> ", 0
  .bad_command: db "Invalid command", 0
