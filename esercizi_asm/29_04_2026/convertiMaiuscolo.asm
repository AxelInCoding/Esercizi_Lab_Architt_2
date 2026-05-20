# convertiMaiuscolo.asm
# converte stringa in maiuscolo usando procedura su singolo carattere

.data
str:     .asciiz "aBcXyZ123!mno"   # stringa null-terminated da convertire
newline: .asciiz "\n"              # newline per output

.text
.globl _start                       # entry point globale

############################################################
# ENTRY POINT
############################################################
_start:
    la $a0, str                    # carica indirizzo stringa in $a0
    jal converti                   # chiama funzione conversione

    la $a0, str                    # ricarica stringa per stampa
    li $v0, 4                      # syscall print string
    syscall                        # stampa stringa convertita

    li $v0, 4                      # syscall print string
    la $a0, newline                # carica newline
    syscall                        # stampa newline

    li $v0, 10                     # syscall exit
    syscall                        # termina programma


############################################################
# converti(stringa)
# scorre la stringa e converte ogni carattere
############################################################
converti:
    addi $sp, $sp, -16            # alloca stack frame (16 byte)
    sw   $fp, 0($sp)              # salva frame pointer precedente
    sw   $ra, 4($sp)              # salva return address
    sw   $s0, 8($sp)              # salva registro s0
    sw   $s1, 12($sp)             # salva registro s1

    move $fp, $sp                 # imposta nuovo frame pointer

    move $s0, $a0                 # $s0 = puntatore alla stringa (scorrimento)

############################################################
# loop su ogni carattere della stringa
############################################################
loop:
    lb   $t0, 0($s0)              # carica carattere corrente dalla memoria (estende a 32 bit)
    beq  $t0, $zero, end          # se carattere = '\0' fine stringa

    move $a0, $t0                 # passa carattere a funzione
    jal  converti_singolo         # converte singolo carattere

    sb   $v0, 0($s0)              # riscrive carattere convertito nella stringa

    addi $s0, $s0, 1              # passa al prossimo carattere
    j loop                        # ripeti ciclo


############################################################
# fine conversione stringa
############################################################
end:
    move $sp, $fp                 # ripristina stack pointer al frame base
    lw   $fp, 0($sp)              # ripristina vecchio frame pointer
    lw   $ra, 4($sp)              # ripristina return address
    lw   $s0, 8($sp)              # ripristina s0
    lw   $s1, 12($sp)             # ripristina s1
    addi $sp, $sp, 16             # dealloca stack frame
    jr $ra                        # ritorno alla funzione chiamante


############################################################
# converti_singolo(char)
# converte solo caratteri 'a'–'z' in maiuscolo
############################################################
converti_singolo:
    addi $sp, $sp, -16           # alloca stack frame
    sw   $fp, 0($sp)             # salva fp precedente
    sw   $ra, 4($sp)             # salva return address

    move $fp, $sp                # imposta frame pointer

    move $t0, $a0                # copia carattere in registro temporaneo

    li   $t1, 97                 # ASCII 'a'
    li   $t2, 122                # ASCII 'z'

############################################################
# controllo intervallo alfabetico minuscolo
############################################################
    blt  $t0, $t1, no_change     # se < 'a' non modifica
    bgt  $t0, $t2, no_change     # se > 'z' non modifica

    addi $t0, $t0, -32           # conversione ASCII: minuscolo → maiuscolo

############################################################
# uscita funzione carattere
############################################################
no_change:
    move $v0, $t0                # ritorna carattere (modificato o invariato)

    move $sp, $fp                # ripristina stack pointer
    lw   $fp, 0($sp)             # ripristina frame pointer
    lw   $ra, 4($sp)             # ripristina return address
    addi $sp, $sp, 16            # libera stack frame
    jr $ra                       # ritorno