new_file:
  ; Get full length of table
  mov bx, storagespace
  mov ah, 0
  mov al, [bx]
  inc al
  push ax
  mov ch, [storagespace]
  cmp ch, 0
  je emptytable

  ; Get location of file
  filesexist:
  mov al, [bx]
  sub al, 3
  mov ah, 0
  mov bx, storagespace
  add bx, ax
  mov ch, [bx]
  inc bx
  mov cl, [bx]
  inc bx
  mov al, [bx]
  add cx, ax
  jmp locationfound
  
  emptytable:
  mov cx, storagespace+82

  locationfound:
  mov bx, storagespace
  pop ax

  ; Get address of next available position in table
  add bx, ax

  ; Check if table is out of space
  cmp bx, storagespace+81
  je out_of_tablespace

  ; Write new file to table
  mov ah, [fname] ; File name
  mov [bx], ah
  inc bx
  mov ah, [fname + 1]
  mov [bx], ah
  inc bx
  mov ah, [fname + 2]
  mov [bx], ah
  inc bx
  mov ah, 0
  mov [bx], ah
  inc bx

  mov [bx], ch ; Location
  inc bx
  mov [bx], cl
  inc bx

  mov ah, [flength]
  mov [bx], ah ; Length
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
