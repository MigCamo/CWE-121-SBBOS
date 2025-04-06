section .text                   ; segmento TEXT 
global _start                   ; punto de entrada del ELF 
 
_start: 
 
    jmp short dummy             ; 1. salto a un dummy con el call 
 
imprimir_str:                   ; 3. syscall write() 
        pop ecx                 ; ecx => "you win C A M O !A" 
        mov al,4                ; syscall write: #4 
        xor ebx,ebx             ; ebx = 0 
        inc ebx                 ; stdout filedescriptor: #1 
        xor edx,edx             ; edx = 0 
        mov dl,19                ; longitud "you win C A M O !\0": 19 
        int 0x80                ; write(1, string, 19) 
    
        mov al,1                ; syscall exit: #1 
        dec ebx                 ; ebx = 0 
        int 0x80                ; exit(0) 
    
dummy:                          ;  
        call imprimir_str       ; 2. llamo al código encargado de imprimir el mensaje 
        db 'you win C A M O !', 0x0b     ; antes de saltar apila dirección de "you win!\v" 
                                ; para retornar luego del call 