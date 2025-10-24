data segment
  msg1 db 0ah,0dh,"Enter the limit: $"
  msg2 db "Prime nos: $"
  msg3 db 20h,"$"

  n dw 0
  num dw 0
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
      mov ah,00h
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
    mov ax,num
    mov bx,000ah
    mov cx,0
    l1:
      mov dx,0
      div bx
      push dx
      inc cx
      cmp ax,0
      jne l1
    l2:
      pop dx
      add dl,'0'
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
  mov si,1

  l1:
    inc si
    cmp si,n
    jge l5

    cmp si,2
    je l3
    mov di,2
    l2:
      mov dx,0
      mov ax,si
      div di
      cmp dx,0
      je l4
      inc di
      cmp di,si
      jge l3
      jmp l2
    l3:
      mov num,si
      print num
      display msg3
    l4:
      jmp l1
  l5:
    mov ah,4ch
    int 21h
code ends
end start