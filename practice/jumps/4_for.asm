bits 32

global start        

extern exit
import exit msvcrt.dll

segment data use32 class=data
    LEN equ 3
    a times LEN dd 0
    b dd 1, 2, 3

segment code use32 class=code
start:
    ; #define LEN 3
    ; 
    ; int a[3] = { 0, 0, 0 };
    ; int b[3] = { 1, 2, 3 };
    ; 
    ; for (int i = 0; i < LEN; ++i) {
    ;     a[i] = b[i] + b[i];
    ; }
    
    for_init:
        mov ecx, 0
    for_cond:
        cmp ecx, LEN
        jge for_end
    for_body:
        mov eax, [b + ecx * 4]
        add eax, eax
        mov [a + ecx * 4], eax
    for_post_body:
        inc ecx
        jmp for_cond
    for_end:

    push dword 0
    call [exit]