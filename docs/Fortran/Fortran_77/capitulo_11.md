---
title: "11. File I.O."
---

# 11. File I.O.

O comando principal para acessar um arquivo é:

```fortran
      open ([UNIT=]u [, IOSTAT=ios, ERR=err, STATUS=sta])
```

Especificadores comuns:
- **unidade ("u"):** valor inteiro único de 1 a 99 que identifica o arquivo.
- **status ("ios"):** variável inteira que retorna zero se a operação for bem-sucedida.
- **error ("err"):** determina para qual comando o programa deve saltar em caso de erro.
- **nome ("fname"):** nome do arquivo a ser acessado (string).
- **status ("sta"):** deve ser NEW, OLD ou SCRATCH; define se o arquivo já existe ou se deve ser criado e se será deletado após o fechamento.
- **final ("end"):** determina para qual comando o programa deve saltar ao chegar ao fim do arquivo (usado em `read` ou `write`).

Para fechar o arquivo, usa-se:

```fortran
      close ([UNIT=]u [, IOSTAT=ios, ERR=err, STATUS=sta])
```

Os comandos `read` e `write` são usados com o especificador de unidade obrigatório.

```fortran
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
```
*exemplo 8: Leitura e escrita (IO)*
