# Documentação do Código MIPS

## Descrição
Este código MIPS implementa um menu com quatro opções:
1. Converter Fahrenheit para Celsius.
2. Calcular o enésimo número de Fibonacci.
3. Calcular o enésimo número par.
4. Sair.

## Segmento .data
Definimos strings usadas para prompts e mensagens de menu, bem como valores de ponto flutuante para a conversão de Fahrenheit para Celsius.

```assembly
.data
menu:       	.asciiz "\n1 - Fahrenheit -> Celsius\n2 - Fibonacci\n3 - Enésimo par\n4 - Sair\nEscolha uma opcao: "
fahrenheit: 	.asciiz "Digite a temperatura em Fahrenheit: "
entrada_int:	.asciiz "Digite o valor de N: "
resultado:     	.asciiz "Resultado: "
newline:    	.asciiz "\n"
val1:		.float 32.0
val2:		.float 5.0
val3:		.float 9.0
```

## Segmento .text
### Função Principal (`main`)
Mostra o menu, lê a escolha do usuário e direciona para a função correspondente.

```assembly
.text
main:
    li $v0, 4             # chamada para imprimir string
    la $a0, menu          # carregar o endereço da string do menu
    syscall

    li $v0, 5             # chamada para ler um inteiro
    syscall
    move $t0, $v0         # mover o valor lido para $t0

    beq $t0, 1, fahrenheit_to_celsius
    beq $t0, 2, fibonacci
    beq $t0, 3, enesimo_par
    beq $t0, 4, saida
    j main                # 'loop' para caso não seja escolhido alguma opção repetir o menu
```

### Função `fahrenheit_to_celsius`
Converte temperatura de Fahrenheit para Celsius.

```assembly
fahrenheit_to_celsius:
    li $v0, 4             # syscall para imprimir string
    la $a0, fahrenheit    # carregar o endereço da string de prompt de fahrenheit
    syscall

    li $v0, 6             # syscall para ler um ponto flutuante
    syscall
    mov.s $f1, $f0        # mover o valor lido para $f1

    la $t1, val1
    lwc1 $f3, 0($t1)
    sub.s $f1, $f1, $f3   # F - 32
    
    la $t1, val2
    lwc1 $f3, 0($t1)
    mul.s $f1, $f1, $f3   # (F - 32) * 5
    
    la $t1, val3
    lwc1 $f3, 0($t1)
    div.s $f1, $f1, $f3   # ((F - 32) * 5) / 9
    
    mov.s $f12, $f1       # mover o resultado para $f12 para impressão

    li $v0, 2             # syscall para imprimir ponto flutuante
    syscall
    
    j main                # voltar ao menu
```

### Função `fibonacci`
Calcula o enésimo número de Fibonacci.

```assembly
fibonacci:
    li $v0, 4             # syscall para imprimir string
    la $a0, entrada_int   # carregar a string para entrada do inteiro
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
```

### Função `enesimo_par`
Calcula o enésimo número par.

```assembly
enesimo_par:
    li $v0, 4             # syscall para imprimir string
    la $a0, entrada_int   # carregar a string para entrada do inteiro
    syscall

    li $v0, 5             # syscall para ler um inteiro
    syscall
    move $t1, $v0         # mover o valor lido para $t1

    mul $t1, $t1, 2       # Enésimo número par = N * 2
    move $a0, $t1         # mover o resultado para $a0 para impressão

    li $v0, 1             # syscall para imprimir inteiro
    syscall
    j main                # voltar ao menu
```

### Função `saida`
Sai do programa.

```assembly
saida:
    li $v0, 10            # syscall para sair
    syscall
```

## Lista de Funções
1. `main`: Função principal que exibe o menu e redireciona para as outras funções.
2. `fahrenheit_to_celsius`: Converte temperatura de Fahrenheit para Celsius.
3. `fibonacci`: Calcula o enésimo número de Fibonacci.
4. `enesimo_par`: Calcula o enésimo número par.
5. `saida`: Sai do programa.

## Lista de Syscalls Utilizadas
1. **li $v0, 4**: Imprimir string (syscall 4)
   - Utilizado em: `main`, `fahrenheit_to_celsius`, `fibonacci`, `enesimo_par`

2. **li $v0, 5**: Ler inteiro (syscall 5)
   - Utilizado em: `main`, `fibonacci`, `enesimo_par`

3. **li $v0, 6**: Ler ponto flutuante (syscall 6)
   - Utilizado em: `fahrenheit_to_celsius`

4. **li $v0, 2**: Imprimir ponto flutuante (syscall 2)
   - Utilizado em: `fahrenheit_to_celsius`

5. **li $v0, 1**: Imprimir inteiro (syscall 1)
   - Utilizado em: `fibonacci`, `enesimo_par`

6. **li $v0, 10**: Sair do programa (syscall 10)
   - Utilizado em: `saida`
