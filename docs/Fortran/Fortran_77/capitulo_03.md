---
title: "3. Variáveis, Tipos e Declarações"
---

# 3. Variáveis, Tipos e Declarações

### Regras de Nomenclatura

Variáveis em Fortran consistem em no máximo **6 caracteres** alfanuméricos, iniciando com uma letra, sem diferenciar maiúsculas e minúsculas. 

**Regras importantes:**
- Máximo de 6 caracteres
- Deve começar com uma letra (A-Z)
- Pode conter letras e números
- Não diferencia maiúsculas/minúsculas (`VAR`, `var`, `Var` são iguais)
- Palavras reservadas não podem ser usadas como nomes

**Palavras reservadas:** `program`, `real`, `stop`, `end`, `integer`, `character`, `logical`, `complex`, `double`, `precision`, `parameter`, `data`, `common`, `dimension`, `external`, `intrinsic`, `save`, `goto`, `if`, `then`, `else`, `endif`, `do`, `continue`, `call`, `return`, `function`, `subroutine`, `write`, `read`, `print`, `format`, `open`, `close`, `backspace`, `rewind`, `endfile`

### Tipos de Dados

Toda variável deve ser definida em uma declaração que estabelece seu tipo. Aqui está uma tabela comparativa:

| Tipo | Descrição | Tamanho | Faixa/Exemplo | Uso |
|------|-----------|---------|---------------|-----|
| `integer` | Números inteiros | 32 bits | ±2×10⁹ | Contadores, índices |
| `real` | Números reais (precisão simples) | 4 bytes | ~7 dígitos | Cálculos científicos |
| `double precision` | Números reais (precisão dupla) | 8 bytes | ~15 dígitos | Cálculos de alta precisão |
| `complex` | Números complexos | 8 bytes | (a, b) onde a,b são reais | Matemática complexa |
| `logical` | Valores lógicos | 4 bytes | `.TRUE.` ou `.FALSE.` | Condições |
| `character` | Caracteres/texto | Variável | `'texto'` | Strings |

### Declarações de Variáveis

```fortran
c234567
      integer i, j, k
      real x, y, z
      double precision pi
      complex c1, c2
      logical flag
      character*10 nome
      character*1 letra
```

### Boas Práticas

Embora o Fortran utilize regras implícitas se a variável não for declarada, é **boa prática** usar `implicit none` para evitar ambiguidades e forçar a declaração de todas as variáveis.

**Regras implícitas (evitar usar):**
- Variáveis começando com I-N são `integer`
- Outras variáveis são `real`

### Constantes (PARAMETER)

Para definir constantes, declara-se um parâmetro na sintaxe:

```fortran
      parameter (name = constant, ..., name = constant)
```

O parâmetro deve ser definido antes da primeira execução do código.

```fortran
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
```
*exemplo 2: tipagem*
