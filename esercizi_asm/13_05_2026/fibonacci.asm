.data
msg:    .asciiz "F(n) = "
nl:     .asciiz "\n"

.text
.globl main

# -------------------------
# main
# -------------------------
main:
    # input n (simulato: metti valore in $a0)
    li $a0, 4

    jal fib

    # stampa risultato
    move $t0, $v0

    li $v0, 4
    la $a0, msg
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, nl
    syscall

    li $v0, 10
    syscall


# -------------------------
# int fib(int n)
# -------------------------
fib:
    # PROLOGO: apertura stack frame della funzione
    addi $sp, $sp, -16      # riserva 16 byte sullo stack per salvare registri e variabili locali
    sw $fp, 12($sp)         # salva il frame pointer precedente (il MAIN)
    sw $ra, 8($sp)          # salva indirizzo di ritorno (serve per tornare a main o chiamante)
    sw $a0, 4($sp)          # salva il parametro n perché verrà modificato nelle chiamate ricorsive
    sw $s0, 0($sp)          # salva registro callee-saved usato per mantenere fib(n-1)
    move $fp, $sp           # imposta nuovo frame pointer (base stabile del record di attivazione)

    # caso base: n == 0
    beq $a0, $zero, fib_zero # se n == 0 salta al caso base che restituisce 0

    # caso base: n == 1
    li $t0, 1                # carica costante 1 in registro temporaneo
    beq $a0, $t0, fib_one    # se n == 1 salta al caso base che restituisce 1

    # chiamata ricorsiva fib(n-1)
    lw $a0, 4($fp)           # ricarica n originale dal frame (non da registro volatile)
    addi $a0, $a0, -1        # calcola n-1
    jal fib                  # chiamata ricorsiva: fib(n-1)
    move $s0, $v0            # salva risultato fib(n-1) in $s0 (perché $v0 verrà sovrascritto)

    # chiamata ricorsiva fib(n-2)
    lw $a0, 4($fp)           # ricarica di nuovo n originale dal frame
    addi $a0, $a0, -2        # calcola n-2
    jal fib                  # chiamata ricorsiva: fib(n-2)

    add $v0, $v0, $s0        # somma fib(n-2) + fib(n-1), risultato finale in $v0
    j fib_end                # salta alla chiusura funzione

fib_zero:
    li $v0, 0                # caso base: F(0)=0
    j fib_end                # vai a epilogo

fib_one:
    li $v0, 1                # caso base: F(1)=1

fib_end:
    lw $s0, 0($sp)           # ripristina registro salvato $s0
    lw $ra, 8($sp)           # ripristina indirizzo di ritorno
    lw $fp, 12($sp)          # ripristina frame pointer del chiamante
    addi $sp, $sp, 16        # libera stack frame (annulla allocazione)
    jr $ra                   # ritorna al chiamante usando $ra