bits 32

global _is_sorted     

segment data use32 class=data

segment code use32 class=code
; int is_sorted(int *numbers, int numbers_len) {...}
; checks whether the array is sorted in ascending order
; returns 1 if sorted and 0 otherwise
_is_sorted:
    push ebx
    
    push ebp
    mov ebp, esp

    ; numbers = [ebp + 8]
    ; numbers_len = [ebp + 12]
    
    ; for(int i = 0; i < numbers_len - 1; ++i){
    ;   if (numbers[i] > numbers[i + 1]){
    ;       return 0;
    ;   }
    ; }
    ; return 1;
   
    
    .for_init:
        xor ecx, ecx
    
    .for_cond:
        add dword ecx, 1
        cmp ecx, [ebp + 12]
        sub dword ecx, 1
        jge .for_end
    
    .for_body:
        .if_cond:
            mov ebx, [ebp + 8]
            mov ebx, [ebx + ecx * 4]
            
            mov edx, [ebp + 8]
            mov edx, [edx + ecx * 4 + 4]
           
            cmp ebx, edx
            jg .if_not_sorted
            
        ; continue
        jmp .for_post
        
        .if_not_sorted:
            mov eax, 0
            jmp .clean_up
    
    .for_post:
        inc ecx
        jmp .for_cond
    
    .for_end:
        mov eax, 1
        jmp .clean_up
    
    .clean_up:
        pop ebx
        
        mov esp, ebp
        pop ebp
        ret
    
    
    