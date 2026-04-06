.data
msg_in:  .asciiz "Inserisci un intero: "
msg_out: .asciiz "Hai inserito: "

array: .space 8   # array di 2 interi (4 byte ciascuno)

.text
.globl main

main:
    # -------------------------
    # INPUT UTENTE
    # -------------------------
    li $v0, 4
    la $a0, msg_in
    syscall

    li $v0, 5
    syscall
    move $t0, $v0      # t0 = numero

    # -------------------------
    # CALCOLO SUCCESSIVO
    # -------------------------
    addi $t1, $t0, 1   # t1 = numero + 1

    # -------------------------
    # SALVATAGGIO ARRAY
    # -------------------------
    la $t2, array
    sw $t0, 0($t2)     # array[0] = numero
    sw $t1, 4($t2)     # array[1] = successivo

    # -------------------------
    # OUTPUT
    # -------------------------
    li $v0, 4
    la $a0, msg_out
    syscall

    # stampa array[0]
    lw $a0, 0($t2)
    li $v0, 1
    syscall

    # stampa spazio
    li $a0, 32
    li $v0, 11
    syscall

    # stampa array[1]
    lw $a0, 4($t2)
    li $v0, 1
    syscall

    # newline
    li $a0, 10
    li $v0, 11
    syscall

    # -------------------------
    # FINE
    # -------------------------
    li $v0, 10
    syscall