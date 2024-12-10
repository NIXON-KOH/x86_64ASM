[org 0x7c00] ; Sets starting address to be 0x7c00 (Assembly's default)
mov ah, 0x0e
mov bx, variable

print:
        mov al, [bx]
        inc bx
        cmp al, 0
        je exit  
        int 0x10
        jmp print
exit:   
        jmp $

variable:
        db 'Hello World!', 0
times 510-($-$$) db 0
dw 0xaa55
