# Operadores
---
Introdução ao uso de operadores e operadores aritméticos.

## Operações
---
Uma vez que sabe-se guardar informações para o programa, tornam-se relevantes as operações que podem ser realizadas sobre elas.

Um símbolo que representa uma operação em um código recebe o nome de **operador**.

## Operadores Aritméticos
---
Operadores aritméticos realizam operações aritméticas entre tipos numéricos. São eles

| Operador | Descrição      | Exemplo        |
| -------- | -------------- | -------------- |
| `+`      | Adição         | `a + b`        |
| `-`      | Subtração      | `a - b`        |
| `*`      | Multiplicação  | `a * b`        |
| `/`      | Divisão        | `a / b`        |
| `%`      | Módulo (resto) | `a % b`        |
| `++`     | Incremento     | `a++` ou `++a` |
| `--`     | Decremento     | `a--` ou `--a` |

Seguem alguns exemplos de uso

```cpp
cout << 5+4 << '\n'; //imprime 9 no terminal
```
---
```cpp
int x = 5%2, y = 10;
cout << x+4*y << '\n'; //imprime 41 no terminal
```
---
```cpp
cout << 9/2 << '\n'; //imprime 4 no terminal
cout << 9.0/2 << '\n'; //imprime 4.5 no terminal
```
---
```cpp
int x = 5, y = 5;
cout << x++ << ' ' << ++y << '\n'; //imprime 5 e 6 no terminal
cout << x << ' ' << y << '\n'; //imprime 6 e 6 no terminal
```
---

A divisão entre inteiros sempre dará um resultado inteiro, desconsiderando o resto da divisão.

O operador módulo retorna o resto da divisão de um número pelo outro.

Os operadores de incremento e decremento modificam o valor da variável em 1 e podem vir antes ou depois da variável a ser modificada. A diferença está no momento em que o incremento é realizado. Caso o operador venha depois da variável, é como se ele fosse aplicado apenas após a linha toda ser executada.

## Operações em Tipos Diferentes

Sempre que uma operação for realizada entre dois tipos primitivos diferentes, o compilador tentará converter o tipo mais "simples" para o tipo mais "complexo" para realizar a operação
```cpp
4.5/3 // converte 3 para 3.0 e divide
'A' + 4 // converte 'A' para 65 e soma
```

Os tipos, do mais simples para o mais complexo, são: ```bool``` ->```char``` -> ```int``` -> ```double```.
## Operadores de Atribuição
---
O operador de atribuição **```=```** serve para alterar o valor de uma variável após sua criação.
```cpp
int x = 10;
x = 18;
x = 9;
cout << x << '\n'; //imprime 9 no terminal
```
Pode-se compor o operador de atribuição com os operadores aritméticos. Os códigos abaixo funcionam de maneira idêntica.
```cpp
int x = 5;
x += 1; // x vira 6
x -= 2; // x vira 4
x *= 2; // x vira 8
x /= 2; // x vira 4
x %= 2; // x vira 0
```
---
```cpp
int x = 5;
x = x + 1; // x vira 6
x = x - 2; // x vira 4
x = x * 2; // x vira 8
x = x / 2; // x vira 4
x = x % 2; // x vira 0
```

## Precedência e Associatividade
---
Se múltiplos operadores fazem parte de uma mesma expressão, a ordem em que as operações são feitas pode alterar seu resultado.

A **precedência** é o nível de prioridade da operação em uma linguagem de programação. Operadores de maior precedência são executados primeiro em uma expressão.

A **associatividade** é a ordem em que operadores de mesma precedência são executados, podendo ser da esquerda para direita ou da direita para esquerda.

No caso dos operadores aritméticos, a ordem de precedência das operações é a mesma da matemática: multiplicações, divisões e operações de resto -> somas e subtrações.

Uma tabela completa da precedência de operadores pode ser encontrada [aqui](https://en.cppreference.com/w/cpp/language/operator_precedence).

É possível alterar a ordem de execução das operações ao envolvê-las em **`()`**:
```cpp
cout << 2*5+11/4 << '\n'; // 12
cout << 2*((5+11)/4) << '\n'; // 8
```
