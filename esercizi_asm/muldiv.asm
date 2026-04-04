.data #specifica ciò che segue nel fiile sorgente è il segmento dati

.text #specifica che ciò che segue nel file sorgente è il segmento testo
.globl main

main:
	#inizializzazione valori
	li $s1, 100 #primo operando
	li $s2, 45 #secondo operando
	
	#MOLTIPLICAZIONE
	mult $s1, $s2 #HI/LO = $s1 * $s2
	mflo $s0 #sposto il risultato (parte bassa) in $s0
	
	#DIVISIONE
	div $s1, $s2 #LO = quoziente, HI = resto
	mflo $t0 #quoziente in $t0
	mfhi $t1 #resto in $t1