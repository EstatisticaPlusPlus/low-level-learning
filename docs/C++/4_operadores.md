# Operadores

Introdução ao uso de operadores e operadores aritméticos.

## Operações

Uma vez que se sabe guardar informações para o programa, tornam-se relevantes as operações que podem ser realizadas sobre elas.

Um símbolo que representa uma operação em um código recebe o nome de **operador**.

## Operadores Aritméticos

Operadores aritméticos realizam operações entre tipos numéricos:

| Operador | Descrição      | Exemplo        |
| -------- | -------------- | -------------- |
| `+`      | Adição         | `a + b`        |
| `-`      | Subtração      | `a - b`        |
| `*`      | Multiplicação  | `a * b`        |
| `/`      | Divisão        | `a / b`        |
| `%`      | Módulo (resto) | `a % b`        |
| `++`     | Incremento     | `a++` ou `++a` |
| `--`     | Decremento     | `a--` ou `--a` |

### Exemplos

```cpp
cout << 5 + 4 << '\n'; // imprime 9 no terminal
````

```cpp
int x = 5 % 2, y = 10;
cout << x + 4 * y << '\n'; // imprime 41 no terminal
```

```cpp
cout << 9 / 2 << '\n';   // imprime 4 no terminal
cout << 9.0 / 2 << '\n'; // imprime 4.5 no terminal
```

```cpp
int x = 5, y = 5;
cout << x++ << ' ' << ++y << '\n'; // imprime 5 e 6 no terminal
cout << x   << ' ' << y   << '\n'; // imprime 6 e 6 no terminal
```

A divisão entre inteiros sempre dá um resultado inteiro, desconsiderando o resto.
O operador módulo retorna o resto da divisão.
Os operadores de incremento e decremento modificam o valor da variável em 1 e podem vir antes ou depois da variável:

* Pós-fixado (`a++`): primeiro usa o valor, depois incrementa.
* Pré-fixado (`++a`): primeiro incrementa, depois usa o valor.

## Operações em Tipos Diferentes

Quando a operação envolve dois tipos primitivos diferentes, o compilador converte o tipo "mais simples" para o tipo "mais complexo":

```cpp
4.5 / 3     // converte 3 para 3.0 e divide
'A' + 4     // converte 'A' (65) e soma
```

Ordem de complexidade: `bool` → `char` → `int` → `double`.

## Operadores de Atribuição

O operador de atribuição `=` altera o valor de uma variável:

```cpp
int x = 10;
x = 18;
x = 9;
cout << x << '\n'; // imprime 9 no terminal
```

Também é possível combinar com operadores aritméticos:

```cpp
int x = 5;
x += 1;  // x vira 6
x -= 2;  // x vira 4
x *= 2;  // x vira 8
x /= 2;  // x vira 4
x %= 2;  // x vira 0
```

Equivalente a:

```cpp
int x = 5;
x = x + 1;
x = x - 2;
x = x * 2;
x = x / 2;
x = x % 2;
```

## Precedência e Associatividade

Quando múltiplos operadores aparecem em uma expressão, a ordem de avaliação pode alterar o resultado:

* **Precedência**: nível de prioridade dos operadores (por exemplo, `*`, `/`, `%` antes de `+`, `-`).
* **Associatividade**: ordem de avaliação entre operadores de mesma precedência (esquerda → direita ou direita → esquerda).

Para ver a tabela completa de precedência, consulte a referência do C++:
[https://en.cppreference.com/w/cpp/language/operator\_precedence](https://en.cppreference.com/w/cpp/language/operator_precedence)

### Exemplo de parênteses

```cpp
cout << 2 * 5 + 11 / 4       << '\n'; // 12
cout << 2 * ((5 + 11) / 4)   << '\n'; // 8
```

