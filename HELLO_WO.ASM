data segment
str db 0ah,0dh,"Hello World$"
data ends

code segment
assume cs:code,ds:data
start:
        mov ax,data
        mov ds,ax
        mov dx,offset str
        mov ah,09h
        int 21h
        mov ah,4ch
        int 21h
code ends
end start
