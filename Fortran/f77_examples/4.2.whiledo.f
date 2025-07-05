c234567
      PROGRAM WOW
      IMPLICIT NONE
      
      INTEGER a(10), I
      
      DATA a /1, 2, 3, 4, 5, 6, 7, 8, 9, 10/
      
      I = 1
      
10    IF (a(I) /= 5) THEN
          PRINT *, 'Elemento', I, ':', a(I)
          I = I + 1
          GOTO 10
      END IF
      
      END