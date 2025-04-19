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