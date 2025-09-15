data segment
  menu db 0ah,0dh,0ah,0dh,"1.Addition",0ah,0dh,"2.Subtraction",0ah,0dh,"3.Multiplication",0ah,0dh,"4.Division",0ah,0dh,"5.Exit",0ah,0dh,"Enter a choice",0ah,0dh,"$"
  default db 0ah,0dh,"Wrong choice entered",0ah,0dh,"$"
  opr1 db 0ah,0dh,0ah,0dh,"Enter first no: $"
  opr2 db "Enter second no: $"
  minus db "-$"
  result db 0ah,0dh,"Result: $"

  num1 dw 0
  num2 dw 0
  temp dw ?
  res dw ?

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
  l0:
    display menu
    mov ah,01h
    int 21h
    mov cl,al

    cmp cl,'5'
    jne l6
    mov ah,4ch
    int 21h

    l6:
      display opr1
      read num1
      display opr2
      read num2

      display result
      mov ax,num1
      mov bx,num2

      cmp cl,'1'
      je l1
      cmp cl,'2'
      je l2
      cmp cl,'3'
      je l3
      cmp cl,'4'
      je l4
      display default
      jmp l0

      l1:
        add ax,bx
        jmp l5
      l2:
        sub ax,bx
        jnc l5
        neg ax
        mov bx,ax
        display minus
        mov ax,bx
        jmp l5
      l3:
        mul bx
        jmp l5
      l4:
        mov dx,0
        div bx
      l5:
        mov res,ax
        print res
        mov num1,0
        mov num2,0
        jmp l0
code ends
end start