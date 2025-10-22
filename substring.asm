data segment
  msg1 db 0ah,0dh,"Enter a string: $"
  msg2 db 0ah,0dh,"Enter the string to find: $"
  msg3 db 0ah,0dh,"Found at $"
  msg4 db 0ah,0dh,"Not Found$"

  str1 db 20,?,20 dup('$')
  str2 db 20,?,20 dup('$')
  pos dw 0

  display macro msg
    lea dx,msg
    mov ah,09h
    int 21h
  endm

  read macro msg
    lea dx,msg
    mov ah,0ah
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
  read str1
  display msg2
  read str2
  mov si,2
  mov di,2
  mov ch,0
  mov cl,str1+1
  l1:
    mov al,str1[si]
    cmp al,str2[di]
    je l2
    inc si
    loop l1
  display msg4
  jmp l5
  l2:
    push si
    mov dl,str2+1
    l3:
      mov al,str1[si]
      cmp al,str2[di]
      jne l4
      inc si
      inc di
      dec dl
      cmp dl,0
      jne l3
    display msg3
    pop si
    dec si
    mov pos,si
    print pos
    jmp l5
    l4:
      pop si
      inc si
      mov di,2
      jmp l1
  l5:
    mov ah,4ch
    int 21h
code ends
end start