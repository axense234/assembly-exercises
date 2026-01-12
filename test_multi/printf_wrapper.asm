bits 32

global start        

extern exit, printf_wrapper
import exit msvcrt.dll

segment data use32 class=data
    numbers dd 2, 4, 6, 8, 10
    LEN equ ($ - numbers) / 4
    printf_format db "%d", 0
    
segment code use32 class=code
    start:
    
        ; for (int i = 0; i < LEN; ++i){
        ;   printf_wrapper(printf_format, numbers[i]);
        ; }
        
        .for_init:
            mov ecx, 0
        
        .for_cond:
            cmp ecx, LEN
            jge .for_end
        
        .for_body:
            push ecx
            
            push dword [numbers + ecx * 4]
            push printf_format
            call printf_wrapper
            add esp, 2 * 4
            
            pop ecx
     
        .for_post:
            inc ecx
            jmp .for_cond
        
        .for_end:
    
        
        push    dword 0      
        call    [exit]