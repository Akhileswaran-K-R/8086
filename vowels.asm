data segment
  msg1 db 0ah,0dh,"Enter the string: $"
  msg2 db 0ah,0dh,"Entered string: $"
  msg3 db 0ah,0dh,"Vowels: $"
  msg4 db 0ah,0dh,"No: of vowels: $"

  str1 db 100 dup(?)
  str2 db 100 dup(?)
  vowels db "aAeEiIoOuU$"
  count dw 0

  display macro msg
    lea dx,msg
    mov ah,09h
    int 21h
  endm

  read macro
    mov ah,01h
    int 21h
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
  mov si,offset str1
  mov di,offset str2

  l1:
    read
    cmp al,0dh
    je exit
    mov cx,000ah
    mov bx,offset vowels
    mov [si],al
    inc si
    l2:
      cmp al,[bx]
      je l3
      inc bx
      loop l2
    jmp l1
    l3:
      mov [di],al
      inc di
      inc count
      jmp l1
  exit:
    mov al,'$'
    mov [si],al
    mov [di],al

    display msg2
    display str1
    display msg3
    display str2
    display msg4
    print count

    mov ah,4ch
    int 21h
code ends
end start