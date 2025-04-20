      PROGRAM ARRAY_SOMA
      IMPLICIT NONE

      INTEGER A(5)
      INTEGER I, SUM

      DATA A /1, 2, 3, 4, 5/
      SUM = 0

      DO I = 1, 5
         SUM = SUM + A(I)
      END DO

      PRINT *, 'SOMA = ', SUM

      END
