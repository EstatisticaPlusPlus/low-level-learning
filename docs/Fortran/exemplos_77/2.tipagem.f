c234567
      PROGRAM TYPES
      IMPLICIT NONE
      
      ! Determina a declaração do tipo de variáveis
      INTEGER alfa, beta, delta
      
      PARAMETER (alfa = 5, beta = 10)
      
      delta = alfa + beta
      write (*,*) 'Resulta em', delta
      
      STOP
      END