.data
msg_in1:   .asciiz "Inserisci primo intero: "
msg_in2:   .asciiz "Inserisci secondo intero: "
msg_op:    .asciiz "Operazione (1:+ 2:- 3:* 4:/): "
msg_res:   .asciiz "Risultato: "
msg_rem:   .asciiz " Resto: "
msg_err:   .asciiz "errore"

.text
.globl main


# MAIN

main:

    # INPUT a
    li $v0, 4
    la $a0, msg_in1
    syscall

    li $v0, 5
    syscall
    move $s0, $v0        # a

    # INPUT b
    li $v0, 4
    la $a0, msg_in2
    syscall

    li $v0, 5
    syscall
    move $s1, $v0        # b

    # INPUT operazione
    li $v0, 4
    la $a0, msg_op
    syscall

    li $v0, 5
    syscall
    move $s2, $v0        # op

    # PASSAGGIO PARAMETRI
    move $a0, $s0
    move $a1, $s1
    move $a2, $s2

    # CHIAMATA
    jal Elaboratore

    # SALVATAGGIO RISULTATI (prima di syscall)
    move $t4, $v0        # risultato
    move $t5, $v1        # resto

    # CONTROLLO ERRORE
    li $t3, -1
    beq $t4, $t3, errore

    # STAMPA "Risultato: "
    li $v0, 4
    la $a0, msg_res
    syscall

    # STAMPA risultato
    move $a0, $t4
    li $v0, 1
    syscall

    # SE divisione stampa resto
    li $t3, 4
    bne $s2, $t3, fine

    li $v0, 4
    la $a0, msg_rem
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



# PROCEDURA Elaboratore

Elaboratore:

    li $t0, 1
    beq $a2, $t0, somma

    li $t0, 2
    beq $a2, $t0, differenza

    li $t0, 3
    beq $a2, $t0, moltiplicazione

    li $t0, 4
    beq $a2, $t0, divisione

    li $v0, -1
    jr $ra

somma:
    add $v0, $a0, $a1
    jr $ra

differenza:
    sub $v0, $a0, $a1
    jr $ra

moltiplicazione:
    mul $v0, $a0, $a1
    jr $ra

divisione:
    beq $a1, $zero, errore_div

    div $a0, $a1
    mflo $v0
    mfhi $v1
    jr $ra

errore_div:
    li $v0, -1
    jr $ra