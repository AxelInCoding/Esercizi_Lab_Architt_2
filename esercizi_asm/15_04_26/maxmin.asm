.data
msg_max: .asciiz "Max: "
msg_min: .asciiz "Min: "

# array statico (numeri inseriti a mano)
array: .word 12, 7, 25, 3, 18, -4, 9
N:     .word 7

.text
.globl main

main:
    # carica N
    lw $t0, N          # N

    # chiamata max
    move $a0, $t0
    la $a1, array
    jal max
    move $s0, $v0

    # chiamata min
    move $a0, $t0
    la $a1, array
    jal min
    move $s1, $v0

    # stampa max
    li $v0, 4
    la $a0, msg_max
    syscall

    move $a0, $s0
    li $v0, 1
    syscall

    # stampa newline
    li $v0, 11
    li $a0, 10
    syscall

    # stampa min
    li $v0, 4
    la $a0, msg_min
    syscall

    move $a0, $s1
    li $v0, 1
    syscall

    # exit
    li $v0, 10
    syscall


# -------------------------
# MAX
# -------------------------
max:
    lw $t0, 0($a1)
    li $t1, 1

loop_max:
    beq $t1, $a0, fine_max  #se i == N allora fine del ciclo

    sll $t2, $t1, 2   #calcolo dell' offeset i * 4
    add $t3, $a1, $t2   #calcolo dell'indirizzo = base + offeset
    lw $t4, 0($t3)   #carico valore in A[i]

    ble $t4, $t0, skip_max   #se A[i] <= max attuale 
    move $t0, $t4   #trovato il nuovo massimo

skip_max:
    addi $t1, $t1, 1  #aggiornamento di i++
    j loop_max

fine_max:
    move $v0, $t0
    jr $ra


# -------------------------
# MIN
# -------------------------
min:
    lw $t0, 0($a1)
    li $t1, 1

loop_min:
    beq $t1, $a0, fine_min #se i == N fine allora fine del ciclo

    sll $t2, $t1, 2  #calcolo offset i * 4
    add $t3, $a1, $t2 #calcolo dell'indirizzo = base + offeset
    lw $t4, 0($t3)  #carico valore in A[i]

    bge $t4, $t0, skip_min  #se A[i] >= min attuale
    move $t0, $t4  #trovato il nuovo minimo

skip_min:
    addi $t1, $t1, 1  #aggiornamento di i++
    j loop_min

fine_min:
    move $v0, $t0
    jr $ra