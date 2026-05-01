.data
msg_in:  .asciiz "Inserisci un intero: "
msg_out: .asciiz "Il pari successivo e': "

.text
.globl main

main:
    
    # INPUT UTENTE
    li $v0, 4
    la $a0, msg_in   #richiesta di inserimento di un intero
    syscall

    li $v0, 5  #inserimento dell'intero da tastiera
    syscall
    move $t0, $v0        # t0 = numero

    
    # CALCOLO: pari successivo
    andi $t1, $t0, 1     # controlla se dispari --> se dispari $t1 = 1, se pari $t1 = 0
    beq $t1, $zero, pari #controllo se tra $t1 e $zero c'è 0, quindi p pari, se è vero
    #allora salta all'etichetta PARI

    addi $t0, $t0, 1     # se dispari -> +1 --> se BEQ non c'è allora sommo 1 al numero dispari
    j stampa 

pari:
    addi $t0, $t0, 2     # se pari -> +2

    # OUTPUT
stampa:
    li $v0, 4
    la $a0, msg_out
    syscall

    move $a0, $t0
    li $v0, 1
    syscall

    # FINE PROGRAMMA
    li $v0, 10
    syscall