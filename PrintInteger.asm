;Print Integer
[org 0x7c00]

mov ax, [variable]
mov bp, 0x8000
mov sp, bp

loop:
        mov ah, 0
        mov bl, 10
        div bl ;divide ax by 10, ah:r, al:q

        mov bh, ah
        push bx ;push r into stack

        movzx ax, al ;new ax = q

        cmp al, 0 ;if q = 0
        je print
        jmp loop
print:
        pop bx ;pop stack into bx
        mov ah, 0x0e ;print setting
        mov al, bh
        add al, 48 ;offset for ASCII
        int 0x10 ;Bios interrupt to print

        cmp sp, bp ;Check if stack pointer == base pointer (same = stack empty)
        je exit
        jmp print

variable:
        db 48

exit:
    jmp $

times 510-($-$$) db 0
db 0x55, 0xaa
