c234567
      program inpdat
      ! Este programa lê n pontos de um arquivo e os armazena em 3 arrays: x, y, z.
      
      integer nmax, u
      parameter (nmax=1000, u=20)
      real x(nmax), y(nmax), z(nmax)
      
      ! Abre o arquivo de dados
      open (u, FILE='points.dat', STATUS='OLD')
      
      ! Lê o número de pontos
      read(u,*) n
      if (n.GT.nmax) then
          write(*,*) 'Error: n = ', n, 'is larger than nmax =', nmax
          goto 9999
      endif
      
      ! Loop sobre os pontos
      do 10 i= 1, n
          read(u,100) x(i), y(i), z(i)
10    enddo
100   format (3(F10.4))
      
      ! Fecha o arquivo
      close (u)
      
      ! (Parte faltante para processar os dados)
      
9999  stop
      end