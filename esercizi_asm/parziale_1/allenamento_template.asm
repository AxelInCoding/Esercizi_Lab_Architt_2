##########################################################
# LAE2 - Esercizi Preparatori al Midterm 1 (TEMPLATE)
##########################################################
.data
    array: .word 15, -3, 8, -12, 0, 25, -1
    len: .word 7
    soglia: .word 5
    msg1: .asciiz "\nEsecuzione Clamp: "
    msg2: .asciiz "\nEsecuzione Soglia: "

.text
.globl main
main:
    # --- Chiamata Procedura 1 ---
    li $v0, 4
    la $a0, msg1
    syscall
    la $a0, array
    lw $a1, len
    jal v_clamp_to_zero

    # --- Chiamata Procedura 2 ---
    li $v0, 4
    la $a0, msg2
    syscall
    la $a0, array
    lw $a1, len
    lw $a2, soglia
    jal v_print_binary_threshold

    # Item 1: Terminazione del programma
    #<<<
    li $v0, 10
    syscall
    #<<< 

##########################################################
v_clamp_to_zero:
    # CODICE GO EQUIVALENTE:
    # func clampToZero(arr []int) {
    #     for i := 0; i < len(arr); i++ {
    #         if arr[i] < 0 {
    #             arr[i] = 0
    #         }
    #     }
    # }
    
    # Mapping: $a0=base arr, $a1=len
    li $t0, 0
loop1:
    bge $t0, $a1, end1
    
    # Item 2 & 3:
    #<<<
    
    # 1. Calcola offset e indirizzo di arr[i]
    sll $t1, $t0, 2 #calcolo dell' offset = i * 4
    add $t2, $a0, $t1 #calcolo dell'nuovo indirizzo = base + offset
    
     # 2. Carica arr[i] in un registro temporaneo
    lw $t3, 0($t2) # arr[i]
  
    # 3. Se arr[i] >= 0, salta al prossimo elemento
    bge $t3, $zero, skip1 
   
    # 4. Sovrascrivi arr[i] con 0 in memoria
    sw $zero, 0($t2)  #arr[i] = 0
    #<<< 
skip1:

    addi $t0, $t0, 1
    j loop1
end1: jr $ra

##########################################################
v_print_binary_threshold:
    # CODICE GO EQUIVALENTE:
    # func printBinaryThreshold(arr []int, threshold int) {
    #     for i := 0; i < len(arr); i++ {
    #         if arr[i] >= threshold {
    #             fmt.Print("1")
    #         } else {
    #             fmt.Print("0")
    #         }
    #     }
    # }
    
    # Mapping: $a0=base arr, $a1=len, $a2=threshold, $t8=backup base
    move $t8, $a0
    li $t0, 0
loop2:
    bge $t0, $a1, end2
    
    # Item 4 & 5:
    #<<<
    # 1. Calcola indirizzo di arr[i] usando il backup $t8
    sll $t1, $t0, 2 #calcolo dell' offset = i * 4
    add $t2, $t8, $t1 #calcolo dell'indirizzo = base + offeset
    
    # 2. Carica valore arr[i]
    lw $t3, 0($t2)
    
    # 3. Se arr[i] < threshold, vai all'etichetta per stampare '0'
    blt $t3, $a2, print0 
    
    # 4. Prepara $a0 con il codice ASCII di '1' (49) e salta alla stampa
    li $a0, 49
    j print
    
    # 5. Etichetta '0': Prepara $a0 con il codice ASCII di '0' (48)
    print0:
    li $a0, 48
    
    # 6. Esegui syscall 11 per stampare
    print:
    li $v0, 11
    syscall
    #<<< 
    
    addi $t0, $t0, 1
    j loop2
end2: jr $ra
