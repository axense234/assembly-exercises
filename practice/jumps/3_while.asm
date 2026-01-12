bits 32

global start        

extern exit
import exit msvcrt.dll

segment data use32 class=data
    LEN equ 3
    numbers times LEN dd 0
    n dd LEN

segment code use32 class=code
start:
    ; #define LEN 3
    ; 
    ; int numbers[LEN];
    ; int n = LEN;
    ; 
    ; while (n > 0) {
    ;     numbers[n - 1] = n;
    ;     --n;
    ; }
    
    while_cond:
        cmp dword [n], 0
        jle while_end
    while_body:
        ; edx = n - 1
        mov edx, [n]
        dec edx
        
        ; numbers[n - 1] = n
        mov eax, [n]
        mov [numbers + edx * 4], eax
        
        dec dword[n]
        jmp while_cond
    while_end:

    push dword 0
    call [exit]