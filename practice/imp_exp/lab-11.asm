bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf           ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    numbers dd 1, 2, 3, 4, 5
    LEN equ ($ - numbers) / 4 ; $ = current offset
    printf_format db "%d ", 0

; our code starts here
segment code use32 class=code
    start:
        ; display(numbers, LEN)
        ; sequeling convention:
        ; - arguments get passed on the stack from right to left
        ; - the return value is stored in eax (edx)
        ; - all registers are preserved except eax, ecx, edx
        push LEN
        push numbers
        call display ; eax -> nothing
        add esp, 2 * 4
        
        ; sum(len, numbers)
        push numbers
        push LEN
        call sum
        add esp, 2 * 4
        
        ; printf(printf_format, sum)
        push eax
        push printf_format
        call [printf]
        add esp, 2 * 4
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        
; void display(int * numbers, int n) { ... }
display:
    ; ---------[ret_a][numbers][n]
    ;           ^->esp
    ; [esp] -> ret_a
    ; [esp + x * 4] -> parameters from left to right
    
    push ebp
    mov ebp, esp ; bookmark for vars
    
    ; reserve space for local variable
    ; [esp] - i
    
    sub esp, 1 * 4
    
    ; [ebp] - ret add
    ; [ebp + x * 4] -> parameters from left to right
    
    ; [ebp - 4] -> i local var
    

    ; for (int i = 0; i < n; ++i) {..}
    for_init:
        ; xor ecx, ecx ; clear ecx
        mov dword [ebp - 4], 0
    for_cond:
        mov ecx, [ebp - 4] ; ecx = i
        cmp ecx, [ebp + 12] ; [ebp + 12] = n,
        jge for_end
    for_body:
        ; printf(printf_format, numbers[i]]
        ; eax -> numbers[i]
        mov eax, [ebp + 8]
        mov eax, [eax + ecx * 4]
        
        push eax
        push printf_format
        call [printf]
        add esp, 2 * 4
        

        
    for_post_body:
        inc dword [ebp - 4] ; ++i
        jmp for_cond
    for_end:
    
    mov esp, ebp
    pop ebp
    
    ret

; int sum(int n, int * numbers) { ... }
sum:

    push ebp
    mov ebp, esp ; bookmark for vars
    sub esp, 2 * 4
    
    ; [ebp - 4] -> i
    ; [ebp - 8] -> sum
    
    ; for (int i = 0; i < n; ++i) {..}
    for_init_2:
        ; i = 0, sum = 0
        mov dword [ebp - 4], 0
        mov dword [ebp - 8], 0
    for_cond_2:
        mov ecx, [ebp - 4] ; ecx = i
        cmp ecx, [ebp + 8] ; [ebp + 8] = n,
        jge for_end_2
    for_body_2:
        mov eax, [ebp + 12] ; eax -> numbers
        mov eax, [eax + ecx * 4] ; eax -> numbers[i]
        
        add [ebp - 8], eax ; sum + numbers[i]
        
    for_post_body_2:
        inc dword [ebp - 4] ; ++i
        jmp for_cond_2
    for_end_2:
    
    mov esp, ebp
    
    xor eax, eax
    mov eax, [ebp - 8]
    
    pop ebp
    
    ret
    
    

    
    
    
    
    


    