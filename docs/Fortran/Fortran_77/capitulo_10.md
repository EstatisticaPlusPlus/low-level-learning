---
title: "10. Data e Block Statements"
---

# 10. Data e Block Statements

O `data` statement é usado para inicializar variáveis antes da execução do programa.

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
*exemplo 7.1: inicialização*

Outra forma:

```fortran
c234567
      program main
      data m,n/10,20/, x,y/2*2.5/
      real m, n, x, y
      
      write (*,*) m
      write (*,*) n
      write (*,*) x
      write (*,*) y
      STOP
      END
```
*exemplo 7.2: inicialização alt*
Com matrizes:

```fortran
c234567
      program main
      real A(10,20)
      data A/ 200 * 0.0/
      ...
```
*exemplo 7.3: inicialização matricial*

O exemplo acima inicializa uma matriz 10x20 com todos os 200 valores iguais a zero.
