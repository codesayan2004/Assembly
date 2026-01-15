extern printf 
extern scanf

section .data
    msg1 db "Enter your number ", 0
    fmt_in db "%d", 0
    msg_even db "Even Number ",10, 0
    msg_odd db "Odd Number ",10, 0

section .bss
    n resd 1

section .text
    global main
main:
    push msg1
    call printf
    add esp, 4

    push n
    push fmt_in
    call scanf
    add esp, 8


    mov ecx, [n]
    and ecx, 1
    cmp ecx, 0
    jg odd
    jmp even

even:
    push msg_even
    call printf
    add esp, 4
    jmp end
odd:
    push msg_odd
    call printf
    add esp, 4
    jmp end

end:
    xor eax, eax
    ret

