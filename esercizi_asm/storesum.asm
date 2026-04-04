.data #specifica che ciò che segue nel file sorgente è il segmento dati

.text #specifica che ciò che segue nel file sorgente  è il segmento testo
.globl main

main:
	li $s1, 5 #carica nel registro $s1 il valore 5
	li $s2, 7 #carica nel registro $s2 il valore 7
	add $s0, $s1, $s2 #sommo $s1 e $s2 salvandoli in $s0