---
title: "Fortran 77"
---

# Fortran 77

## Sumário

- [Introdução](#introdução)
- [Básico](#básico)
- [Variáveis, Tipos e Declarações](#variáveis-tipos-e-declarações)
- [Expressões e Atribuições](#expressões-e-atribuições)
- [Operadores Lógicos e Condicionais](#operadores-lógicos-e-condicionais)
- [Loops](#loops)
- [Subprogramas](#subprogramas)
- [Arrays](#arrays)
- [Common Blocks](#common-blocks)
- [Data e Block Statements](#data-e-block-statements)
- [File I.O.](#file-io)
- [Format](#format)
- [Bibliotecas](#bibliotecas)
- [Exercícios Práticos](#exercícios-práticos)
- [Recursos Adicionais](#recursos-adicionais)

## Introdução

Aqui vamos abordar várias particularidades da versão 77. Sua leitura fica a critério da curiosidade ou da necessidade do leitor.

### Pré-requisitos
- Conhecimento básico de programação
- Editor de texto simples
- Compilador Fortran (gfortran recomendado)

### Limitações do Fortran 77
- Formatação rígida baseada em colunas
- Nomes de variáveis limitados a 6 caracteres
- Sem recursão
- Sem alocação dinâmica de memória
- Sem ponteiros

Este material foi fortemente inspirado no guia de Stanford para F77, disponível em [Stanford ME200C Tutorial](https://web.stanford.edu/class/me200c/tutorial_77/03_basics.html).

## Básico

### Estrutura do Programa

A estrutura principal do código F77 é da forma:

```fortran
c234567	
      program *nome*
      
      *declarações de variáveis*
      
      *comandos*
      
      stop
      end
```

### Formatação de Colunas

A formatação da versão 77 é rígida, seguindo um padrão ditado pelo número referente à coluna no editor de texto, da seguinte forma:

| Coluna | Uso | Descrição |
|--------|-----|-----------|
| 1 | Vazia ou "c" ou "*" | Comentário (opcional) |
| 1-5 | Número de label | Categoria da declaração da linha |
| 6 | Qualquer caractere | Continuação da linha prévia (opcional) |
| 7-72 | Código | Comando principal |
| 73-80 | Número | Número de sequência (uso incomum) |

**Exemplo Visual da Formatação:**
```
c2345678901234567890123456789012345678901234567890123456789012345678901234567890
      program hello
      implicit none
      integer i
      i = 1
      write(*,*) 'Hello World'
      stop
      end
```

> **⚠️ Importante:** Não podemos ter uma variável com o mesmo nome que o programa.

### Primeiro Programa

```fortran
c234567
      PROGRAM HELLO
      IMPLICIT NONE
      WRITE(UNIT=*, FMT=*) 'Hello World'
      STOP
      END
```
*exemplo 1: Hello World. Note que os comandos começam a partir da coluna 7*

> **💡 Dica:** O comando `write(UNIT=*, FMT=*)` também pode ser escrito como `write(*,*)`, o que é uma simplificação usual na atribuição desses argumentos compulsórios.

## Variáveis, Tipos e Declarações

### Regras de Nomenclatura

Variáveis em Fortran consistem em no máximo **6 caracteres** alfanuméricos, iniciando com uma letra, sem diferenciar maiúsculas e minúsculas. 

**Regras importantes:**
- Máximo de 6 caracteres
- Deve começar com uma letra (A-Z)
- Pode conter letras e números
- Não diferencia maiúsculas/minúsculas (`VAR`, `var`, `Var` são iguais)
- Palavras reservadas não podem ser usadas como nomes

**Palavras reservadas:** `program`, `real`, `stop`, `end`, `integer`, `character`, `logical`, `complex`, `double`, `precision`, `parameter`, `data`, `common`, `dimension`, `external`, `intrinsic`, `save`, `goto`, `if`, `then`, `else`, `endif`, `do`, `continue`, `call`, `return`, `function`, `subroutine`, `write`, `read`, `print`, `format`, `open`, `close`, `backspace`, `rewind`, `endfile`

### Tipos de Dados

Toda variável deve ser definida em uma declaração que estabelece seu tipo. Aqui está uma tabela comparativa:

| Tipo | Descrição | Tamanho | Faixa/Exemplo | Uso |
|------|-----------|---------|---------------|-----|
| `integer` | Números inteiros | 32 bits | ±2×10⁹ | Contadores, índices |
| `real` | Números reais (precisão simples) | 4 bytes | ~7 dígitos | Cálculos científicos |
| `double precision` | Números reais (precisão dupla) | 8 bytes | ~15 dígitos | Cálculos de alta precisão |
| `complex` | Números complexos | 8 bytes | (a, b) onde a,b são reais | Matemática complexa |
| `logical` | Valores lógicos | 4 bytes | `.TRUE.` ou `.FALSE.` | Condições |
| `character` | Caracteres/texto | Variável | `'texto'` | Strings |

### Declarações de Variáveis

```fortran
c234567
      integer i, j, k
      real x, y, z
      double precision pi
      complex c1, c2
      logical flag
      character*10 nome
      character*1 letra
```

### Boas Práticas

Embora o Fortran utilize regras implícitas se a variável não for declarada, é **boa prática** usar `implicit none` para evitar ambiguidades e forçar a declaração de todas as variáveis.

**Regras implícitas (evitar usar):**
- Variáveis começando com I-N são `integer`
- Outras variáveis são `real`

### Constantes (PARAMETER)

Para definir constantes, declara-se um parâmetro na sintaxe:

```fortran
      parameter (name = constant, ..., name = constant)
```

O parâmetro deve ser definido antes da primeira execução do código.

```fortran
c234567
      PROGRAM TYPES
      IMPLICIT NONE
      
      ! Determina a declaração do tipo de variáveis
      INTEGER alfa, beta, delta
      
      PARAMETER (alfa = 5, beta = 10)
      
      delta = alfa + beta
      write (*,*) 'Resulta em', delta
      
      STOP
      END
```
*exemplo 2: tipagem*

## Expressões e Atribuições

### Expressões

Uma expressão é uma combinação de operandos e operadores, como em `x + y` (onde `x` e `y` são operandos e `+` é o operador). O resultado de uma expressão torna-se um novo operando, permitindo *nesting* (expressões aninhadas).

Existem constantes de seis tipos: integer, real, double precision, complex, logical e character.  
- O uso de `E` em um valor, como `2.0E6`, implica que o valor anterior à `E` deve ser multiplicado por 10 elevado ao número à direita de `E` (ou seja, `2.0E6 = 2 * 10^6`).
- Valores complexos são expressos como um par de constantes (por exemplo, `(2, -3)` ou `(1., 9.9E-1)`), onde o primeiro é a parte real e o segundo a parte imaginária.
- Constantes lógicas são expressas como `.True.` ou `.False.` (os pontos são obrigatórios).
- Constantes de caractere, ou strings, são delimitadas por aspas simples (ex.: `'ABC'`, `'potato potato'`) e são sensíveis a maiúsculas e minúsculas.

### Atribuições

A sintaxe para atribuições é:

```
nome_da_variavel = expressão
```

O valor da expressão à direita é avaliado e atribuído à variável à esquerda.

### Conversão de Tipos

Quando diferentes tipos de dados são usados em uma expressão, pode ocorrer conversão implícita ou é necessário forçar a conversão usando funções como:
- `int` (para converter para integer)
- `real` (para converter para real)
- `dble` (para converter para double precision)
- `ichar` (converte caractere em inteiro)
- `char` (converte inteiro em caractere)

Note que `w = dble(x) * dble(y)` difere de `w = dble(x*y)` para variáveis reais `x` e `y`.

## Operadores Lógicos e Condicionais

### Operadores Lógicos

Para comparar expressões, utilizamos operadores relacionais que avaliam como `.True.` ou `.False.`:

- `.LT.` : "menor que" (equivalente a `<`)
- `.GT.` : "maior que" (equivalente a `>`)
- `.LE.` : "menor ou igual" (equivalente a `<=`)
- `.GE.` : "maior ou igual" (equivalente a `>=`)
- `.EQ.` : "igual" (equivalente a `=`)
- `.NQ.` : "diferente" (equivalente a `!=`)

Outros termos úteis são:
- `.AND.`
- `.OR.`
- `.NOT.`

### Condicionais

Condições são estruturadas de três maneiras:

1. **Condição em linha única:**  
   Se a condição lógica for verdadeira, execute o comando.
   ```fortran
         if (x .LT. 0) x = -x
   ```

2. **Condição com múltiplos comandos:**  
   ```fortran
         if (condição lógica) then
             comandos
         endif
   ```

3. **Condição com alternativas:**  
   ```fortran
         if (condição lógica) then
             comandos
         elseif (outra condição lógica) then
             comandos
         else
             comandos
         endif
   ```

#### Exemplo: Cadastro de Números Telefônicos com DDD

```fortran
c234567
      PROGRAM CONDITIONALS
      IMPLICIT NONE
      CHARACTER*11 NUMBER
      CHARACTER*9 REST
      INTEGER LEN

      write (*,*) 'Input Number:'
      read (*,*) NUMBER
      
      LEN = LEN_TRIM(NUMBER)
      
      IF (LEN .GT. 3) THEN
          REST = NUMBER(3:LEN)
      ELSE
          REST = ''
      END IF
      
      IF (LEN .LT. 8 .OR. LEN .GT. 11) then
          write(*,*) 'Invalid Number'
      ELSE IF (LEN .EQ. 8 .OR. LEN .EQ. 9) then
          write(*,*) NUMBER
      ELSE IF (LEN .EQ. 10 .OR. LEN .EQ. 11) then	      
          write(*,*) 'DDD and number are ', NUMBER(1:2) // ' ' // REST
      END IF
      
      STOP
      END
```
*exemplo 3: cadastro de telefone*

*Funcionamento do Programa:*  
- Solicita ao usuário um número de telefone (string).
- Calcula o comprimento real da string com `LEN_TRIM`.
- Se o comprimento for menor que 8 ou maior que 11, imprime "Invalid Number".
- Se for 8 ou 9, imprime o número diretamente.
- Se for entre 10 e 11, imprime o DDD (dois primeiros caracteres), um espaço e o restante do número.

## Loops

### Tipos de Loops em Fortran 77

Fortran 77 oferece três tipos principais de loops, cada um com suas características específicas:

| Tipo | Sintaxe | Quando Usar | Vantagens | Desvantagens |
|------|---------|-------------|-----------|--------------|
| **DO Loop** | `DO label var = start, end, step` | Número conhecido de iterações | Simples, eficiente | Limitado a incrementos fixos |
| **While Loop** | `label IF (cond) THEN ... GOTO label` | Condição de continuação | Flexível | Usa GOTO (considerado má prática) |
| **Until Loop** | `label ... IF (cond) GOTO label` | Condição de parada | Flexível | Usa GOTO (considerado má prática) |

### DO Loops

A sintaxe geral é:

```fortran
c234567
      do label var = expr1, expr2, expr3
          statements
      label continue
```

**Parâmetros:**
- **var:** variável do loop (deve ser inteiro)
- **expr1:** valor inicial
- **expr2:** valor limitante
- **expr3:** incremento (opcional, padrão é 1)

**Características:**
- A variável é incrementada automaticamente
- O loop termina quando var > expr2 (se expr3 > 0) ou var < expr2 (se expr3 < 0)
- A variável pode ser modificada dentro do loop (não recomendado)

```fortran
c234567
      PROGRAM SHOW
      IMPLICIT NONE
      
      INTEGER a(10), I
      
      DATA a /1, 2, 3, 4, 5, 6, 7, 8, 9, 10/
      
      DO 10 I = 1, 10
          PRINT *, 'Elemento', I, ':', a(I)
10    CONTINUE
      
      END
```
*exemplo 4.1: loop simples*

**Variações do DO Loop:**
```fortran
c234567
      ! Loop com incremento diferente de 1
      DO 20 I = 1, 10, 2
          PRINT *, I
20    CONTINUE
      
      ! Loop decrescente
      DO 30 I = 10, 1, -1
          PRINT *, I
30    CONTINUE
```

### While Loops (Condição de Progresso)

O programador atual está acostumado com o formato:

```fortran
c234567
      while (logical expr) do
        statements
      enddo
```

Mas ele **não é ANSI Fortran 77**. O adequado é:

```fortran
c234567
      label if (logical expr) then
          statements
          goto label
      end if
```

**Quando usar:** Quando você não sabe quantas iterações serão necessárias, mas sabe a condição de continuação.

```fortran
c234567
      PROGRAM WOW
      IMPLICIT NONE
      
      INTEGER a(10), I
      
      DATA a /1, 2, 3, 4, 5, 6, 7, 8, 9, 10/
      
      I = 1
      
10    IF (a(I) /= 5) THEN
          PRINT *, 'Elemento', I, ':', a(I)
          I = I + 1
          GOTO 10
      END IF
      
      END
```
*exemplo 4.2: While do*

### Until Loops (Condição de Parada)

Um exemplo de loop "until" usando `goto`:

```fortran
c234567
10    CONTINUE
      PRINT *, 'Elemento', I, ':', a(I)
      I = I + 1
      IF (a(I) /= 9) THEN		
          GOTO 10
      END IF
      END
```
*exemplo 4.3: Until do*

**Quando usar:** Quando você quer executar o corpo do loop pelo menos uma vez e depois verificar a condição de parada.

### Comparação Prática

| Cenário | Loop Recomendado | Exemplo |
|---------|------------------|---------|
| Iterar sobre array conhecido | DO Loop | `DO 10 I = 1, N` |
| Ler até encontrar sentinela | While Loop | `WHILE (valor /= -1)` |
| Processar até condição | Until Loop | `UNTIL (convergiu)` |
| Contagem regressiva | DO Loop | `DO 20 I = N, 1, -1` |

### ⚠️ Considerações sobre GOTO

O uso de `GOTO` é considerado má prática em programação moderna, mas em Fortran 77 é frequentemente necessário para implementar loops while e until. Em versões mais modernas do Fortran, use `DO WHILE` e `DO UNTIL`.

## Subprogramas

Subprogramas são blocos de código que resolvem tarefas específicas, podendo ser funções ou subrotinas.

### Funções

Funções recebem um ou mais argumentos e retornam um valor. A maioria das funções inatas (como `abs`, `min`, `max`, `sqrt`) são genéricas, mas funções definidas pelo usuário geralmente precisam especificar o tipo de retorno. O valor de retorno é atribuído à variável com o mesmo nome da função e o bloco termina com `RETURN`.

```fortran
c234567
      PROGRAM CHOOSE
      IMPLICIT NONE
      
      INTEGER P, R, QUADRADO
      
      WRITE(*,*) 'CHOOSE A NUMBER 1 TO 10'
      READ (*,*) P
      
      R = QUADRADO(P)
      
      WRITE(*,*) 'O RESULTADO É', R
      
      END
      
      INTEGER FUNCTION QUADRADO(X)
      IMPLICIT NONE
      INTEGER X
      
      QUADRADO = X * X
      
      RETURN
      END
```
*exemplo 5.1: Quadrado*

### Subrotinas

Subrotinas podem retornar mais de um valor e são invocadas com `CALL`. Elas não possuem tipo.

```fortran
c234567
      PROGRAM CHAMA_SUBROTINA
      IMPLICIT NONE
      
      INTEGER N, QUADRADO, CUBO
      
      PRINT *, 'Digite um número:'
      READ *, N
      
      CALL CALCULA_QUADRADO_E_CUBO(N, QUADRADO, CUBO)
      
      PRINT *, 'O quadrado de', N, 'é', QUADRADO
      PRINT *, 'O cubo de', N, 'é', CUBO
      
      END
      
      SUBROUTINE CALCULA_QUADRADO_E_CUBO(X, QUAD, CUB)
      IMPLICIT NONE
      INTEGER X, QUAD, CUB
      
      QUAD = X * X
      CUB = X * X * X
      
      RETURN
      END
```
*exemplo 5.2: Quadrado e Cubo*

## Arrays

### Declaração de Arrays

Para declarar vetores e matrizes:

```fortran
c234567
      real a(20)
      ! Declara um vetor com 20 componentes reais, indexados de 1 a 20

      real A(3,5)
      ! Declara uma matriz 3x5

      logical B(20,5,39,29152)
      ! Declara um array 20x5x39x2
```

Fortran 77 permite arrays de até 7 dimensões.

### Manipulação de Arrays

#### Inicialização em Loop

```fortran
c234567
      PROGRAM EXEMPLO_ARRAY
      IMPLICIT NONE

      INTEGER N, A(5), I
      PARAMETER (N = 5)
      
      DO I = 1, N
          A(I) = I * 2   
      END DO
      
      PRINT *, 'Elementos do array A:'
      DO I = 1, N
          PRINT *, 'A(', I, ') = ', A(I)
      END DO
      
      END
```
*exemplo 6.1: Array básico*

#### Soma de Elementos

```fortran
c234567
      PROGRAM SOMA_ARRAY
      IMPLICIT NONE
      
      INTEGER N, A(5), SUM, I
      PARAMETER (N = 5)
      
      ! Inicialização usando DATA statement
      DATA A /1, 2, 3, 4, 5/
      
      SUM = 0
      
      DO I = 1, N
          SUM = SUM + A(I)
      END DO
      
      PRINT *, 'Soma dos elementos de A:', SUM
      
      END
```
*exemplo 6.2: Array Soma*

#### Produto de Elementos

```fortran
c234567
      PROGRAM MULTIPLICACAO_ARRAY
      IMPLICIT NONE
      
      INTEGER N, A(5), PRODUTO, I
      PARAMETER (N = 5)
      
      ! Inicialização usando DATA statement
      DATA A /1, 2, 3, 4, 5/
      
      PRODUTO = 1
      
      DO I = 1, N
          PRODUTO = PRODUTO * A(I)
      END DO
      
      PRINT *, 'Produto dos elementos de A:', PRODUTO
      
      END
```
*exemplo 6.3: Array Produto*

### Operações Comuns com Arrays

#### Busca Linear

```fortran
c234567
      PROGRAM BUSCA_LINEAR
      IMPLICIT NONE
      
      INTEGER A(10), VALOR, I, POSICAO
      LOGICAL ENCONTRADO
      
      DATA A /5, 2, 8, 1, 9, 3, 7, 4, 6, 0/
      
      PRINT *, 'Digite o valor a procurar:'
      READ *, VALOR
      
      ENCONTRADO = .FALSE.
      POSICAO = 0
      
      DO I = 1, 10
          IF (A(I) .EQ. VALOR) THEN
              ENCONTRADO = .TRUE.
              POSICAO = I
              GOTO 100
          END IF
      END DO
      
100   IF (ENCONTRADO) THEN
          PRINT *, 'Valor encontrado na posição:', POSICAO
      ELSE
          PRINT *, 'Valor não encontrado'
      END IF
      
      END
```

#### Ordenação Básica (Bubble Sort)

```fortran
c234567
      PROGRAM ORDENACAO
      IMPLICIT NONE
      
      INTEGER A(5), I, J, TEMP
      
      DATA A /5, 2, 8, 1, 9/
      
      PRINT *, 'Array original:'
      DO I = 1, 5
          PRINT *, A(I)
      END DO
      
      ! Bubble sort
      DO I = 1, 4
          DO J = 1, 4
              IF (A(J) .GT. A(J+1)) THEN
                  TEMP = A(J)
                  A(J) = A(J+1)
                  A(J+1) = TEMP
              END IF
          END DO
      END DO
      
      PRINT *, 'Array ordenado:'
      DO I = 1, 5
          PRINT *, A(I)
      END DO
      
      END
```

### Dicas Importantes

- **Indexação:** Arrays em Fortran começam no índice 1, não 0
- **Limites:** Sempre verifique os limites dos arrays para evitar erros
- **Inicialização:** Use `DATA` statement para inicializar arrays
- **Performance:** Acesse arrays em ordem de memória (primeira dimensão varia mais rapidamente)

## Common Blocks

Common blocks permitem compartilhar variáveis entre subprogramas. O bloco comum deve ser declarado antes das execuções.

```fortran
      program main
      ! Declarações
      real alpha, beta
      common /coeff/ alpha, beta

      ! Statements
      stop
      end

      subroutine sub1(...)
      real alpha, beta
      common /coeff/ alpha, beta

      ! Statements
      return
      end

      subroutine sub2(...)
      real alpha, beta
      common /coeff/ alpha, beta

      ! Statements
      return
      end
```

Regras importantes:
- O bloco comum deve ser declarado antes da execução do código.
- Blocos comuns distintos devem ter nomes distintos.
- Uma variável não pode aparecer em dois blocos comuns diferentes.
- Variáveis devem ser listadas na mesma ordem, com o mesmo tipo e tamanho em todas as rotinas que utilizam o mesmo bloco comum.
- Arrays com dimensões variáveis não devem constar em blocos comuns.

## Data e Block Statements

O `data` statement é usado para inicializar variáveis antes da execução do programa.

```fortran
c234567
      program main
      data m/10/, n/20/, x/2.5/, y/2.5/
      real m, n, x, y
      
      write (*,*) m
      write (*,*) n	
      write (*,*) x
      write (*,*) y
      STOP
      END
```
*exemplo 7.1: inicialização*

Outra forma:

```fortran
c234567
      program main
      data m,n/10,20/, x,y/2*2.5/
      real m, n, x, y
      
      write (*,*) m
      write (*,*) n
      write (*,*) x
      write (*,*) y
      STOP
      END
```
*exemplo 7.2: inicialização alt*
Com matrizes:

```fortran
c234567
      program main
      real A(10,20)
      data A/ 200 * 0.0/
      ...
```
*exemplo 7.3: inicialização matricial*

O exemplo acima inicializa uma matriz 10x20 com todos os 200 valores iguais a zero.

## File I.O.

O comando principal para acessar um arquivo é:

```fortran
      open ([UNIT=]u [, IOSTAT=ios, ERR=err, STATUS=sta])
```

Especificadores comuns:
- **unidade ("u"):** valor inteiro único de 1 a 99 que identifica o arquivo.
- **status ("ios"):** variável inteira que retorna zero se a operação for bem-sucedida.
- **error ("err"):** determina para qual comando o programa deve saltar em caso de erro.
- **nome ("fname"):** nome do arquivo a ser acessado (string).
- **status ("sta"):** deve ser NEW, OLD ou SCRATCH; define se o arquivo já existe ou se deve ser criado e se será deletado após o fechamento.
- **final ("end"):** determina para qual comando o programa deve saltar ao chegar ao fim do arquivo (usado em `read` ou `write`).

Para fechar o arquivo, usa-se:

```fortran
      close ([UNIT=]u [, IOSTAT=ios, ERR=err, STATUS=sta])
```

Os comandos `read` e `write` são usados com o especificador de unidade obrigatório.

```fortran
c234567
      program inpdat
      ! Este programa lê n pontos de um arquivo e os armazena em 3 arrays: x, y, z.
      
      integer nmax, u
      parameter (nmax=1000, u=20)
      real x(nmax), y(nmax), z(nmax)
      
      ! Abre o arquivo de dados
      open (u, FILE='points.dat', STATUS='OLD')
      
      ! Lê o número de pontos
      read(u,*) n
      if (n.GT.nmax) then
          write(*,*) 'Error: n = ', n, 'is larger than nmax =', nmax
          goto 9999
      endif
      
      ! Loop sobre os pontos
      do 10 i= 1, n
          read(u,100) x(i), y(i), z(i)
10    enddo
100   format (3(F10.4))
      
      ! Fecha o arquivo
      close (u)
      
      ! (Parte faltante para processar os dados)
      
9999  stop
      end
```
*exemplo 8: Leitura e escrita (IO)*

## Format

A formatação é definida com o comando `write` seguido de um label que especifica o formato.

```fortran
c234567
      program main
      data m/10/, n/20/, x/2.5/, y/2.5/
      real m, n, x, y
      
      write (*,*) m
      write (*,*) n
      write (*,*) x
      write (*,*) y
      STOP
      END
```

A saída deste código seria algo como:

```
10.0000000
20.0000000
2.50000000
2.50000000
```

A formatação pode ser alterada seguindo o padrão:

```fortran
c234567      
      write(*,label) lista_de_variaveis
      label format-code	
```

Códigos comuns de formatação:
- **A:** string de texto
- **D:** números em double precision, notação exponencial
- **E:** números reais, notação exponencial
- **F:** números reais, formato fixo
- **I:** inteiro
- **X:** espaço horizontal
- **/**: salto de linha

Exemplo:

```fortran
c234567
      program main
      data m/10/, n/20/, x/2.5/, y/2.5/
      
      ! Escreve m com formato I2
      write (*,100) m
100   format (I2)
      
      ! Escreve n com formato inline
      write (*,'(I2)') n  
      
      ! Escreve x com formato F4.1
      write (*,300) x
300   format (F4.1)
      
      ! Escreve y com formato E8.2
      write (*,400) y
400   format (E8.2)
      
      STOP
      END
```
*exemplo 9: format*
Saída esperada:

```
10
20
2.5
0.25E+01
```

## Bibliotecas

Como em qualquer outra linguagem, é possível utilizar pacotes já criados (muitos gratuitos) para resolver problemas comuns. Para problemas numéricos, por exemplo, a plataforma Netlib disponibiliza softwares e databases de interesse científico, como os pacotes **BLAS** e **LAPACK**.

### BLAS

- Acrônimo de Basic Linear Algebra Subroutines.
- Contém subprogramas para operações com vetores e matrizes.
- Suas rotinas são organizadas em três níveis:
  - **Nível 1:** Operações vetor x vetor.
  - **Nível 2:** Operações matriz x vetor.
  - **Nível 3:** Operações matriz x matriz.
- A primeira letra dos nomes dos subprogramas indica a precisão:
  - **S:** Real precisão única.
  - **D:** Real precisão dupla.
  - **C:** Complexo precisão única.
  - **Z:** Complexo precisão dupla.

### LAPACK

- Construído sobre BLAS, é uma coleção para problemas avançados de álgebra linear.
- Documentação disponível em:
  - [LAPACK Home](http://www.netlib.org/lapack/)
  - [LAPACK User's Guide](http://www.netlib.org/lapack/lug/lapack_lug.html)
- Ao instalar, coloque os arquivos `.lib` (no Windows) ou `.a` (no Linux) em um diretório apropriado. Certifique-se de ajustar os caminhos de compilação conforme necessário. O BLAS deve ser especificado por último no comando de compilação.


```fortran
c234567
      PROGRAM SolveLinearSystem
      IMPLICIT NONE

      INTEGER :: n, nrhs, lda, ldb, info
      PARAMETER (n = 3, nrhs = 1, lda = n, ldb = n)

      REAL :: A(lda, n), B(ldb, nrhs)
      INTEGER :: ipiv(n)

      EXTERNAL SGESV
  
      DATA A / 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 10.0 /
      DATA B / 6.0, 15.0, 25.0 /

      PRINT *, 'Starting the linear system solver...'
      
      CALL SGESV(n, nrhs, A, lda, ipiv, B, ldb, info)

      PRINT *, 'SGESV call completed.'

      IF (info .EQ. 0) THEN
          PRINT *, 'The solution is:'
          PRINT *, B
      ELSE
          PRINT *, 'An error occurred: info =', info
      END IF

      PRINT *, 'Program finished.'
      
      STOP      
      END
```
*Exemplo 10: Solução de Sistema Linear*

Para compilar:

```bash
$ gfortran 10.solucao_linear.f -o 10.solucao_linear -LC:/msys64/mingw64/lib -llapack -lblas

```
*ou para openblas*
```bash
$ gfortran 10.solucao_linear.f -o 10.solucao_linear -LC:/msys64/mingw64/lib -lopenblas
```

*Observação:* O diretório especificado após `-LC:` deve conter as bibliotecas necessárias. Lembre-se que se você for usar LAPACK, ele depende do BLAS, o qual deve ser listado por último no comando. No meu caso, optei por usar o Open_Blas porque as instalações dessas bibliotecas podem conflitar entre o uso no Microsoft Visual Studio e no MSYS2 caso esteja no Windows, esteja atento à extensão instalada na sua máquina - Microsoft Studio usa .lib enquanto MinGW/gfortran usam .a / .dll.a.

A maior complicação pode estar na depuração de erros relacionados a versões de DLLs e compatibilidade com a arquitetura da CPU. Em edições futuras, abordaremos a construção de pacotes e a compilação de versões específicas da BLAS ou LAPACK para sua máquina.

## Boas Práticas e Problemas Comuns

### Boas Práticas

#### 1. Estrutura do Programa
```fortran
c234567
      PROGRAM NOME_PROGRAMA
      IMPLICIT NONE
      
      ! Declarações de variáveis
      INTEGER I, J, K
      REAL X, Y, Z
      
      ! Declarações de parâmetros
      PARAMETER (PI = 3.14159)
      
      ! Inicializações
      DATA X /0.0/, Y /0.0/
      
      ! Corpo principal do programa
      ...
      
      STOP
      END
```

#### 2. Nomenclatura
- Use nomes descritivos (dentro do limite de 6 caracteres)
- Use maiúsculas para constantes: `PI`, `MAXSIZ`
- Use minúsculas para variáveis: `i`, `j`, `x`, `y`
- Evite nomes muito similares: `i`, `l`, `1` podem ser confusos

#### 3. Comentários
```fortran
c234567
      ! Este é um comentário moderno (Fortran 90+)
c     Este é um comentário Fortran 77
*     Este também é um comentário Fortran 77
```

#### 4. Formatação
- Sempre use `IMPLICIT NONE`
- Mantenha código nas colunas 7-72
- Use indentação consistente
- Agrupe declarações relacionadas

### Problemas Comuns e Soluções

#### 1. Erros de Compilação

**Problema:** `Error: Unexpected end of file`
```fortran
      PROGRAM TESTE
      IMPLICIT NONE
      INTEGER I
      I = 1
      ! Falta STOP e END
```
**Solução:** Sempre inclua `STOP` e `END` no final do programa.

**Problema:** `Error: Variable 'X' is used but not declared`
```fortran
      PROGRAM TESTE
      IMPLICIT NONE
      REAL Y
      X = 1.0  ! X não foi declarado
```
**Solução:** Declare todas as variáveis ou remova `IMPLICIT NONE`.

#### 2. Erros de Execução

**Problema:** `Floating point exception`
```fortran
      REAL X, Y
      X = 1.0
      Y = 0.0
      X = X / Y  ! Divisão por zero
```
**Solução:** Sempre verifique divisores antes da divisão.

**Problema:** `Array bounds exceeded`
```fortran
      INTEGER A(5)
      DO I = 1, 10  ! I vai de 1 a 10, mas A só tem 5 elementos
          A(I) = I
      END DO
```
**Solução:** Verifique sempre os limites dos arrays.

#### 3. Problemas de Lógica

**Problema:** Comparação de números reais
```fortran
      REAL X, Y
      X = 0.1
      Y = 0.1
      IF (X .EQ. Y) THEN  ! Pode falhar devido à precisão
```
**Solução:** Use tolerância para comparações de números reais.
```fortran
      REAL X, Y, TOL
      PARAMETER (TOL = 1.0E-6)
      IF (ABS(X - Y) .LT. TOL) THEN
```

**Problema:** Loop infinito
```fortran
      I = 1
10    IF (I .LT. 10) THEN
          PRINT *, I
          ! Falta incrementar I
          GOTO 10
      END IF
```
**Solução:** Sempre incremente a variável de controle do loop.

### Dicas de Debugging

#### 1. Usando PRINT para Debug
```fortran
      ! Adicione prints estratégicos
      PRINT *, 'Valor de X antes do loop:', X
      DO I = 1, N
          X = X + I
          IF (MOD(I, 100) .EQ. 0) THEN
              PRINT *, 'Iteração', I, 'X =', X
          END IF
      END DO
      PRINT *, 'Valor de X após o loop:', X
```

#### 2. Verificação de Bounds
```fortran
      ! Sempre verifique limites antes de usar arrays
      IF (I .LT. 1 .OR. I .GT. N) THEN
          PRINT *, 'Erro: Índice', I, 'fora dos limites 1-', N
          STOP
      END IF
      A(I) = VALOR
```

#### 3. Validação de Entrada
```fortran
      ! Valide sempre a entrada do usuário
      READ *, N
      IF (N .LE. 0 .OR. N .GT. MAXSIZ) THEN
          PRINT *, 'Erro: N deve estar entre 1 e', MAXSIZ
          STOP
      END IF
```

### Performance e Otimização

#### 1. Acesso a Arrays
```fortran
      ! ❌ Ruim: Acessa em ordem incorreta
      DO I = 1, N
          DO J = 1, M
              A(J, I) = A(J, I) + 1  ! Segunda dimensão varia primeiro
          END DO
      END DO
      
      ! ✅ Bom: Acessa em ordem de memória
      DO J = 1, M
          DO I = 1, N
              A(J, I) = A(J, I) + 1  ! Primeira dimensão varia primeiro
          END DO
      END DO
```

#### 2. Evite Operações Desnecessárias
```fortran
      ! ❌ Ruim: Calcula potência repetidamente
      DO I = 1, N
          Y = X**2  ! Calcula X^2 N vezes
      END DO
      
      ! ✅ Bom: Calcula uma vez
      X2 = X**2
      DO I = 1, N
          Y = X2
      END DO
```

### Checklist de Qualidade

Antes de considerar seu programa finalizado, verifique:

- [ ] Todas as variáveis estão declaradas
- [ ] `IMPLICIT NONE` está presente
- [ ] `STOP` e `END` estão no final
- [ ] Código está nas colunas 7-72
- [ ] Arrays não excedem limites
- [ ] Divisões por zero estão protegidas
- [ ] Loops têm condição de parada
- [ ] Comentários explicam lógica complexa
- [ ] Nomes de variáveis são descritivos
- [ ] Programa foi testado com diferentes entradas

## Exercícios Sugeridos

### Exercícios Básicos

#### Exercício 1: Calculadora Simples
Escreva um programa que leia dois números e uma operação (+, -, *, /) e calcule o resultado.

#### Exercício 2: Média de Notas
Escreva um programa que leia 5 notas de um aluno e calcule a média.

#### Exercício 3: Fatorial
Escreva uma função que calcule o fatorial de um número inteiro.

### Exercícios Intermediários

#### Exercício 4: Matriz Transposta
Escreva um programa que leia uma matriz 3x3 e calcule sua transposta.

#### Exercício 5: Busca Binária
Implemente o algoritmo de busca binária para encontrar um elemento em um array ordenado.

#### Exercício 6: Ordenação por Seleção
Implemente o algoritmo de ordenação por seleção.

### Exercícios Avançados

#### Exercício 7: Sistema de Equações Lineares
Escreva um programa que resolva um sistema de 3 equações lineares usando o método de Gauss.

#### Exercício 8: Integração Numérica
Implemente a regra do trapézio para calcular a integral de uma função.

#### Exercício 9: Processamento de Arquivos
Escreva um programa que leia um arquivo de texto e conte o número de palavras, linhas e caracteres.

## Material deste guia

### Diretório de Exemplos

Este guia possui um diretório `f77_examples/` contendo todos os exemplos práticos mencionados ao longo do texto. Cada exemplo está organizado em arquivos separados para facilitar o estudo e prática.

#### Estrutura do Diretório
```
f77_examples/
├── 1.hello_world.f          # Exemplo básico de Hello World
├── 2.tipagem.f              # Demonstração de tipos de dados
├── 3.cadastro.f             # Exemplo de condicionais
├── 4.1.loop.f               # Loops básicos
├── 4.2.whiledo.f            # Loops while
├── 4.3.untildo.f            # Loops until
├── 5.1.quadrado.f           # Funções
├── 5.2.quad_cubo.f          # Subrotinas
├── 6.1.array_basico.f       # Arrays básicos
├── 6.2.array_soma.f         # Operações com arrays
├── 6.3.array_produto.f      # Produto de elementos
├── 7.1.inicializacao.f      # Inicialização com DATA
├── 7.2.inicializacao_alt.f  # Inicialização alternativa
├── 7.3.inicializacao_matricial.f  # Inicialização de matrizes
├── 8.IO.f                   # Entrada e saída de arquivos
├── 9.format.f               # Formatação de saída
├── 10.solucao_linear.f      # Exemplo com bibliotecas (LAPACK)
├── points.dat               # Arquivo de dados para exemplo 8
└── Makefile                 # Script de compilação automática
```

### Makefile para Compilação Rápida

O diretório inclui um `Makefile` que facilita a compilação e execução dos exemplos. Este arquivo automatiza o processo de compilação, evitando a necessidade de digitar comandos longos manualmente.

#### Comandos Disponíveis

```bash
# Compilar todos os exemplos
make 

# Compilar um exemplo específico
make 1.hello_world
make 2.tipagem
make 3.cadastro

# Executar um exemplo específico
make run-1.hello_world
make run-2.tipagem

# Limpar arquivos compilados
make clean

# Listar todos os exemplos disponíveis
make list
```

#### Como Usar

1. **Navegue até o diretório de exemplos:**
   ```bash
   cd f77_examples/
   ```

2. **Compile todos os exemplos:**
   ```bash
   make 
   ```

3. **Execute um exemplo específico:**
   ```bash
   make run-1.hello_world
   ```

4. **Para exemplos que requerem bibliotecas externas (como o exemplo 10):**
   ```bash
   make 10.solucao_linear
   ```


### Sugestões de Uso

1. **Estudo Sequencial**: Execute os exemplos na ordem numérica para seguir a progressão do guia
2. **Experimentação**: Modifique os exemplos para testar diferentes cenários
3. **Debugging**: Use o Makefile para recompilar rapidamente após modificações
4. **Comparação**: Execute exemplos similares para ver as diferenças na prática

### Requisitos

- Compilador Fortran (gfortran recomendado)
- Make (geralmente já instalado em sistemas Unix/Linux)
- Para o exemplo 10: bibliotecas LAPACK/BLAS (opcional)

---
Use o Makefile como ponto de partida para seus próprios projetos. Ele é boa práticas de organização e automação.

## Recursos Adicionais

### Compiladores Gratuitos

- **gfortran**: Compilador GNU para Fortran (recomendado)
  - Download: [GNU Fortran](https://gcc.gnu.org/fortran/)
  - Disponível para Windows, Linux e macOS

- **Intel Fortran**: Versão gratuita para estudantes
  - Download: [Intel OneAPI](https://www.intel.com/content/www/us/en/developer/tools/oneapi/fortran-compiler.html)

### Livros Recomendados

1. **"Fortran 77 for Engineers and Scientists"** - Larry Nyhoff
2. **"Introduction to Fortran 77"** - Ian Chivers
3. **"Fortran 77: Reference Manual"** - Sun Microsystems

### Links Úteis

- [Fortran Wiki](https://fortranwiki.org/)
- [Netlib](http://www.netlib.org/) - Biblioteca de rotinas matemáticas
- [Fortran Standards](https://wg5-fortran.org/) - Padrões oficiais

### Ferramentas de Desenvolvimento

- **Visual Studio Code** com extensão Fortran
- **Eclipse** com plugin Photran
- **Emacs** com modo Fortran

### Comunidades Online

- [Stack Overflow - Fortran](https://stackoverflow.com/questions/tagged/fortran)
- [Reddit r/fortran](https://www.reddit.com/r/fortran/)
- [Fortran Discourse](https://fortran-lang.discourse.group/)

### Próximos Passos

Após dominar Fortran 77, considere aprender:

1. **Fortran 90/95**: Recursos modernos como alocação dinâmica
2. **Fortran 2003/2008**: Programação orientada a objetos
3. **Fortran 2018**: Recursos mais recentes

### Troubleshooting Comum

| Problema | Causa | Solução |
|----------|-------|---------|
| Erro de formatação | Código fora das colunas 7-72 | Verificar indentação |
| Variável não declarada | Falta `IMPLICIT NONE` | Adicionar declaração explícita |
| Erro de compilação | Sintaxe moderna | Usar apenas sintaxe F77 |
| Erro de execução | Índice fora dos limites | Verificar limites de arrays |

---

**Nota:** Este guia cobre os fundamentos do Fortran 77. Para projetos modernos, considere usar versões mais recentes do Fortran que oferecem recursos mais avançados e melhor segurança de tipos.

