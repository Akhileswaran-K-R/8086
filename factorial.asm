data segment
  msg1 db 0ah,0dh,"Enter the number: $"
  msg2 db "Factorial: $"

  num dw 0
  fact dw ?
  temp dw ?

  display macro msg
    lea dx,msg
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
      inc cx
      push dx
      cmp ax,0
      jne l1
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
  read num

  mov ax,0001
  mov bx,0002
  l1:
    cmp bx,num
    jg l2
    mul bx
    inc bx
    jmp l1
  l2:
    mov fact,ax
    display msg2
    print fact

  mov ah,4ch
  int 21h
code ends
end start