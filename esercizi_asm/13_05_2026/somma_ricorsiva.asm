.data
array:  .word 1, 2, 3, 4, 5
dim:    .word 5
msg:    .asciiz "Somma: "

.text
.globl main

# -------------------------
# main
# -------------------------
main:
    la   $a0, array        # a0 = base array
    lw   $a1, dim          # a1 = dimensione

    jal  somma             # somma(array, n)

    move $t0, $v0          # salva risultato

    li $v0, 4              # stampa stringa
    la $a0, msg
    syscall

    li $v0, 1              # stampa intero
    move $a0, $t0
    syscall

    li $v0, 10
    syscall


# -------------------------
# int somma(int* A, int n)
# -------------------------
somma:
    addi $sp, $sp, -8      # alloca stack frame (8 byte) per salvare $ra e $fp
    sw   $ra, 4($sp)       # salva indirizzo di ritorno della funzione chiamante (il MAIN)
    sw   $fp, 0($sp)       # salva frame pointer precedente (il MAIN)
    move $fp, $sp          # aggiorna frame pointer al nuovo frame (funzione corrente)

    beq  $a1, $zero, base  # se n == 0 salta al caso base (somma = 0)

    addi $sp, $sp, -8      # crea spazio temporaneo per salvare parametri correnti
    sw   $a0, 4($sp)       # salva indirizzo base array A
    sw   $a1, 0($sp)       # salva valore n corrente

    addi $a1, $a1, -1      # riduce n: prepara chiamata ricorsiva somma(A, n-1)
    jal  somma             # chiamata ricorsiva

    lw   $a0, 4($sp)       # ripristina indirizzo array A
    lw   $a1, 0($sp)       # ripristina n originale
    addi $sp, $sp, 8      # libera spazio temporaneo dei parametri

    addi $t0, $a1, -1      # calcola indice n-1 (ultimo elemento considerato)
    sll  $t0, $t0, 2       # moltiplica indice per 4 (byte offset di word)
    add  $t0, $a0, $t0     # calcola indirizzo di A[n-1]
    lw   $t0, 0($t0)       # carica valore A[n-1]

    add  $v0, $v0, $t0     # somma risultato ricorsivo + elemento corrente
    j epilogo              # salto all’epilogo della funzione

base:
    li $v0, 0              # caso base: somma di 0 elementi = 0

epilogo:
    move $sp, $fp          # ripristina stack pointer al frame corrente
    lw   $fp, 0($sp)       # ripristina frame pointer precedente
    lw   $ra, 4($sp)       # ripristina indirizzo di ritorno
    addi $sp, $sp, 8      # dealloca stack frame corrente
    jr   $ra               # ritorna alla funzione chiamante