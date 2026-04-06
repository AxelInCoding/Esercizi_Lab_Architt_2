.data
prompt_in:    .asciiz "Inserisci un numero intero (NUM): "
prompt_out:   .asciiz "Il nuovo credito e': "
seed:         .word 1234       # seed iniziale per random

.text
.globl main

main:
    # -------------------------
    # INPUT: finestra di dialogo per NUM
    # -------------------------
    li $v0, 5                 # syscall read integer (console)
    syscall
    move $t0, $v0             # $t0 = NUM

    # -------------------------
    # RANDOM: generazione R in [-NUM, NUM]
    # -------------------------
    # calcola range = 2*NUM + 1
    sll $t1, $t0, 1           # t1 = NUM * 2
    addi $t1, $t1, 1          # t1 = 2*NUM + 1

    # setta seed (syscall 40) e genera random (syscall 42)
    lw $a0, seed               # seed iniziale
    li $v0, 40                 # syscall seed random
    syscall

    move $a0, $t1              # max = 2*NUM+1
    li $v0, 42                 # syscall random int in [0,max-1]
    syscall
    move $t2, $v0              # t2 = random in [0, 2*NUM]

    # shift per ottenere [-NUM, NUM]
    sub $t2, $t2, $t0          # t2 = R in [-NUM, NUM]

    # -------------------------
    # Calcolo: RESULT = NUM + R
    # -------------------------
    add $t3, $t0, $t2          # t3 = NUM + R

    # -------------------------
    # OUTPUT: finestra di dialogo con nuovo credito
    # -------------------------
    li $v0, 34                 # syscall print integer in dialog box
    move $a0, $t3
    syscall

    # termina programma
    li $v0, 10
    syscall