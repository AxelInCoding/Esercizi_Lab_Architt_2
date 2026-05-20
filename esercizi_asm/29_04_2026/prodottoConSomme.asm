.data
newline: .asciiz "\n"

.text
.globl _start

############################################################
# ENTRY POINT
############################################################
_start:
    jal main  #salta al MAIN

    li $v0, 10      # exit
    syscall


############################################################
# somma(a,b)
############################################################
somma:
    add $v0, $a0, $a1
    jr  $ra


############################################################
# prodotto_s(a,b)
############################################################
prodotto_s:
    addi $sp, $sp, -16  #spazio sull stack (4 variabili = fp, ra, s0,s1) x 4 byte

    sw   $fp, 0($sp) # salva il frame della funzione chiamante (il MAIN)
    sw   $ra, 4($sp) # contiene l’indirizzo dove tornare dopo jr $ra (al MAIN)
    sw   $s0, 8($sp)
    sw   $s1, 12($sp)

    move $fp, $sp  # $fp diventa ancora stabile del frame della funzione corrente

    move $s0, $a0 # s0 = a
    move $s1, $a1 # s1 = b

    beq  $s1, $zero, zero_case  # se b == 0 allora qualsiasi cosa moltiplicata per zero = 0

    move $t0, $zero # accumulatore risultato
    move $t1, $zero # contatore i = 0

loop:
    beq  $t1, $s1, end_loop # fintantochè i < b continua il loop 

    move $a0, $t0 # accumulatore 
    move $a1, $s0 # primo operando a
    jal  somma

    move $t0, $v0 # risultato parziale

    addi $t1, $t1, 1 #aggiornamento di i++
    j loop

end_loop:
    move $v0, $t0 #risultato finale
    j restore

zero_case:
    move $v0, $zero # moltiplicazione per zero

restore:
    move $sp, $fp # si "torna indietro" all'inizio del frame

    lw   $fp, 0($sp) # ripristinail $fp del chiamante
    lw   $ra, 4($sp) # recupera indirizzo di ritorno corretto (il MAIN)
    lw   $s0, 8($sp)
    lw   $s1, 12($sp)

    addi $sp, $sp, 16
    jr   $ra  # salto all'indirizzo contenuto in $ra


############################################################
# MAIN
############################################################
main:
    li $a0, 3
    li $a1, 2
    jal prodotto_s

    # stampa risultato (deve essere 6)
    move $a0, $v0
    li   $v0, 1
    syscall

    # newline
    li $v0, 4
    la $a0, newline
    syscall

    # TERMINAZIONE CORRETTA
    li $v0, 10
    syscall
