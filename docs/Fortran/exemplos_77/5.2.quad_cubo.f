c234567
      PROGRAM CHAMA_SUBROTINA
      IMPLICIT NONE
      
      INTEGER N, QUADRADO, CUBO
      
      PRINT *, 'Digite um numero:'
      READ *, N
      
      CALL CALCULA_QUADRADO_E_CUBO(N, QUADRADO, CUBO)
      
      PRINT *, 'O quadrado de', N, 'resulta', QUADRADO
      PRINT *, 'O cubo de', N, 'resulta', CUBO
      
      END
      
      SUBROUTINE CALCULA_QUADRADO_E_CUBO(X, QUAD, CUB)
      IMPLICIT NONE
      INTEGER X, QUAD, CUB
      
      QUAD = X * X
      CUB = X * X * X
      
      RETURN
      END