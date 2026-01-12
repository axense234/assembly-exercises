bits 32

global start        

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    numbers dd 1, 2, 3, 4, 5
    LEN equ ($ - numbers) / 4
    printf_format db "%d ", 0

segment code use32 class=code
start:
    ; display(numbers, LEN)
    ; - Arguments get passed on the stack from right to left
    ; - The return value is stored in eax (and optionally in edx)
    ; - All registers are preserved except eax, ecx, edx
    push LEN
    push numbers
    call display
    add esp, 2 * 4
    
    ; ...
    call sum
    
    push printf_format
    call [printf]

    push dword 0
    call [exit]

; void display(int* numbers, int n) { ... }
display:
    ; ----[i][old ebp][return addr][numbers][n]
    ;     ^  ^ -> ebp
    ;     |-----> esp
    ;
    ; Sets up a stack frame
    push ebp
    mov ebp, esp
    
    ; Reserve space for a local variable
    sub esp, 1 * 4
    
    ; [ebp]      - old value of ebp
    ; [ebp + 4]  - return address
    ;
    ; [ebp + 8]  - first param
    ; [ebp + 12] - second param
    ;
    ; [ebp - 4] - i local variable

    ; for (int i = 0; i < n; ++i) { ... }
    for_init:
        mov dword [ebp - 4], 0
    for_cond:
        ; if (i >= n) { break; }
        mov ecx, [ebp - 4]
        cmp ecx, [ebp + 12]
        jge for_end
    for_body:
        ; eax <- numbers[i]
        mov eax, [ebp + 8]
        mov eax, [eax + ecx * 4]
        
        ; printf("%d ", numbers[i])
        push eax
        push printf_format
        call [printf]
        add esp, 2 * 4
    for_post_body:
        inc dword [ebp - 4]
        jmp for_cond
    for_end:
    
    ; Tears down the stack frame
    mov esp, ebp
    pop ebp
    
    ret
