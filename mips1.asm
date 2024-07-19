.data
menu:       .asciiz "\n1 - Fahrenheit -> Celsius\n2 - Fibonacci\n3 - Enésimo par\n4 - Sair\nEscolha uma opcao: "
fahrenheit: .asciiz "Digite a temperatura em Fahrenheit: "
n_prompt:   .asciiz "Digite o valor de N: "
result:     .asciiz "Resultado: "
newline:    .asciiz "\n"

.text
main:
    li $v0, 4             # syscall para imprimir string
    la $a0, menu          # carregar o endereço da string do menu
    syscall

    li $v0, 5             # syscall para ler um inteiro
    syscall
    move $t0, $v0         # mover o valor lido para $t0

    beq $t0, 1, fahrenheit_to_celsius
    beq $t0, 2, fibonacci
    beq $t0, 3, enesimo_par
    beq $t0, 4, exit
    j main                # caso contrário, repete o menu

fahrenheit_to_celsius:
    li $v0, 4             # syscall para imprimir string
    la $a0, fahrenheit    # carregar o endereço da string de prompt de fahrenheit
    syscall

    li $v0, 5             # syscall para ler um inteiro
    syscall
    move $t1, $v0         # mover o valor lido para $t1

    sub $t1, $t1, 32      # F - 32
    mul $t1, $t1, 5       # (F - 32) * 5
    div $t1, $t1, 9       # ((F - 32) * 5) / 9
    move $a0, $t1         # mover o resultado para $a0 para impressão

    li $v0, 1             # syscall para imprimir inteiro
    syscall
    j main                # voltar ao menu

fibonacci:
    li $v0, 4             # syscall para imprimir string
    la $a0, n_prompt      # carregar o endereço da string de prompt de N
    syscall

    li $v0, 5             # syscall para ler um inteiro
    syscall
    move $t1, $v0         # mover o valor lido para $t1

    li $t2, 0             # F(0) = 0
    li $t3, 1             # F(1) = 1

fibonacci_loop:
    beq $t1, 0, fibonacci_done
    move $t4, $t3         # $t4 = F(N-1)
    add $t3, $t3, $t2     # F(N) = F(N-1) + F(N-2)
    move $t2, $t4         # $t2 = $t4 (F(N-1))
    sub $t1, $t1, 1       # N = N - 1
    j fibonacci_loop

fibonacci_done:
    move $a0, $t2         # mover o resultado para $a0 para impressão

    li $v0, 1             # syscall para imprimir inteiro
    syscall
    j main                # voltar ao menu

enesimo_par:
    li $v0, 4             # syscall para imprimir string
    la $a0, n_prompt      # carregar o endereço da string de prompt de N
    syscall

    li $v0, 5             # syscall para ler um inteiro
    syscall
    move $t1, $v0         # mover o valor lido para $t1

    mul $t1, $t1, 2       # Enésimo número par = N * 2
    move $a0, $t1         # mover o resultado para $a0 para impressão

    li $v0, 1             # syscall para imprimir inteiro
    syscall
    j main                # voltar ao menu

exit:
    li $v0, 10            # syscall para sair
    syscall