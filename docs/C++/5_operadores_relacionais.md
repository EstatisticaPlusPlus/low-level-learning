# Operadores Relacionais

Operadores para a comparação de informações.

## Comparações

Por vezes é útil a comparação entre duas informações armazenadas em um programa, seja para saber se um número é maior do que outro ou se um caractere vem antes no alfabeto que outro.

Os operadores que realizam comparações embutidos no C++ são chamados de **operadores relacionais**.

## Operadores Relacionais

Operadores relacionais realizam operações de comparação. São eles:

| Operador | Descrição          | Exemplo  |
| -------- | ------------------ | -------- |
| `==`     | Igualdade          | `a == b` |
| `!=`     | Diferença          | `a != b` |
| `>`      | Maior que          | `a > b`  |
| `<`      | Menor que          | `a < b`  |
| `>=`     | Maior ou igual que | `a >= b` |
| `<=`     | Menor ou igual que | `a <= b` |

Todos retornam um `bool` com o resultado da comparação. Seguem alguns exemplos de uso:

```cpp
cout << (1 == 1) << '\n'; // 1
cout << (1 == 2) << '\n'; // 0
cout << (1 != 1) << '\n'; // 0
cout << (1 != 2) << '\n'; // 1
````

A precedência dos operadores relacionais é inferior à precedência do `<<`. Por isso, as comparações devem estar entre parênteses para impressão:

```cpp
cout << (1 < 2) << '\n'; // 1
cout << (1 > 2) << '\n'; // 0
cout << (1 < 1) << '\n'; // 0
cout << (1 <= 2) << '\n'; // 1
cout << (1 >= 2) << '\n'; // 0
cout << (1 >= 1) << '\n'; // 1
cout << (1 <= 1) << '\n'; // 1
```

Funcionam com todos os tipos numéricos:

```cpp
cout << (1.0 < 2.0) << '\n'; // 1
cout << (3.14 > 3.15) << '\n'; // 0
```

```cpp
cout << ('a' < 'z') << '\n'; // 1
cout << ('b' < 'a') << '\n'; // 0
cout << ('@' < 'g') << '\n'; // 1
```

`char` também é um tipo numérico: a comparação utiliza os valores na tabela ASCII.

```cpp
cout << (1 + 2 < 1 + 1) << '\n';   // 0
cout << (1.5 + 4.2 > 4.3) << '\n'; // 1
```

Operadores aritméticos têm maior precedência que operadores relacionais.

```cpp
cout << (1 < 4 < 2) << '\n'; 
// Avaliação:
// 1 < 4 → true (1)
// 1 < 2 → true (1)
```

Os operadores `<` e `>` não funcionam em cadeia como na matemática. Para comparações em intervalo, combine com operadores lógicos:

```cpp
if (1 < x && x < 2) { /* ... */ }
```

## Comparação entre `floats` e `doubles`

Devido ao modo como números decimais são armazenados, resultados frequentemente perdem precisão:

```cpp
cout << fixed << setprecision(17) << 0.3       << '\n'; // 0.29999999999999999
cout << fixed << setprecision(17) << 0.1 + 0.2 << '\n'; // 0.30000000000000004
```

Comparações diretas podem ser inseguras:

```cpp
double a = 0.1 + 0.2;
double b = 0.3;

cout << fixed << setprecision(17) << a << '\n'; // 0.29999999999999999
cout << fixed << setprecision(17) << b << '\n'; // 0.30000000000000004

cout << (a == b) << '\n'; // 0
cout << (a != b) << '\n'; // 1
cout << (a < b)  << '\n'; // 0
cout << (a > b)  << '\n'; // 1
```

### Intervalo de confiança

Para comparar decimais com segurança, use um pequeno `eps`:

```cpp
double a   = 0.1 + 0.2;
double b   = 0.3;
double eps = 1e-9;

cout << (abs(a - b) < eps) << '\n'; // 1
cout << (abs(a - b) > eps) << '\n'; // 0
cout << (b - a > eps)      << '\n'; // 0
cout << (a - b > eps)      << '\n'; // 0
```

Aqui, `abs(x)` retorna o valor absoluto de `x`.

## Operadores relacionais e `strings`

Os operadores `==` e `!=` comparam strings caractere a caractere:

```cpp
cout << ("abc" == "abc") << '\n'; // 1
cout << ("bca" == "abc") << '\n'; // 0
cout << ("abc " != "abc") << '\n'; // 1
```

Os operadores `<` e `>` comparam em **ordem lexicográfica**:

```cpp
string a = "aaa", b = "aab";
cout << (a < b) << '\n'; // 1

string c = "baa", d = "acc";
cout << (c < d) << '\n'; // 0

string e = "abc", f = "abcd";
cout << (e < f) << '\n'; // 1

string g = "abc ", h = "abc";
cout << (g < h) << '\n'; // 0
```

### Comparação entre literais de string

Comparar literais (`"aaa" < "bbb"`) é **undefined behavior** (tipo `const char*`). Em vez disso, converta para `string` ou compare objetos `string`:

```cpp
cout << (string("aaa") < string("bbb")) << '\n'; // 1
cout << (string("aaa") < "bbb")           << '\n'; // 1
```

