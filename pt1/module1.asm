bits 32

global _display        
global _printf

segment data use32 class=data
    l_printf_format db "%d < %d", 10, 0
    ge_printf_format db "%d >= %d", 10, 0

segment code use32 class=code
; void display(int *numbers, int numbers_len) {...} -> 
; -> for each number in the array, display whether it is greater that the sum of its predecessors.
_display:
    push ebx

    push ebp
    mov ebp, esp
    
    ; local var pred_sum = [ebp - 4]
    ; numbers = [ebp + 8]
    ; numbers_len = [ebp + 12]
    
    sub esp, 1 * 4
    
    ; pred_sum = 0
    ; for (int i = 0; i < numbers_len; ++i){
    ;   if (numbers[i] >= pred_sum){
    ;       printf(ge_printf_format, numbers[i], pred_sum);
    ;   } else {
    ;       printf(l_printf_format, numbers[i], pred_sum);
    ;   }
    ; }
    
    mov dword [ebp - 4], 0
    
    .for_init:
        xor ecx, ecx
        
    .for_cond:
        cmp ecx, [ebp + 12]
        jge .for_end
    
    .for_body:
        .if_cond:
            mov ebx, [ebp + 8]
            mov ebx, [ebx + ecx * 4]
            cmp ebx, [ebp - 4]
            jl .if_l
            
        .if_ge:
            push dword [ebp - 4]
            push ebx
            push ge_printf_format
            call _printf
            add esp, 3 * 4
        
        .if_l:
            push dword [ebp - 4]
            push ebx
            push l_printf_format
            call _printf
            add esp, 3 * 4
            
    
    .for_post:
        inc ecx
        jmp .for_cond
    
    .for_end:
        pop ebx
        
        mov esp, ebp
        pop ebp
        ret