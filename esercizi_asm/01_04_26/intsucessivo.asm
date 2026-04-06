.data
msg_in:  .asciiz "Inserisci un intero: "
msg_out: .asciiz "Il successivo e': "

num: .space 4      # variabile input
res: .space 4      # variabile risultato

.text
.globl main

main:
    # -------------------------
    # INPUT UTENTE
    # -------------------------
    li $v0, 4
    la $a0, msg_in
    syscall              # stampa messaggio

    li $v0, 5
    syscall              # legge intero
    move $t0, $v0        # t0 = numero

    # salva num
    la $t1, num
    sw $t0, 0($t1)

    # -------------------------
    # CALCOLO: res = num + 1
    # -------------------------
    la $t1, num
    lw $t2, 0($t1)       # carica num

    addi $t3, $t2, 1     # successivo

    # salva risultato
    la $t4, res
    sw $t3, 0($t4)

    # -------------------------
    # OUTPUT
    # -------------------------
    li $v0, 4
    la $a0, msg_out
    syscall              # stampa messaggio

    # stampa risultato
    la $t4, res
    lw $a0, 0($t4)

    li $v0, 1
    syscall

    # -------------------------
    # FINE PROGRAMMA
    # -------------------------
    li $v0, 10
    syscall