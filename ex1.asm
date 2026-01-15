global _start

section .text

_start:
    mov eax, 13      ; multiplicand
    mov ebx, 13      ; multiplier
    xor ecx, ecx    ; result = 0

mul_loop:
    add ecx, eax    ; result += eax
    dec ebx         ; ebx--
    jnz mul_loop    ; repeat while ebx != 0

    ; RESULT:
    ; ecx = eax * original_ebx

    mov eax, 1      ; sys_exit
    mov ebx, ecx    ; exit status (lower 8 bits)
    int 0x80
