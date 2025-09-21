data segment
  msg1 db 0ah,0dh,"Enter the limit: $"
  msg2 db "Enter the nos: $"
  msg3 db "Sorted array: $"
  msg4 db 20h,"$"

  n dw 0
  array dw 20 dup(0)
  temp dw 0

  display macro msg
    mov dx,offset msg
    mov ah,09h
    int 21h
  endm

  read macro num
    local l1,exit
    mov bx,000ah
    l1:
      mov ah,01h
      int 21h
      cmp al,0dh
      je exit
      cmp al,20h
      je exit
      mov ah,0
      sub ax,'0'
      mov temp,ax
      mov ax,num
      mul bx
      add ax,temp
      mov num,ax
      jmp l1
    exit:
      nop
  endm

  print macro num
    local l1,l2
    mov bx,000ah
    mov ax,num
    mov cx,0
    l1:
      mov dx,0
      div bx
      push dx
      inc cx
      cmp ax,0
      jg l1
    l2:
      pop dx
      add dx,'0'
      mov ah,02h
      int 21h
      loop l2
  endm

data ends

code segment
assume cs:code,ds:data
start:
  mov ax,data
  mov ds,ax
  display msg1
  read n
  display msg2
  mov cx,n
  mov si,offset array
  l1:
    read [si]
    add si,2
    loop l1
  
  mov cx,n
  dec cx
  l2:
    mov bx,n
    dec bx
    mov si,offset array
    l3:
      mov ax,[si]
      cmp ax,[si+2]
      jng l4
      xchg ax,[si+2]
      mov [si],ax
      l4:
        dec bx
        add si,2
        cmp bx,0
        jne l3
    loop l2
  
  display msg3

  mov si,offset array
  mov bx,n
  l5:
    dec bx
    mov n,bx
    print [si]
    display msg4
    add si,2
    mov bx,n
    cmp bx,0
    jg l5
  mov ah,4ch
  int 21h
code ends
end start