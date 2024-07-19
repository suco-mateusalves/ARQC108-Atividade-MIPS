
# MIPS Assembly Program Documentation

## Arquitetura e Organização de Computadores - Prof. Ivo Calado
### Atividade MIPS

### Programa em MIPS

Este programa realiza as seguintes operações:

1. Converte uma temperatura de Fahrenheit para Celsius.
2. Calcula o enésimo termo da sequência de Fibonacci.
3. Calcula o enésimo número par.
4. Permite ao usuário sair do programa.

### Código

```assembly
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
```

### Descrição do Programa

1. **Menu Principal**:
   - Exibe as opções para o usuário.
   - Lê a escolha do usuário.

2. **Conversão Fahrenheit para Celsius**:
   - Lê a temperatura em Fahrenheit.
   - Realiza a conversão usando a fórmula \( C = \frac{5}{9} \times (F - 32) \).
   - Exibe o resultado em Celsius.

3. **Cálculo do N-ésimo termo da sequência de Fibonacci**:
   - Lê o valor de N.
   - Calcula o N-ésimo termo da sequência de Fibonacci.
   - Exibe o resultado.

4. **Cálculo do N-ésimo número par**:
   - Lê o valor de N.
   - Calcula o N-ésimo número par como \( N \times 2 \).
   - Exibe o resultado.

5. **Sair**:
   - Encerra o programa.

### Observações
- Certifique-se de que a IDE Mars4_5.jar está configurada corretamente para compilar e executar programas em MIPS.
- Teste cada parte do programa individualmente para garantir que funciona conforme o esperado antes de integrá-las.

### Funções e Syscalls Utilizadas

- `li $v0, 4`: Prepara o syscall para imprimir uma string.
- `la $a0, <label>`: Carrega o endereço da string para o registrador `$a0`.
- `syscall`: Realiza a chamada do sistema.
- `li $v0, 5`: Prepara o syscall para ler um inteiro.
- `move $t0, $v0`: Move o valor lido para um registrador temporário.
- `beq $t0, <value>, <label>`: Compara `$t0` com um valor e salta para a etiqueta se forem iguais.
- `j <label>`: Salta para a etiqueta especificada.
- `sub`, `mul`, `div`, `add`, `addi`: Instruções aritméticas para realizar cálculos.
