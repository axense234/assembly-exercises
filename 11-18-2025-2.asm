bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    scanf_format db "%d", 0
    printf_format db "Sum is %d", 10, 0
    numbers resb 10
    n dd 0
    sum dd 0

    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        while_start:
            mov eax, [n]
            lea eax, [numbers + eax * 4]
        
            ; eax = scanf("%d", &numbers[n])
            ; eax - nr of values read successfully
            ; ctrl+z + enter - stop inputting numbers
            ;
            ; eax, edx, ecx - not preserved
            
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
        
        ; for i = 1, i < n, ++i: sum += numbers[i]
        for_init:
            mov ecx, 0
        
        for_cond:
            cmp ecx, [n]
            jge for_end
        
        for_body:
            mov eax, [numbers + ecx * 4]
            add [sum], eax
        
        for_post_body:
            inc ecx
            jmp for_cond
            
        for_end:
        
        ; printf(printf_format, sum)
        
        push dword [sum]
        push printf_format
        call [printf]
        add esp, 2 * 4
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        
        
        
        