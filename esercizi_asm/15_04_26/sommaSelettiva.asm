# file: sommaSelettiva.asm

.data
msg_n:   .asciiz "Inserisci N: "
msg_k:   .asciiz "Inserisci k (0=dispari, 1=pari): "
msg_el:  .asciiz "Elemento: "
msg_out: .asciiz "Somma: "

array: .space 400   # max 100 interi

.text
.globl main

main:
    # input N
    li $v0, 4
    la $a0, msg_n
    syscall

    li $v0, 5
    syscall
    move $t0, $v0      # N

    # input k
    li $v0, 4
    la $a0, msg_k
    syscall

    li $v0, 5
    syscall
    move $t1, $v0      # k

    # input array
    la $t2, array
    li $t3, 0

loop_in:
    beq $t3, $t0, fine_in

    li $v0, 4
    la $a0, msg_el
    syscall

    li $v0, 5
    syscall
    sw $v0, 0($t2)

    addi $t2, $t2, 4
    addi $t3, $t3, 1
    j loop_in

fine_in:
    # chiamata P
    move $a0, $t0      # N
    move $a1, $t1      # k
    la $a2, array      # base array
    jal P

    move $t4, $v0      # risultato

    # stampa
    li $v0, 4
    la $a0, msg_out
    syscall

    move $a0, $t4
    li $v0, 1
    syscall

    li $v0, 10
    syscall


# -------------------------
# P
# a0 = N
# a1 = k
# a2 = array
# -------------------------
P:
    li $t0, 0      # i = 0
    li $t1, 0      # somma

loop_P:
    beq $t0, $a0, fine_P

    sll $t2, $t0, 2
    add $t3, $a2, $t2
    lw $t4, 0($t3)

    # controllo parità indice
    andi $t5, $t0, 1   # i % 2

    beq $a1, 0, caso_dispari
    j caso_pari

caso_dispari:
    beq $t5, 0, skip
    add $t1, $t1, $t4
    j skip

caso_pari:
    beq $t5, 1, skip
    add $t1, $t1, $t4

skip:
    addi $t0, $t0, 1
    j loop_P

fine_P:
    move $v0, $t1
    jr $ra