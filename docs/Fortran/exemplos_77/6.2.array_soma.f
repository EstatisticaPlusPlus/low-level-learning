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