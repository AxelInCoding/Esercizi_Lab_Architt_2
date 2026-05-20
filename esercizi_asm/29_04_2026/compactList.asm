# compactList.asm
# MIPS
# lista compatta con insert in testa e delete con ricompattazione
# uso di $sp e $fp in entrambe le procedure

.data
list:  .space 512        # 128 * 4 byte
HEAD:  .word 0
newline: .asciiz "\n"

.text
.globl _start

############################################################
# ENTRY POINT
############################################################
_start:
    # inserimenti di test
    li $a0, 10
    jal insert

    li $a0, 20
    jal insert

    li $a0, 30
    jal insert

    # delete elemento 20
    li $a0, 20
    jal delete

    # stampa lista risultante
    jal print_list

    li $v0, 10
    syscall


############################################################
# insert(value)
# inserisce in testa (shift a destra)
############################################################
insert:
    addi $sp, $sp, -16
    sw   $fp, 0($sp)
    sw   $ra, 4($sp)
    sw   $s0, 8($sp)
    sw   $s1, 12($sp)

    move $fp, $sp

    move $s0, $a0          # value
    la   $s1, HEAD
    lw   $t0, 0($s1)       # HEAD

    la   $t1, list

    # shift a destra
shift_loop:
    beq  $t0, $zero, insert_head

    sll  $t2, $t0, 2
    add  $t3, $t1, $t2

    lw   $t4, -4($t3)
    sw   $t4, 0($t3)

    addi $t0, $t0, -1
    j shift_loop

insert_head:
    sw   $s0, 0($t1)

    lw   $t0, 0($s1)
    addi $t0, $t0, 1
    sw   $t0, 0($s1)

    move $sp, $fp
    lw   $fp, 0($sp)
    lw   $ra, 4($sp)
    lw   $s0, 8($sp)
    lw   $s1, 12($sp)
    addi $sp, $sp, 16
    jr $ra


############################################################
# delete(value)
# elimina e compatta
############################################################
delete:
    addi $sp, $sp, -16
    sw   $fp, 0($sp)
    sw   $ra, 4($sp)
    sw   $s0, 8($sp)
    sw   $s1, 12($sp)

    move $fp, $sp

    move $s0, $a0          # value da eliminare
    la   $s1, HEAD
    lw   $t0, 0($s1)

    la   $t1, list
    li   $t2, 0

find_loop:
    beq  $t2, $t0, end_delete

    sll  $t3, $t2, 2
    add  $t4, $t1, $t3
    lw   $t5, 0($t4)

    beq  $t5, $s0, shift_left_start

    addi $t2, $t2, 1
    j find_loop


shift_left_start:
    move $t6, $t2

shift_left:
    addi $t7, $t0, -1
    beq  $t6, $t7, shrink

    sll  $t8, $t6, 2
    add  $t9, $t1, $t8

    lw   $t5, 4($t9)
    sw   $t5, 0($t9)

    addi $t6, $t6, 1
    j shift_left


shrink:
    lw   $t0, 0($s1)
    addi $t0, $t0, -1
    sw   $t0, 0($s1)

end_delete:
    move $sp, $fp
    lw   $fp, 0($sp)
    lw   $ra, 4($sp)
    lw   $s0, 8($sp)
    lw   $s1, 12($sp)
    addi $sp, $sp, 16
    jr $ra


############################################################
# print_list
############################################################
print_list:
    addi $sp, $sp, -16
    sw   $fp, 0($sp)
    sw   $ra, 4($sp)

    move $fp, $sp

    la   $t0, HEAD
    lw   $t1, 0($t0)

    la   $t2, list
    li   $t3, 0

print_loop:
    beq  $t3, $t1, print_end

    sll  $t4, $t3, 2
    add  $t5, $t2, $t4
    lw   $a0, 0($t5)

    li   $v0, 1
    syscall

    li   $v0, 4
    la   $a0, newline
    syscall

    addi $t3, $t3, 1
    j print_loop

print_end:
    move $sp, $fp
    lw   $fp, 0($sp)
    lw   $ra, 4($sp)
    addi $sp, $sp, 16
    jr $ra