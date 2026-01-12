bits 32

global _num_product        

segment code use32 class=code
; int num_product(int *numbers, int LEN) {...} -> returns the product of given numbers
_num_product:
    push ebp
    mov ebp, esp
    push ebx
    
    ; for (int i = 0; i < LEN ; ++i){
    ;   product *= numbers[i];
    ; }
    ; return product;
    
    ; if (LEN < 1) return 0;
    
    .if_empty_cond:
        cmp dword [ebp + 12], 1
        jl .if_empty_body
        
    .for_init:
        mov eax, 1
        mov ecx, 0
    
    .for_cond:
        cmp ecx, [ebp + 12]
        jge .for_end
    
    .for_body:
        mov ebx, [ebp + 8]
        lea ebx, [ebx + ecx * 4]
        imul eax, [ebx] ; eax = eax * ebx
        
    .for_post:
        inc ecx
        jmp .for_cond
    
    .for_end:
        jmp .program_end
    
    .if_empty_body:
        mov eax, 0
        
        pop ebx
        
        mov esp, ebp
        pop ebp
        ret

    
    .program_end:
        pop ebx 
        
        mov esp, ebp
        pop ebp
        ret
    
    
   