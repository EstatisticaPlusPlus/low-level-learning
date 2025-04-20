      PROGRAM ARRAY_BASICO
      IMPLICIT NONE
      INTEGER N, A(100)
      INTEGER I

      N = 10

      DO I = 1, N
         A(I) = I * 2
      END DO

      DO I = 1, N
         PRINT *, 'A(', I, ') = ', A(I)
      END DO

      END
