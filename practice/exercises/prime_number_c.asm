bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf 
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

; Problem Statement: Check if a given natural number from the console is a prime number in assembly

; int d
; int n

; printf("%s", "Enter a number: ")
; scanf("%d", &n);
; for (d = 2, d <= n / 2, ++d):
    ; if n % d == 0:
        ; printf("%s", n + " " + "is not a prime number.")
        ; exit(1)
; printf("%s", n + " " + "is prime number.")
; exit(1)
    


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    scanf_format db "%d", 0
    
    printf_input_format db "Enter a number: ", 10, 0
    printf_prime_format db "%d is a prime number", 10, 0
    printf_not_prime_format db "%d is not a prime number", 10, 0
    
    testing db "%d", 10, 0
    
    n resw 1
    d dw 0

; our code starts here
segment code use32 class=code
    start:
        ; printf("%s", "Enter a number: ")
        push printf_input_format
        call [printf]
        add esp, 1 * 4
        
        ; scanf("%d", &n);
        push n
        push scanf_format
        call [scanf]
        add esp, 2 * 4
        
        for_init:
            ; d = 2
            mov word [d], 2;
         
        for_cond:
            ; n / 2 = AL
            mov ax, [n]
            mov bl, 2
            div bl
            
            ; d <= n / 2
            cmp [d], al
            jg for_end

        for_body:
            if_cond:
                ; n % d = AH
                mov ax, [n]
                mov bl, [d]
                div bl
                
                ; AH = 0
                cmp ah, 0
                jne if_end
                
            if_true:
                ; printf(printf_not_prime_format, n)
                mov ax, [n]; ax = n
                cwde; ax -> eax
                push eax
                push printf_not_prime_format
                call [printf]
                add esp, 2 * 4
                
                
                ; exit(1)
                push 1
                call [exit]
            
            if_end:
                jmp for_post_body
        
        for_post_body:
            ; ++d
            inc word [d]
            jmp for_cond
        
        for_end:
        
        ; printf(printf_prime_format, n)
        mov ax, [n]; ax = n        
        cwde ; ax -> eax
        push eax       
        push printf_prime_format
        call [printf]
        add esp, 2 * 4
        
        ; exit(1)
        push 1
        call [exit]
        
        
        
        
        
        
        
        
        
        
        
        
