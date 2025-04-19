10    CONTINUE
      PRINT *, 'Elemento', I, ':', a(I)
      I = I + 1
      IF (a(I) /= 9) THEN		
          GOTO 10
      END IF
      END