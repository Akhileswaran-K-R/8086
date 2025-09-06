data segment
  opr1 db 0ah,0dh,"Enter first no: $"
  opr2 db 0ah,0dh,"Enter second no: $"
  result db 0ah,0dh,"Result: $"

  num1 dw 0
  num2 dw 0
  temp dw ?
  sum dw ?

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
      mov ah,00h
      sub ax,0030h
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
    mov ax,num
    mov cx,0000h
    mov bx,000ah
    l1: 
      mov dx,0000h
      div bx
      push dx
      inc cx
      cmp ax,0000h
      jg l1
    l2: 
      pop ax
      add ax,0030h
      mov dl,al
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
  display opr1
  read num1
  display opr2
  read num2
  mov ax,num1
  mov bx,num2
  add ax,bx
  mov sum,ax
  display result
  print sum
  mov ah,4ch
  int 21h
code ends
end start