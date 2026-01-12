bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fprintf, fscanf, fclose, fopen
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import fscanf msvcrt.dll


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    fin_name db "primes_input.txt", 0
    fout_name db "primes_output.txt", 0
    
    fscanf_format db "%d", 0
    fprintf_format db "%d", 0
    
    fin_mode db "r", 0
    fout_mode db "w", 0
    
    fin dd 0
    fout dd 0
    
    n dd 0
    d dd 0

; our code starts here
segment code use32 class=code
    start:
        ; open fin
        push fin_mode
        push fin_name
        call [fopen]
        add esp, 2 * 4
        mov [fin], eax
        test eax, eax
        jz exit_program 
        
        ; open fout
        push fout_mode
        push fout_name
        call [fopen]
        add esp, 2 * 4
        mov [fout], eax
        test eax, eax
        jz exit_program
        
        ; read from fin
        push dword n
        push dword fscanf_format
        push dword [fin]
        call [fscanf]
        add esp, 3 * 4
        
        ; write n to fout
        push dword [n]
        push dword fprintf_format
        push dword [fout]
        call [fprintf]
        add esp, 3 * 4
        
        exit_program:
        
        ; close fin and fout
        push dword [fin]
        call [fclose]
        add esp, 1 * 4
        
        push dword [fout]
        call [fclose]
        add esp, 1 * 4
        
        ; exit(1)
        push 1
        call [exit]
        
        
        
        
        
        
        
        
        
        
        
        
