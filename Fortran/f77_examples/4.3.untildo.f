      PROGRAM UNTILDO
      IMPLICIT NONE
      INTEGER :: a(5)
      INTEGER :: I

      a(1) = 1
      a(2) = 3
      a(3) = 5
      a(4) = 7
      a(5) = 9

      I = 1

10    CONTINUE
      PRINT *, 'Elemento', I, ':', a(I)
      I = I + 1
      IF (a(I) /= 9) THEN
          GOTO 10
      END IF

      END
