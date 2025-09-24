data segment
  msg1 db 0ah,0dh,"Enter the limit: $"
  msg2 db "Enter the nos: $"
  msg3 db "Enter the search element: $"
  msg4 db 0ah,0dh,"Found at $"
  msg5 db 0ah,0dh,"Not Found$"

  n dw 0
  search dw 0
  temp dw 0
  buffer dw 20 dup(0)

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
  mov si,0
  l1:
    read buffer[si]
    add si,2
    loop l1

  display msg3
  read search
  mov cx,n
  mov si,0
  l2:
    mov ax,buffer[si]
    cmp ax,search
    je l3
    add si,2
    loop l2
  display msg5
  jmp l4
  l3:
    display msg4
    mov dx,0
    mov ax,si
    mov bx,0002h
    div bx
    inc ax
    add al,'0'
    mov dl,al
    mov ah,02h
    int 21h
  l4:
    mov ah,4ch
    int 21h
code ends
end start