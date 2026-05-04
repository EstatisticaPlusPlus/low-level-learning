---
title: "9. Common Blocks"
---

# 9. Common Blocks

Common blocks permitem compartilhar variáveis entre subprogramas. O bloco comum deve ser declarado antes das execuções.

```fortran
      program main
      ! Declarações
      real alpha, beta
      common /coeff/ alpha, beta

      ! Statements
      stop
      end

      subroutine sub1(...)
      real alpha, beta
      common /coeff/ alpha, beta

      ! Statements
      return
      end

      subroutine sub2(...)
      real alpha, beta
      common /coeff/ alpha, beta

      ! Statements
      return
      end
```

Regras importantes:
- O bloco comum deve ser declarado antes da execução do código.
- Blocos comuns distintos devem ter nomes distintos.
- Uma variável não pode aparecer em dois blocos comuns diferentes.
- Variáveis devem ser listadas na mesma ordem, com o mesmo tipo e tamanho em todas as rotinas que utilizam o mesmo bloco comum.
- Arrays com dimensões variáveis não devem constar em blocos comuns.
