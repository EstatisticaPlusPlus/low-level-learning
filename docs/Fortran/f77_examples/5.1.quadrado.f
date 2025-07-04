c234567
      PROGRAM CHOOSE
      IMPLICIT NONE
      
      INTEGER P, R, QUADRADO
      
      WRITE(*,*) 'CHOOSE A NUMBER 1 TO 10'
      READ (*,*) P
      
      R = QUADRADO(P)
      
      WRITE(*,*) 'O RESULTADO É', R
      
      END
      
      INTEGER FUNCTION QUADRADO(X)
      IMPLICIT NONE
      INTEGER X
      
      QUADRADO = X * X
      
      RETURN
      END