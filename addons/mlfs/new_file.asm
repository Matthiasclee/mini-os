new_file:
  ; Get full length of table
  mov bx, storagespace
  mov ah, 0
  mov al, [bx]
  inc al

  ; Get address of next available position in table
  add bx, ax

  ; Check if table is out of space
  cmp bx, storagespace+81
  je out_of_tablespace

  ; Write new file to table
  mov ah, "A" ; File name
  mov [bx], ah
  inc bx
  mov ah, "B"
  mov [bx], ah
  inc bx
  mov ah, "C"
  mov [bx], ah
  inc bx
  mov ah, 0
  mov [bx], ah
  inc bx

  mov ah, 0xFA ; Location
  mov [bx], ah
  inc bx
  mov ah, 0xAF
  mov [bx], ah
  inc bx

  mov ah, 0xDD ; Length
  mov [bx], ah
  inc bx
  
  mov ah, 0 ; End entry
  mov [bx], ah

  ; Adjust table length
  mov bx, storagespace
  mov ah, [bx]
  add ah, 8
  mov [bx], ah
  

out_of_tablespace:
  ret 
