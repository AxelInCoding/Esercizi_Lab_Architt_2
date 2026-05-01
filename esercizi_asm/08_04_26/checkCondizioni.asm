.data
msg_in:    .asciiz "Inserisci un intero: "
msg_ok:    .asciiz "Risultato z: "
msg_err:   .asciiz "errore"

.text
.globl main

main:

    # INPUT a
    li $v0, 4
    la $a0, msg_in
    syscall

    li $v0, 5
    syscall
    move $t0, $v0        # t0 = a

    # INPUT b
    li $v0, 4
    la $a0, msg_in
    syscall

    li $v0, 5
    syscall
    move $t1, $v0        # t1 = b

    # INPUT c
    li $v0, 4
    la $a0, msg_in
    syscall

    li $v0, 5
    syscall
    move $t2, $v0        # t2 = c

    # CONDIZIONE: (a >= b)
    slt $t3, $t0, $t1    # t3 = 1 se a < b
    bne $t3, $zero, errore   # se a < b -> errore

    # CONDIZIONE: (c != 0)
    beq $t2, $zero, errore   # se c == 0 -> errore

    # CALCOLO: z = c * (a + b)
    add $t4, $t0, $t1    # t4 = a + b
    mul $t5, $t2, $t4    # t5 = z

    # OUTPUT RISULTATO
    li $v0, 4
    la $a0, msg_ok
    syscall

    move $a0, $t5
    li $v0, 1
    syscall

    j fine

errore:
    li $v0, 4
    la $a0, msg_err
    syscall

fine:
    li $v0, 10
    syscall