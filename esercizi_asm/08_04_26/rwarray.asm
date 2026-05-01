.data

array: .word 10, 21, 32, 43, 54, 65, 76, 87, 98, 109, 120, 131, 142

msgA: .asciiz "Inserisci a: "
msgB: .asciiz "Inserisci b: "
msgC: .asciiz "Inserisci c: "
msgErr: .asciiz "comando non riconosciuto\n"

.text
.globl main

main:

    # ===== input a =====
    li $v0, 4
    la $a0, msgA
    syscall

    li $v0, 5
    syscall
    move $t0, $v0      # a

    # ===== input b =====
    li $v0, 4
    la $a0, msgB
    syscall

    li $v0, 5
    syscall
    move $t1, $v0      # b

    # ===== input c =====
    li $v0, 4
    la $a0, msgC
    syscall

    li $v0, 5
    syscall
    move $t2, $v0      # c

    # base array
    la $t3, array

    # offset a = a * 4
    mul $t4, $t0, 4
    add $t4, $t3, $t4   # &A[a]

    # offset b = b * 4
    mul $t5, $t1, 4
    add $t5, $t3, $t5   # &A[b]

    # ===== controlla c =====

    beq $t2, $zero, swap_case
    li $t6, 1
    beq $t2, $t6, copy_b_a

    li $t6, -1
    beq $t2, $t6, copy_a_b

    # caso default
    li $v0, 4
    la $a0, msgErr
    syscall
    j end

# ===== swap A[a] <-> A[b] =====
swap_case:
    lw $t7, 0($t4)
    lw $t8, 0($t5)

    sw $t8, 0($t4)
    sw $t7, 0($t5)
    j end

# ===== A[b] = A[a] =====
copy_b_a:
    lw $t7, 0($t4)
    sw $t7, 0($t5)
    j end

# ===== A[a] = A[b] =====
copy_a_b:
    lw $t7, 0($t5)
    sw $t7, 0($t4)
    j end

end:
    li $v0, 10
    syscall