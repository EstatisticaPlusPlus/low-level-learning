# Operadores Relacionais
---
Operadores para a comparação de informações

## Comparações
---
Por vezes é útil a comparação entre duas informações armazenadas em um programa, seja para saber se um número é maior do que outro ou se um caractere vem antes no alfabeto que outro.

Os operadores que realizam comparações embutidos no C++ são chamados de **operadores relacionais**

## Operadores Relacionais
---
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
```
A precedência dos operadores relacionais é inferior à precedência do `<<`. Por isso, é necessário estarem entre parênteses para impressão.

---
```cpp
cout << (1 < 2) << '\n'; // 1
cout << (1 > 2) << '\n'; // 0
cout << (1 < 1) << '\n'; // 0
cout << (1 <= 2) << '\n'; // 1
cout << (1 >= 2) << '\n'; // 0
cout << (1 >= 1) << '\n'; // 1
cout << (1 <= 1) << '\n'; // 1
```
---
```cpp
cout << (1.0 < 2.0) << '\n'; // 1
cout << (3.14 > 3.15) << '\n'; // 0
```
Funcionam com todos os tipos numéricos.

---
 ```cpp
 cout << ('a' < 'z') << '\n'; // 1
 cout << ('b' < 'a') << '\n'; // 0
 cout << ('@' < 'g') << '\n'; // 1
 ```
`char` também é um tipo numérico. A comparação compara seus respectivos números na tabela ASCII.

---
 ```cpp
 cout << (1 + 2 < 1 + 1) << '\n'; // 0
 cout << (1.5 + 4.2 > 4.3) << '\n'; // 1
 ```
 Operadores aritméticos tem maior precedência que operadores relacionais. 
 
---
 ```cpp
 cout << (1 < 4 < 2) << '\n'; // 1
 // 1 < 4 < 2
 // true < 2
 // 1 < 2
 // true
 ```
 Os operadores ```>``` e ```<``` não funcionam em cadeia como na matemática. Para usá-los dessa maneira devemos combiná-los com os operadores lógicos.
## Comparação entre `floats` e `doubles`
---
Devido ao modo como números decimais são armazenados internamente no computador, resultados de operações frequentemente perdem precisão.

```cpp
cout << fixed << setprecision(17) << 0.3 << '\n'; // 0.29999999999999999
cout << fixed << setprecision(17) << 0.1 + 0.2 << '\n'; // 0.30000000000000004
```

Por isso, comparações entre eles **não são seguras e podem obter resultados inesperados** e não devem ser realizadas. 

```cpp
double a = 0.1 + 0.2;
double b = 0.3;

cout << fixed << setprecision(17) << a << '\n'; // 0.29999999999999999
cout << fixed << setprecision(17) << b << '\n'; // 0.30000000000000004

cout << (a == b) << '\n'; // 0
cout << (a != b) << '\n'; // 1
cout << (a < b) << '\n'; // 0
cout << (a > b) << '\n'; // 1
```

### Intervalo de confiança
---
Para comparar decimais de forma segura, considera-se um intervalo de confiança. Isto é, se dois números são suficientemente próximos, considera-se que são iguais. É conveniente escolher um número bem pequeno.

```cpp
double a = 0.1 + 0.2;
double b = 0.3;

cout << fixed << setprecision(17) << a << '\n'; // 0.29999999999999999
cout << fixed << setprecision(17) << b << '\n'; // 0.30000000000000004

double eps = 1e-9;

cout << (abs(a - b) < eps) << '\n'; // 1
cout << (abs(a-b) > eps) << '\n'; // 0
cout << (b - a > eps) << '\n'; // 0
cout << (a - b > eps) << '\n'; // 0
```

```abs(x)``` é o valor absoluto de ```x```.

## Operadores relacionais e `strings`
---
Os operadores `==` e `!=` comparam strings caractere a caractere.

```cpp
cout << ("abc" == "abc") << '\n'; // 1
cout << ("bca" == "abc") << '\n'; // 0
cout << ("abc " != "abc") << '\n'; // 1
```

Os operadores `>` e `<` comparam as string em **ordem lexicográfica**: uma string `a` é menor que uma string `b` se no primeiro índice ```i```em que  `a[i] != b[i]`, `a[i] < b[i]`. Caso sejam iguais até o comprimento da menor string, a string de menor tamanho é menor(como se, ao final da menor string, fosse adicionado um caractere menor que qualquer outro).

```cpp
string a = "aaa";
string b = "aab";
cout << (a < b) << '\n'; // 1, a é menor que b

string c = "baa";
string d = "acc";
cout << (c < d) << '\n'; // 0, b é maior que a

string e = "abc";
string f = "abcd";
// 1, iguais nos caracteres comparados, mas a primeira string é menor
cout << (e < f) << '\n'; // 1

string g = "abc ";
string h = "abc";
// 0, iguais nos caracteres comparados, mas a primeira string é maior
cout << (g < h) << '\n'; // 0
```
### Comparação entre literais de string
---
A comparação entre literais de string é **comportamento indefinido**, isto é, as regras do C++ não definem o comportamento dessa comparação. Isso ocorre porque literais de string não são do tipo `string`, mas sim do tipo `const char*`. Ela nunca deve ser realizada, apesar de não gerar erro de compilação.

```cpp
cout << ("aaa" < "bbb") << '\n'; // undefined behavior
cout << (string("aaa") < string("bbb")) << '\n'; // 1
cout << (string("aaa") < "bbb") << '\n'; // 1, conversão implícita para string
```