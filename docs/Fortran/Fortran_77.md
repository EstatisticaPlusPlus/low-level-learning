---
title: "Fortran 77"
---

# Fortran 77

Aqui vamos abordar várias particularidades da versão 77. Sua leitura fica a critério da curiosidade ou da necessidade do leitor.

Este material foi fortemente inspirado no guia de Stanford para F77, disponível em [Stanford ME200C Tutorial](https://web.stanford.edu/class/me200c/tutorial_77/03_basics.html).

## Básico

A estrutura principal do código F77 é da forma:

```fortran
c234567	
      program *nome*
      
      *declarações de variáveis*
      
      *comandos*
      
      stop
      end
```

A formatação da versão 77 é rígida, seguindo um padrão ditado pelo número referente à coluna no editor de texto, da seguinte forma:

- **Coluna 1:** Vazia ou preencha com "c" ou "*" para usar a linha como comentário.
- **Colunas 1-5:** Categoria da declaração da linha.
- **Coluna 6:** Indica a continuação da linha prévia (opcional).
- **Colunas 7-72:** Comando.
- **Colunas 73-80:** Número de sequência (uso incomum).

Importante salientar que não podemos ter uma variável com o mesmo nome que o programa.


```fortran
c234567
      PROGRAM HELLO
      WRITE(UNIT=*, FMT=*) 'Hello World'
      STOP
      END

      
```
*exemplo 1: Hello World. Note que os comandos começam a partir da coluna 7*

Note que no código acima o comando `write(UNIT=*, FMT=*)` também poderá ser escrito como `write(*,*)`, o que é uma simplificação usual na atribuição desses argumentos compulsórios.

## Variáveis, Tipos e Declarações

Variáveis em Fortran consistem em no máximo 6 caracteres alfanuméricos, iniciando com uma letra, sem diferenciar maiúsculas e minúsculas. Palavras reservadas como `program`, `real`, `stop` e `end` não podem ser usadas como nomes de variáveis.

Toda variável deve ser definida em uma declaração que estabelece seu tipo, como:

- **integer**
- **real**
- **double precision**
- **complex**
- **logical**
- **character**

Embora o Fortran utilize regras implícitas se a variável não for declarada, é boa prática usar `implicit none` para evitar ambiguidades e forçar a declaração de todas as variáveis.

- O tipo **integer** geralmente tem 32 bits, com limite aproximado de ±2×10⁹.
- Existem dois tipos de float: **real** (4 bytes) e **double precision** (8 bytes).

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

### Do Loops

A sintaxe geral é:

```fortran
c234567
      do label var = expr1, expr2, expr3
          statements
      label continue
```

- **var:** variável do loop (deve ser inteiro)
- **expr1:** valor inicial
- **expr2:** valor limitante
- **expr3:** incremento



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

### While Loops (Condição de Progresso)

O programador atual está acostumado com o formato:

```fortran
c234567
      while (logical expr) do
        statements
      enddo
```

Mas ele não é ANSI Fortran 77. O adequado é:

```fortran
c234567
      label if (logical expr) then
          statements
          goto label
      end if
```


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

      INTEGER :: N = 5
      INTEGER :: A(N)
      INTEGER :: I
      
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
      
      INTEGER :: N = 5
      INTEGER :: A(N) = (/1, 2, 3, 4, 5/)
      INTEGER :: SUM
      INTEGER :: I
      
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
      
      INTEGER :: N = 5
      INTEGER :: A(N) = (/1, 2, 3, 4, 5/)
      INTEGER :: PRODUTO
      INTEGER :: I
      
      PRODUTO = 1
      
      DO I = 1, N
          PRODUTO = PRODUTO * A(I)
      END DO
      
      PRINT *, 'Produto dos elementos de A:', PRODUTO
      
      END
```
*exemplo 6.3: Array Produto*

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

