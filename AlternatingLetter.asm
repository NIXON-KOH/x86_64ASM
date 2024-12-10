;This code prints the alphabet by alternating Capital and small letter
mov ah, 0x0e ;Sets lower ax to print mode
mov al, 65 ; sets lower ax to ascii 65 (A)
int 0x10 ; Bios Interrupt (syscall)

loop:
        cmp al, 122
        je exit
        inc al 
        cmp al, 91; Check Number
        jg loopcaps ; Even = Small
        jl loopsmall ; Odd = Caps
loopsmall:
        add al, 32
        int 0x10  
        jmp loop
loopcaps:
        sub al, 32
        int 0x10
        jmp loop
exit:
        jmp $
        
times 510-($-$$) db 0
db 0x55, 0xaa
