.data #il file sorgente è il segmento dati

.text #specifica che ciò che segue è il segmento di testo
.globl main

main:
	#inizializzazione registri
	li $s1, 1 #B = 1
	li $s2, 2 #C = 2
	li $s3, 3 #D = 3
	li $s4, 4 #E = 4
	
	#calcolo B + C
	add $t0, $s1, $s2
	
	#calcolo D + E
	add $t1, $s3, $s4
	
	#A = (B + C) - (D + E)
	sub $s0, $t0, $t1