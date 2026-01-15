extern printf
extern scanf

section .data
    msg_size db "Enter the value of n: ", 0
    fmt_in   db "%d", 0
    msg_print db "Numbers from 1 to n are ", 10, 0
    fmt_num  db "%d ", 0
    newline db 10, 0
    
section .bss
    n resd 1              ; int n

section .text
    global main
main:
    push msg_size
    call printf
    add esp, 4

    push n
    push fmt_in
    call scanf
    add esp, 8

    push msg_print
    call printf
    add esp, 4

print:
    mov esi, 1              ; i = 1
loop_print:

    cmp esi, [n]
    jg end_print
    push esi
    push fmt_num
    call printf
    add esp, 8
    inc esi
    jmp loop_print
    
end_print:
    push newline
    call printf
    add esp, 4
    xor eax, eax
    ret
    