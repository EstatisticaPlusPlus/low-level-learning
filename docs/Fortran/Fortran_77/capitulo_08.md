---
title: "8. Arrays"
---

# 8. Arrays

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
