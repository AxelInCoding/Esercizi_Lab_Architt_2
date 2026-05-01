# file: branch3equal.asm

.text
.globl main

main:
    # esempio valori
    li $s0, 5
    li $s1, 5
    li $s2, 5

    la $s3, equal_label     # primo indirizzo
    la $s4, different_label # secondo indirizzo

    jal branch3equal

    # caso default
    li $v0, 10
    syscall


# -------------------------
# branch3equal
# s0 = x
# s1 = y
# s2 = z
# s3 = indirizzo se tutti uguali
# s4 = indirizzo se tutti diversi
# -------------------------
branch3equal:
    # caso: tutti uguali
    beq $s0, $s1, check_equal_2
    j check_different

check_equal_2:
    beq $s1, $s2, all_equal
    j check_different

all_equal:
    jr $s3        # salto al primo indirizzo

check_different:
    # verifica tutti diversi: x!=y, x!=z, y!=z
    beq $s0, $s1, end_no_jump
    beq $s0, $s2, end_no_jump
    beq $s1, $s2, end_no_jump

    jr $s4        # salto al secondo indirizzo

end_no_jump:
    jr $ra


# -------------------------
# etichette di destinazione
# -------------------------
equal_label:
    # codice caso tutti uguali
    li $v0, 1
    syscall
    j end_program

different_label:
    # codice caso tutti diversi
    li $v0, 1
    syscall
    j end_program

end_program:
    li $v0, 10
    syscall
