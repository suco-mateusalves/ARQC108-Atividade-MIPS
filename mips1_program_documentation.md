# Documentação do Código MIPS1 - Apenas manipula .integer

## Autores
- Jose Gouveia da Silva Neto
- Luiz Claudio Vieira da Silva Junior
- Mateus Alves dos Santos

## Resumo

Este código MIPS implementa um menu com quatro opções:
1. Converter Fahrenheit para Celsius. 
2. Calcular o enésimo número de Fibonacci.
3. Calcular o enésimo número par.
4. Sair.

## Descrição do Programa

1. **Menu Principal**:
   - Exibe as opções para o usuário.
   - Lê a escolha do usuário.

2. **Conversão Fahrenheit para Celsius**:
   - Lê a temperatura em Fahrenheit.
   - Realiza a conversão usando a fórmula $\( C = \frac{5}{9} \times (F - 32) \)$.
   - Exibe o resultado em Celsius.

3. **Cálculo do N-ésimo termo da sequência de Fibonacci**:
   - Lê o valor de N.
   - Calcula o N-ésimo termo da sequência de Fibonacci.
   - Exibe o resultado.

4. **Cálculo do N-ésimo número par**:
   - Lê o valor de N.
   - Calcula o N-ésimo número par como $\( N \times 2 \)$.
   - Exibe o resultado.

5. **Sair**:
   - Encerra o programa.

## Segmento .data
Definimos strings usadas para prompts e mensagens de menu.

```assembly
.data
menu:       .asciiz "\n1 - Fahrenheit -> Celsius\n2 - Fibonacci\n3 - Enésimo par\n4 - Sair\nEscolha uma opcao: "
fahrenheit: .asciiz "Digite a temperatura em Fahrenheit: "
n_prompt:   .asciiz "Digite o valor de N: "
newline:    .asciiz "\n"
```

## Segmento .text
### Função Principal (`main`)
Mostra o menu, lê a escolha do usuário e direciona para a função correspondente.

```assembly
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
```

### Função `fahrenheit_to_celsius`
Converte temperatura de Fahrenheit para Celsius.

```assembly
fahrenheit_to_celsius:
    li $v0, 4             # syscall para imprimir string
    la $a0, fahrenheit    # carregar o endereço da string de prompt de fahrenheit
    syscall

    li $v0, 5             # syscall para ler um inteiro
    syscall
    move $t1, $v0         # mover o valor lido para $t1

    sub $t1, $t1, 32      # F - 32
    mul $t1, $t1, 5       # (F - 32) * 5
    div $t1, 9            # ((F - 32) * 5) / 9
    mflo $t1              # mover o quociente de $lo para $t1
    move $a0, $t1         # mover o resultado para $a0 para impressão

    li $v0, 1             # syscall para imprimir inteiro
    syscall
    j main                # voltar ao menu
```

### Função `fibonacci`
Calcula o enésimo número de Fibonacci.

```assembly
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
```

### Função `enesimo_par`
Calcula o enésimo número par.

```assembly
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
```

### Função `exit`
Sai do programa.

```assembly
exit:
    li $v0, 10            # syscall para sair
    syscall
```

## Funções e Syscalls Utilizadas

- `li $v0, 4`: Prepara o syscall para imprimir uma string.
- `la $a0, <label>`: Carrega o endereço da string para o registrador `$a0`.
- `syscall`: Realiza a chamada do sistema.
- `li $v0, 5`: Prepara o syscall para ler um inteiro.
- `move $t0, $v0`: Move o valor lido para um registrador temporário.
- `beq $t0, <value>, <label>`: Compara `$t0` com um valor e salta para a etiqueta se forem iguais.
- `j <label>`: Salta para a etiqueta especificada.
- `sub`, `mul`, `div`, `add`, `addi`: Instruções aritméticas para realizar cálculos.
