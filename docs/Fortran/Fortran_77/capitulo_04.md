---
title: "4. Expressões e Atribuições"
---

# 4. Expressões e Atribuições

### Expressões

Uma expressão é uma combinação de operandos e operadores, como em `x + y` (onde `x` e `y` são operandos e `+` é o operador). O resultado de uma expressão torna-se um novo operando, permitindo *nesting* (expressões aninhadas).

Existem constantes de seis tipos: integer, real, double precision, complex, logical e character.  
- O uso de `E` em um valor, como `2.0E6`, implica que o valor anterior à `E` deve ser multiplicado por 10 elevado ao número à direita de `E` (ou seja, `2.0E6 = 2 * 10^6`).
- Valores complexos são expressos como um par de constantes (por exemplo, `(2, -3)` ou `(1., 9.9E-1)`), onde o primeiro é a parte real e o segundo a parte imaginária.
- Constantes lógicas são expressas como `.True.` ou `.False.` (os pontos são obrigatórios).
- Constantes de caractere, ou strings, são delimitadas por aspas simples (ex.: `'ABC'`, `'potato potato'`) e são sensíveis a maiúsculas e minúsculas.

### Atribuições

A sintaxe para atribuições é:

```
nome_da_variavel = expressão
```

O valor da expressão à direita é avaliado e atribuído à variável à esquerda.

### Conversão de Tipos

Quando diferentes tipos de dados são usados em uma expressão, pode ocorrer conversão implícita ou é necessário forçar a conversão usando funções como:
- `int` (para converter para integer)
- `real` (para converter para real)
- `dble` (para converter para double precision)
- `ichar` (converte caractere em inteiro)
- `char` (converte inteiro em caractere)

Note que `w = dble(x) * dble(y)` difere de `w = dble(x*y)` para variáveis reais `x` e `y`.
