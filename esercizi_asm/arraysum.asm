.data
A: .space 60 # array di 15 elementi (15 * 4 byte)
h: .space 4 # variabile h

.text
.globl main

main:
	# INIZIALIZZAZIONE
	la $t0, A
	
	li $t1, 10
	sw $t1, 32($t0) # A[8] = 10 (8 * 4 = 32)
	
	li $t1, 0
	sw $t1, 48($t0) # A[12] = 0 (12 * 4 = 48)
	
	la $t2, h
	li $t3, 5
	sw $t3, 0($t2) #carico all'indirizzo $t2 + 0 l'immediato 5
	
	#CALCOLO
	lw $t3, 0($t2) #carico nel registro $t3 la parola di memoria $t2 + 0 --> h
	lw $t4, 32($t0) #carico nel registro $t4 la parola di memoria $t0 + 32 --> A[8]
	
	add $t5, $t3, $t4 # h + A[8]
	
	sw $t5, 48($t0) #carico all'indirizzo $t0 + 48 il risultato --> A[12]
	
	
	