terminal.ascii:
  .backspace: db 8
  .cr: db 13
  .lf: db 10
  .crlf: db 13, 10, 0

terminal.scancodes:
  .escape: db 1
  .return: db 28
  .backspace: db 14
