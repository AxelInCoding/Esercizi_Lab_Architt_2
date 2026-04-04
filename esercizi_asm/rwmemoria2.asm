.data
A: .space 400     # array A (100 elementi)
B: .space 400     # array B (100 elementi)
c: .space 4       # variabile c

.text
.globl main

main:
    # -------------------------
    # Inizializzazione (valori a piacere)
    # -------------------------
    la $t0, c
    li $t1, 3
    sw $t1, 0($t0)        # c = 3

    la $t2, A
    li $t3, 2
    sw $t3, 12($t2)       # A[3] = 2  (serve per A[c])

    li $t3, 4
    sw $t3, 20($t2)       # A[5] = 4  (serve per A[2c-1])

    la $t4, B
    li $t5, 10
    sw $t5, 8($t4)        # B[2] = 10 (per B[A[c]])

    # -------------------------
    # Calcolo espressione
    # -------------------------

    # carica c
    lw $t1, 0($t0)

    # -------- A[c] --------
    la $t2, A
    sll $t3, $t1, 2       # offset c*4
    add $t6, $t2, $t3
    lw $t7, 0($t6)        # A[c]

    # -------- B[A[c]] --------
    la $t4, B
    sll $t8, $t7, 2
    add $t9, $t4, $t8
    lw $s0, 0($t9)        # B[A[c]]

    # -------- B[A[c]] + c --------
    add $s1, $s0, $t1

    # -------- c * (...) --------
    mul $s2, $s1, $t1

    # -------- A[2c - 1] --------
    sll $s3, $t1, 1       # 2c
    addi $s3, $s3, -1     # 2c - 1
    sll $s4, $s3, 2       # offset
    add $s5, $t2, $s4
    lw $s6, 0($s5)

    # -------- divisione --------
    div $s2, $s6
    mflo $s7              # risultato finale

    # -------- A[c-1] --------
    addi $t3, $t1, -1     # c - 1
    sll $t3, $t3, 2
    add $t6, $t2, $t3

    sw $s7, 0($t6)

    # termina programma
    li $v0, 10
    syscall