# Jose Gouveia da Silva Neto
# Luiz Claudio Vieira da Silva Junior
# Mateus Alves dos Santos


.data
menu:       	.asciiz "\n1 - Fahrenheit -> Celsius\n2 - Fibonacci\n3 - Enésimo par\n4 - Sair\nEscolha uma opcao: "
fahrenheit: 	.asciiz "Digite a temperatura em Fahrenheit: "
entrada_int:	.asciiz "Digite o valor de N: "
newline:    	.asciiz "\n"
val1:		.float 32.0
val2:		.float 5.0
val3:		.float 9.0

.text
main:
    li $v0, 4             # syscall para imprimir string
    la $a0, menu          # carregar o endereço da string do menu
    syscall

    li $v0, 5             # syscall para ler um inteiro
    syscall
    move $t0, $v0         # mover o valor lido para $t0

    beq $t0, 1, fahrenheit_to_celsius  # se a opção for 1, ir para fahrenheit_to_celsius
    beq $t0, 2, fibonacci              # se a opção for 2, ir para fibonacci
    beq $t0, 3, enesimo_par            # se a opção for 3, ir para enesimo_par
    beq $t0, 4, saida                  # se a opção for 4, ir para saida
    j main                            # 'loop' para caso não seja escolhido alguma opção repetir o menu

fahrenheit_to_celsius:
    li $v0, 4             # syscall para imprimir string
    la $a0, fahrenheit    # carregar o endereço da string de prompt de fahrenheit
    syscall

    li $v0, 6             # syscall para ler um ponto flutuante
    syscall
    mov.s $f1, $f0        # mover o valor lido para $f1

    la $t1, val1          # carregar o endereço de val1 (32.0) para $t1
    lwc1 $f3, 0($t1)      # carregar val1 em $f3
    sub.s $f1, $f1, $f3   # F - 32
    
    la $t1, val2          # carregar o endereço de val2 (5.0) para $t1
    lwc1 $f3, 0($t1)      # carregar val2 em $f3
    mul.s $f1, $f1, $f3   # (F - 32) * 5
    
    la $t1, val3          # carregar o endereço de val3 (9.0) para $t1
    lwc1 $f3, 0($t1)      # carregar val3 em $f3
    div.s $f1, $f1, $f3   # ((F - 32) * 5) / 9
    
    mov.s $f12, $f1       # mover o resultado para $f12 para impressão

    li $v0, 2             # syscall para imprimir ponto flutuante
    syscall
    
    j main                # voltar ao menu

fibonacci:
    li $v0, 4             # syscall para imprimir string
    la $a0, entrada_int   # carregar o endereço da string para entrada do inteiro
    syscall

    li $v0, 5             # syscall para ler um inteiro
    syscall
    move $t1, $v0         # mover o valor lido para $t1

    li $t2, 0             # F(0) = 0
    li $t3, 1             # F(1) = 1

fibonacci_loop:
    beq $t1, 0, fibonacci_done  # se $t1 (N) for 0, pular para fibonacci_done
    move $t4, $t3         # $t4 = F(N-1)
    add $t3, $t3, $t2     # F(N) = F(N-1) + F(N-2)
    move $t2, $t4         # $t2 = $t4 (F(N-1))
    sub $t1, $t1, 1       # N = N - 1
    j fibonacci_loop      # repetir o loop

fibonacci_done:
    move $a0, $t2         # mover o resultado para $a0 para impressão

    li $v0, 1             # syscall para imprimir inteiro
    syscall
    j main                # voltar ao menu

enesimo_par:
    li $v0, 4             # syscall para imprimir string
    la $a0, entrada_int   # carregar o endereço da string para entrada do inteiro
    syscall

    li $v0, 5             # syscall para ler um inteiro
    syscall
    move $t1, $v0         # mover o valor lido para $t1

    mul $t1, $t1, 2       # Enésimo número par = N * 2
    move $a0, $t1         # mover o resultado para $a0 para impressão

    li $v0, 1             # syscall para imprimir inteiro
    syscall
    j main                # voltar ao menu

saida:
    li $v0, 10            # syscall para sair
    syscall
