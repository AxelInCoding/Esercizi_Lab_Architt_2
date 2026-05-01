.data
msgV:       .asciiz "Inserisci V: "
msgN:       .asciiz "Inserisci N: "
msgBreak:   .asciiz "break\n"
msgRes:     .asciiz "Somma = "

.text
.globl main

main:
    # stampa richiesta V
    li $v0, 4
    la $a0, msgV
    syscall

    # leggi V
    li $v0, 5
    syscall
    move $t0, $v0      # $t0 = V

    # stampa richiesta N
    li $v0, 4
    la $a0, msgN
    syscall

    # leggi N
    li $v0, 5
    syscall
    move $t1, $v0      # $t1 = N

    # Sum = V
    move $t2, $t0      # $t2 = Sum

    # i = 1
    li $t3, 1

for_loop:
    # condizione i < N
    bge $t3, $t1, end_for

    # calcola i*i
    mul $t4, $t3, $t3   # $t4 = i*i

    # (i*i) % V
    div $t4, $t0
    mfhi $t5            # resto in $t5

    # if resto == 0 → break
    beq $t5, $zero, break_label

    # Sum += i*i
    add $t2, $t2, $t4

    # i++
    addi $t3, $t3, 1

    j for_loop

break_label:
    # stampa "break"
    li $v0, 4
    la $a0, msgBreak
    syscall

    j end_for

end_for:
    # stampa "Somma = "
    li $v0, 4
    la $a0, msgRes
    syscall

    # stampa risultato
    move $a0, $t2
    li $v0, 1
    syscall

    # termina programma
    li $v0, 10
    syscall