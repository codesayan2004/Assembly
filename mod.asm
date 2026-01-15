extern scanf
extern printf

section .data
    msg db "Remainder: %d",10,0

section .text
    global main

main:
    mov eax, 70    ; numerator
    xor edx, edx   ; clear high bits before division
    mov ebx, 9     ; denominator
    div ebx        ; eax = quotient, edx = remainder

    push edx
    push msg
    call printf
    add esp, 8

    mov eax, 0
    ret