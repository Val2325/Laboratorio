# LozadaLaura_Fibonacci.asm
.data
    msg1: .asciiz "Ingrese la cantidad de números de Fibonacci: "
    msg2: .asciiz "Serie Fibonacci: "
    msg3: .asciiz "Suma total: "
    space: .asciiz " "
    newline: .asciiz "\n"

.text
.globl main

main:
    # Pedir n
    li $v0, 4          # Cargar servicio de impresión de cadena
    la $a0, msg1       # Cargar dirección de msg1
    syscall            # Imprimir msg1
    li $v0, 5          # Cargar servicio de lectura de entero
    syscall            # Leer n
    move $t0, $v0      # Guardar n en $t0

    # Casos base
    li $t1, 0          # a = 0
    li $t2, 1          # b = 1
    li $t3, 0          # suma = 0
    li $t4, 0          # contador

    # Imprimir mensaje
    li $v0, 4
    la $a0, msg2
    syscall

loop:
    beq $t4, $t0, end_loop # Si contador == n, saltar a end_loop
    # Imprimir a
    li $v0, 1
    move $a0, $t1
    syscall
    li $v0, 4
    la $a0, space
    syscall

    # Sumar a la suma total
    add $t3, $t3, $t1

    # Calcular siguiente término
    add $t5, $t1, $t2  # c = a + b
    move $t1, $t2      # a = b
    move $t2, $t5      # b = c

    addi $t4, $t4, 1   # Incrementar contador
    j loop             # Repetir

end_loop:
    # Imprimir suma
    li $v0, 4
    la $a0, newline
    syscall
    la $a0, msg3
    syscall
    li $v0, 1
    move $a0, $t3
    syscall

    # Terminar programa
    li $v0, 10
    syscall
    