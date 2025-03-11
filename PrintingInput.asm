[org 0x7x00]

mov si, buffer

type:
        mov ah, 0
        int 0x16
        cmp al, 0x0D    ; Checks if input is enter (Carriage Return)
        je printing
        mov [si], al
        inc si
        jmp type



printing:
        mov byte [si], 0
        mov bx, buffer
        jmp print

print:  
        mov al, [bx]
        inc bx   
        cmp al, 0
        je $    
        mov ah, 0x0E
        int 0x10 
        jmp print

buffer: 
        times 10 db 0

times 510-($-$$) db 0
db 0x55, 0xaa
