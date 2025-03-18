# # Encuentra el menor número ingresado por el usuario

.data
    mensaje_cant: .asciiz "Ingrese la cantidad de números a comparar (mínimo 3, máximo 5): "
    mensaje_num: .asciiz "Ingrese un número, que no supere los 9 digitos: "
    mensaje_menor: .asciiz "El número menor es: "
    error_msg: .asciiz "Cantidad inválida. Intente de nuevo.\n"

.text
.globl main

main:
    # Pedir la cantidad de números
validar_cantidad:
    li $v0, 4
    la $a0, mensaje_cant
    syscall

    li $v0, 5
    syscall
    move $t0, $v0  # Guardar cantidad en $t0

    # Verificar que la cantidad esté entre 3 y 5
    li $t1, 3
    li $t2, 5
    blt $t0, $t1, error
    bgt $t0, $t2, error
    j leer_numeros  # Si es válido, ir a leer los números

error:
    li $v0, 4
    la $a0, error_msg
    syscall
    j validar_cantidad  # Pedir la cantidad de nuevo

leer_numeros:
    li $t3, 0  # Índice
    li $t4, 2147483647  # Inicializar el menor con el valor más alto posible

loop_numeros:
    li $v0, 4
    la $a0, mensaje_num
    syscall

    li $v0, 5
    syscall
    move $t5, $v0  # Leer número

    # Comparar con el menor actual
    blt $t5, $t4, actualizar_menor
    j continuar

actualizar_menor:
    move $t4, $t5  # Actualizar el menor

continuar:
    addi $t3, $t3, 1
    blt $t3, $t0, loop_numeros

    # Mostrar el número menor
    li $v0, 4
    la $a0, mensaje_menor
    syscall

    li $v0, 1
    move $a0, $t4
    syscall

    li $v0, 10
    syscall
