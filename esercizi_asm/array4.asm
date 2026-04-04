.data #specifica che ciò che segue è il segmento dati
#A: .word 0, 4, 8, 12 #array di 4 elementi inizializzati --> molto più comodo

A: .space 16 #4 elementi * 4 byte(interi)

.text #specifica che ciò che segue è il segmento di testo
.globl main

main:
	la $t0, A #indirizzo base dell'array
	
	li $t1, 0 #salvo il valore 0 
	sw $t1, 0($t0) # salvo il valore 0 all'indirizzo $t0 + 0 --> A[0] 
	
	li $t1, 4 #salvo il valore 4
	sw $t1, 4($t0) # salvo il valore 4 all'indirizzo $t0 + 4 --> A[1]
	
	li $t1, 8 #salvo il valore 8
	sw $t1, 8($t0) # salvo il valore 8 all'inidirizzo $t0 + 8 --> A[2]
	
	li $t1, 12 #salvo il valore 12
	sw $t1, 12($t0) # #salvo il valore 12 all'indirizzo $t0 + 12 --> A[3]
