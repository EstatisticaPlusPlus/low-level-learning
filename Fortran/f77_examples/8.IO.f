c234567    
      program inpdat
      ! Este programa lê n pontos de um arquivo e os armazena em 3 arrays: x, y, z.
    
      integer nmax, u, n
      parameter (nmax=1000, u=20)
      real x(nmax), y(nmax), z(nmax), cx, cy, cz
      cx = 0.0
      cy = 0.0
      cz = 0.0
      ! Abre o arquivo de dados
      open (u, FILE='points.dat', STATUS='OLD')
    
      ! Lê o número de pontos
      read(u,*) n
      if (n .GT. nmax) then
         write(*,*) 'Error: n = ', n, ' is larger than nmax = ', nmax
      goto 9999
      endif
    
      ! Loop sobre os pontos
      do 10 i = 1, n
        read(u,100) x(i), y(i), z(i)
        ! Imprime cada ponto lido
        write(*,*) 'Ponto ', i, ': ', x(i), y(i), z(i)
10    continue
100   format (3F10.4)
    
      
    
      ! Calcula o centro geométrico (média das coordenadas)
      do i = 1, n
        cx = cx + x(i)
        cy = cy + y(i)
        cz = cz + z(i)
      enddo
      cx = cx / n
      cy = cy / n
      cz = cz / n

      ! Imprime o centro geométrico
      write(*,*) 'Centro geometrico: ', cx, cy, cz
      ! Fecha o arquivo
      close (u)
9999    stop
        end
