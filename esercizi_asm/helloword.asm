.data
string: .asciiz "Ciao"
	.align 2
A: .space 8

.text
.globl main

main:
	la $t0, A
	li $t1, 5
	sw $t1, 0($t0)
	