bits 32

global start        

extern exit
import exit msvcrt.dll

segment data use32 class=data
    result dd 0
    n dd 5

segment code use32 class=code
start:
    ; int result = 0;
    ; int n = 5;
    ; 
    ; if (n < 0) {
    ;     result = -1;
    ; }
    
    if_cond:
        cmp dword [n], 0
        jge if_end
    if_cond_true:
        mov dword [result], -1
    if_end:

    push dword 0
    call [exit]