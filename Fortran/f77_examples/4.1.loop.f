c234567
      PROGRAM SHOW
      IMPLICIT NONE
      
      INTEGER a(10), I
      
      DATA a /1, 2, 3, 4, 5, 6, 7, 8, 9, 10/
      
      DO 10 I = 1, 10
          PRINT *, 'Elemento', I, ':', a(I)
10    CONTINUE
      
      END