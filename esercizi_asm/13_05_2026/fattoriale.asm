# fattoriale.asm
# Calcolo ricorsivo del fattoriale con stack frame ($fp, $sp)

.data
msg: .asciiz "Fattoriale: "

.text
.globl main

# -------------------------
# main
# -------------------------
main:
    li $v0, 5              
    syscall                

    move $a0, $v0          

    jal fattoriale         

    move $t0, $v0          

    li $v0, 4              
    la $a0, msg            
    syscall                

    li $v0, 1             
    move $a0, $t0          
    syscall                

    li $v0, 10             
    syscall


# -------------------------
# fattoriale(n)
# -------------------------
fattoriale:
    addi $sp, $sp, -8      # crea spazio stack frame
    sw $fp, 4($sp)         # salva vecchio frame pointer
    sw $ra, 0($sp)         # salva indirizzo di ritorno
    move $fp, $sp          # aggiorna frame pointer

    # caso base: if (n == 0)
    beq $a0, $zero, base   # se n == 0 vai a base

    # salva n nello stack
    addi $sp, $sp, -4      # spazio per salvare n
    sw $a0, 0($sp)         # salva n

    addi $a0, $a0, -1      # n = n - 1

    jal fattoriale         # chiamata ricorsiva

    lw $t1, 0($sp)         # recupera n originale
    addi $sp, $sp, 4       # ripristina stack

    mul $v0, $t1, $v0      # n * fatt(n-1)
    j epilogo              # vai a chiusura

base:
    li $v0, 1              # fatt(0) = 1

epilogo:
    move $sp, $fp          # ripristina stack pointer
    lw $ra, 0($sp)         # recupera return address
    lw $fp, 4($sp)         # recupera frame pointer
    addi $sp, $sp, 8       # elimina stack frame
    jr $ra                 # ritorno