      PROGRAM ARRAY_PRODUTO
      IMPLICIT NONE

      INTEGER A(5)
      INTEGER I, PRODUTO

      DATA A /1, 2, 3, 4, 5/
      PRODUTO = 1

      DO I = 1, 5
         PRODUTO = PRODUTO * A(I)
      END DO

      PRINT *, 'PRODUTO = ', PRODUTO

      END
