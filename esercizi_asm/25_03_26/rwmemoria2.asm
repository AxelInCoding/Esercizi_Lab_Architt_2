.data
A: .space 16      # 4 elementi * 4 byte
B: .space 16
c: .space 4

.text
.globl main

main:
    # -------------------------
    # Inizializzazione
    # -------------------------
    la $t0, A

    li $t1, -1
    sw $t1, 0($t0)      # A[0] = -1
    sw $t1, 4($t0)      # A[1] = -1

    li $t1, 1
    sw $t1, 8($t0)      # A[2] = 1

    li $t1, 4
    sw $t1, 12($t0)     # A[3] = 4

    la $t2, B

    li $t1, -1
    sw $t1, 0($t2)      # B[0] = -1

    li $t1, 6
    sw $t1, 4($t2)      # B[1] = 6

    li $t1, -1
    sw $t1, 8($t2)      # B[2] = -1
    sw $t1, 12($t2)     # B[3] = -1

    la $t3, c
    li $t1, 2
    sw $t1, 0($t3)      # c = 2

    # -------------------------
    # Calcolo:
    # A[c-1] = c*(B[A[c]] + c) / A[2*c-1]
    # -------------------------

    lw $t4, 0($t3)          # t4 = c

    # ---- A[c] ----
    sll $t5, $t4, 2         # c*4 --> indice * 4
    add $t6, $t0, $t5       # &A[c] --> indirizzo = base + indice * 4
    lw $t7, 0($t6)          # t7 = A[c]

    # ---- B[A[c]] ----
    sll $t5, $t7, 2         # A[c]*4 --> indice * 4
    add $t6, $t2, $t5       # &B[A[c]] --> indirizzo = base + indice * 4
    lw $t8, 0($t6)          # t8 = B[A[c]]

    # ---- B[A[c]] + c ----
    add $t8, $t8, $t4

    # ---- c * (...) ----
    mul $t8, $t8, $t4

    # ---- 2*c - 1 ----
    sll $t5, $t4, 1         # 2*c
    addi $t5, $t5, -1       # 2*c - 1

    sll $t5, $t5, 2         # offset --> indice * 4
    add $t6, $t0, $t5       # &A[2*c-1] --> iindirizzo = base + indice * 4
    lw $t9, 0($t6)          # t9 = A[2*c-1]

    # ---- divisione ----
    div $t8, $t9
    mflo $t8                # risultato finale

    # ---- c - 1 ----
    addi $t5, $t4, -1
    sll $t5, $t5, 2         # indice * 4 
    add $t6, $t0, $t5       # &A[c-1] --> indirizzo = base + indice * 4

    sw $t8, 0($t6)          # salva risultato

    # fine
    li $v0, 10
    syscall