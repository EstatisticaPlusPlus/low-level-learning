---
title: "12. Format"
---

# 12. Format

A formatação é definida com o comando `write` seguido de um label que especifica o formato.

```fortran
c234567
      program main
      data m/10/, n/20/, x/2.5/, y/2.5/
      real m, n, x, y
      
      write (*,*) m
      write (*,*) n
      write (*,*) x
      write (*,*) y
      STOP
      END
```

A saída deste código seria algo como:

```
10.0000000
20.0000000
2.50000000
2.50000000
```

A formatação pode ser alterada seguindo o padrão:

```fortran
c234567      
      write(*,label) lista_de_variaveis
      label format-code	
```

Códigos comuns de formatação:
- **A:** string de texto
- **D:** números em double precision, notação exponencial
- **E:** números reais, notação exponencial
- **F:** números reais, formato fixo
- **I:** inteiro
- **X:** espaço horizontal
- **/**: salto de linha

Exemplo:

```fortran
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
```
*exemplo 9: format*
Saída esperada:

```
10
20
2.5
0.25E+01
```
