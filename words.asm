data segment
  msg1 db 0ah,0dh,"Enter the string: $"
  msg2 db 0ah,0dh,"Entered string: $"
  msg3 db 0ah,0dh,"No: of words: $"

  str db 20 dup(?)

  display macro msg
    lea dx,msg
    mov ah,09h
    int 21h
  endm

  read macro
    mov ah,01h
    int 21h
  endm
data ends

code segment
assume cs:code,ds:data
start:
  mov ax,data
  mov ds,ax
  display msg1
  mov si,offset str
  mov cx,1

  l1:
    read
    cmp al,0dh
    je exit
    cmp al,20h
    jne l2
    inc cl
    l2:
      mov [si],al
      inc si
      jmp l1
  exit:
    mov al,'$'
    mov [si],al
    display msg2
    display str
    display msg3
    mov ax,cx
    add ax,'0'
    mov dl,al
    mov ah,02h
    int 21h
    mov ah,4ch
    int 21h
code ends
end start