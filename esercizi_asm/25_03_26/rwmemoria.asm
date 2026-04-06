.data
A: .space 400     # 100 elementi * 4 byte
B: .space 400     # 100 elementi * 4 byte
C: .space 4       # variabile C
i: .space 4       # variabile i

.text
.globl main

main:
    # -------------------------
    # Inizializzazione dati
    # -------------------------
    la $t0, i
    li $t1, 3
    sw $t1, 0($t0)        # i = 3

    la $t0, C
    li $t1, 2
    sw $t1, 0($t0)        # C = 2

    # B[i] = 10
    la $t2, B             # base di B
    li $t3, 3             # i = 3
    sll $t4, $t3, 2       # offset = i * 4
    add $t5, $t2, $t4     # indirizzo B[i]
    li $t6, 10
    sw $t6, 0($t5)        # B[3] = 10

    # -------------------------
    # Calcolo: A[99] = 5 + B[i] + C
    # -------------------------
    # carica i
    la $t0, i
    lw $t1, 0($t0)

    # calcola indirizzo B[i] --> FORMULA: indirizzo = base + (indice * 4)
    la $t2, B
    sll $t3, $t1, 2
    add $t4, $t2, $t3
    lw $t5, 0($t4)        # B[i]

    # carica C
    la $t6, C
    lw $t7, 0($t6)

    # somma: 5 + B[i] + C
    li $t8, 5
    add $t9, $t5, $t7
    add $t9, $t9, $t8

    # salva in A[99]
    la $s0, A
    li $s1, 99
    sll $s2, $s1, 2       # offset = 99 * 4 = 396
    add $s3, $s0, $s2     # A[99] = base + (indice * 4)
    sw $t9, 0($s3)        # all'indirizzo di A[99] carica il risultato

    # termina programma
    li $v0, 10
    syscall
