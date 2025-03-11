; CF and Number of Sector Failure Detection
; add another sector, simple of CHS addressing

[org 0x7c00]
;mov dl, [BOOT_DISK] 		; Uncomment this to trigger CF error
				                ; Sets dl to a invalid value

mov [BOOT_DISK], dl

; setting up the stack
xor ax, ax
mov es, ax
mov ds, ax
mov bp, 0x8000
mov sp, bp

mov bx, 0x7e00			  ; Buffer to load sector data

; reading the disk
mov ah, 2			        ; BIOS read sector function
mov al, [Sector]	  	; Read 1 sector
mov ch, 0			        ; Cylinder 0
mov dh, 0			        ; Head 0
mov cl, 2		        	; Sector 2 (next sector after boot)
mov dl, [BOOT_DISK]		; Boot disk number
int 0x13

jc disk_error			    ; If CF (carry flag) is set, jump to error handler
				              ; JC = "Jump if Carry"

mov al, [Sector]
mov bl, al
mov ax, 512
mul bl			        	; ax = Total Expected bytes

cmp ax, bx
je sector_mismatch

; printing what is in the next sector (printing the first character)
mov ah, 0x0E		     	; BIOS teletype function
mov al, [bx]		    	; Load first character from sector data
int 0x10		        	; Print the character

jmp $				          ; Infinite loop

; Error handler for disk read failure
disk_error:
    mov ah, 0x0E
    mov al, 'E'			 ; Print 'E' for disk read error
    int 0x10
    jmp $

; Error handler for sector mismatch
sector_mismatch:
    mov ah, 0x0e
    mov al, 'M'			; Print 'M' for mismatch error
    int 0x10
    jmp $

BOOT_DISK: db 0			; Boot disk variable
Sector: db 1			  ; Set Sector to 1
				            ; Change 1 to another number to trigger DiskError

times 510-($-$$) db 0
dw 0xaa55

; Fill Second Sector
times 512 db 'B'
