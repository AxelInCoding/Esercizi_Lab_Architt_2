.data
# nessuna variabile dati necessaria

.text
.globl main

main:
    # -------------------------
    # Inizializzazione stack
    # -------------------------
    addi $sp, $sp, -4      # crea spazio per salvare temporaneo
                           # stack[0] = $s0 temporaneo

    # -------------------------
    # Calcolo 1*3
    # -------------------------
    li $t0, 1
    li $s0, 3

    mult $t0, $s0
    mflo $t0               # t0 = 1*3

    # salva t0 nello stack
    sw $t0, 0($sp)

    # -------------------------
    # Calcolo 2*3
    # -------------------------
    li $t0, 2
    li $s0, 3

    mult $t0, $s0
    mflo $t0               # t0 = 2*3

    # carica 1*3 dallo stack e somma
    lw $s0, 0($sp)         # s0 = 1*3
    add $t0, $t0, $s0      # t0 = 1*3 + 2*3

    # salva temporaneo nello stack
    sw $t0, 0($sp)

    # -------------------------
    # Calcolo 3*3
    # -------------------------
    li $t0, 3
    li $s0, 3

    mult $t0, $s0
    mflo $t0               # t0 = 3*3

    # carica somma precedente dallo stack e somma
    lw $s0, 0($sp)         # s0 = 1*3 + 2*3
    add $t0, $t0, $s0      # t0 = 1*3 + 2*3 + 3*3

    # -------------------------
    # Stampa risultato
    # -------------------------
    move $a0, $t0
    li $v0, 1
    syscall

    # newline
    li $v0, 4
    la $a0, newline
    syscall

    # -------------------------
    # Ripristino stack e termina
    # -------------------------
    addi $sp, $sp, 4
    li $v0, 10
    syscall

.data
newline: .asciiz "\n"