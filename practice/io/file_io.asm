bits 32

global start        

extern exit, fopen, fread, printf, fclose
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll

segment data use32 class=data
    file_name db "joke.txt", 0
    file_mode db "r", 0
    file dd 0
    
    LEN equ 255
    buffer resb LEN + 1
    
    printf_format db "%s", 0

segment code use32 class=code
start:
    ; file = fopen(file_name, file_mode)
    push file_mode
    push file_name
    call [fopen] ; eax = file
    add esp, 2 * 4
    mov [file], eax

    ; if (file == 0) { exit(1); }
    cmp eax, 0
    jnz read_start
    push dword 1
    call [exit]
    
read_start:
    ; fread(buffer, 1, LEN, [file])
    push dword [file]
    push dword LEN
    push dword 1
    push buffer
    call [fread]
    add esp, 4 * 4
    
    ; if (fread(...) <= 0) { break; }
    cmp eax, 0
    jle read_end
    
    ; buffer[eax] = 0
    mov dword [buffer + eax], 0
    
    ; printf("%s", buffer)
    push buffer
    push printf_format
    call [printf]
    add esp, 2 * 4

    jmp read_start
read_end:

    push dword [file]
    call [fclose]
    add esp, 1 * 4

    push dword 0
    call [exit]