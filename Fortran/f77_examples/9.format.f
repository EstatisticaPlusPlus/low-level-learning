c234567
      program main
      data m/10/, n/20/, x/2.5/, y/2.5/
      
      ! Escreve m com formato I2
      write (*,100) m
100   format (I2)
      
      ! Escreve n com formato inline
      write (*,'(I2)') n  
      
      ! Escreve x com formato F4.1
      write (*,300) x
300   format (F4.1)
      
      ! Escreve y com formato E8.2
      write (*,400) y
400   format (E8.2)
      
      STOP
      END