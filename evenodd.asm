data segment
  msg1 db 0ah,0dh,"Enter the limit: $"
  msg2 db "Enter the nos: $"
  msg3 db 0ah,0dh,"Even: $"
  msg4 db 0ah,0dh,"Odd: $"
  msg5 db 20h,"$"

  n dw 0
  temp dw 0
  buffer dw 20 dup(0)
  evens dw 20 dup(?)
  odd dw 20 dup(?)
  c1 dw 0
  c2 dw 0

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
  mov si,0
  l1:
    read buffer[si]
    add si,2
    loop l1

  mov si,0
  mov di,0
  mov bp,0
  mov cx,n
  l2:
    mov ax,buffer[si]
    ror ax,1
    jc oddseg
    mov ax,buffer[si]
    mov evens[di],ax
    add di,2
    inc c1
    jmp l3
    oddseg:
      mov ax,buffer[si]
      mov odd[bp],ax
      add bp,2
      inc c2
    l3:
      add si,2
      loop l2

  display msg3
  mov si,offset evens
  l4:
    dec c1
    print [si]
    display msg5
    add si,2
    cmp c1,0
    jg l4

  display msg4
  mov si,offset odd
  l5:
    dec c2  
    print [si]
    display msg5
    add si,2
    cmp c2,0
    jg l5
  
  mov ah,4ch
  int 21h
code ends
end start