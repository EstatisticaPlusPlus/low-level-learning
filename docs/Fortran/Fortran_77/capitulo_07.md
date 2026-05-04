---
title: "7. Subprogramas"
---

# 7. Subprogramas

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
