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