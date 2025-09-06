data segment
  msg1 db 0ah,0dh,"Enter the string: $"
  msg2 db "The reverse of the string is: $"
  msg3 db 0ah,0dh,"The string is palindrome$"
  msg4 db 0ah,0dh,"The string is not palindrome$"
  msg5 db 0ah,0dh

  str db 20 dup(?)
  rev db 20 dup(?)

  print macro msg 
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
  mov cx,0000h
  mov si,offset str
  print msg1
  l1:
    read
    mov bl,al
    cmp bl,0dh
    je l0
    mov [si],al
    mov bh,00h
    push bx
    inc si
    inc cl
    jmp l1
  l0:
    mov al,'$'
    mov [si],al
    mov bh,cl
    mov di,offset rev
  l2:
    pop dx
    mov [di],dl
    inc di
    loop l2
  mov al,'$'
  mov [di],al
  print msg2
  print rev
  mov si,offset str
  mov di,offset rev
  mov cl,bh
  l4:
    mov al,[si]
    cmp al,[di]
    jnz l3
    inc si
    inc di
    loop l4
  print msg3
  jmp l5
  l3:
    print msg4
  l5:
    mov ah,4ch
    int 21h
code ends
end start