storagetext:
  .writer:
    db "Storage Writer -- Press RETURN to save, and ESC to quit", 0x0d, 0x0a, 0
  .print:
    db "Storage Data", 0x0d, 0x0a, 0
  .full:
    db 0x0d, 0x0a, "Storage space full", 0
  .cleared:
    db "Storage cleared", 0
