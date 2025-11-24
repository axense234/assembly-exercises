bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

; Read an unspecified amount of numbers from the keyboard, then display them in reverse order.

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    scanf_format db "%d", 0
    printf_format db "Sum is %d", 10, 0
    numbers resb 10
    n dd 0

; our code starts here
segment code use32 class=code
    start:
        ; read an unspecified amount of numbers from the keyboard
        ; run ctrl+z + enter to stop
        
        ; while True: scanf(scanf_format, &numbers[n]), ++n
        while_start:
            ; eax = &numbers[n]
            mov ebx, [n]
            lea eax, [numbers + ebx * 4]
            
            ; scanf(scanf_format, &numbers[n])
            push eax
            push scanf_format
            call [scanf]
            add esp, 2 * 4
            
            ; if eax > 0
            cmp eax, 0
            jle while_end
            
            
            inc dword [n]
            
            jmp while_start
           
        while_end:
        
        ; display inputted numbers in reverse order
        ; for i = n - 1, i >= 0, --i: printf(printf_format, &numbers[i])
        ; i = n - 1
        for_init:
            mov ecx, [n]
            dec ecx
        
        ; i >= 0,  i = ecx
        for_cond:
            cmp ecx, 0
            jl for_end
        
        ; printf(printf_format, &numbers[i])
        ; eax = &numbers[i]
        for_body:
            push ecx
            mov eax, [numbers + ecx * 4]
        
            push eax
            push printf_format
            call [printf]
            add esp, 2 * 4
            
            pop ecx
        
        ; --i
        for_post_body:
            dec ecx
            jmp for_cond
            
        for_end:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        
        
        
        