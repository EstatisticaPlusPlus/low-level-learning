# Operadores Lógicos
---
Operadores para operar sobre `bool`'s.

## Proposições
---
Uma proposição é uma afirmação que pode ter valor **verdadeiro** ou **falso**. Por exemplo:

$$ A := \text{A primeira letra de Brasil é B.}$$
$$B := \text{A primeira letra de Brasil é Z}$$
Acima, claramente, $A$ é **verdadeiro** e $B$ é **falso**.

É possível operar com as proposições com as operações **E**, **OU** e **NÃO**, gerando novas proposições:

$$ C := A \text{ \textbf{e} } B \text{ são verdadeiros} $$
$$ D := A \text{ \textbf{ou} } B \text{ são verdadeiros} $$
$$ E := A \text{ \textbf{não} é verdadeiro} $$
Em C++, naturalmente, guardamos o resultado de proposições em `bool`'s. Os operadores que utilizamos para operar sobre `bool`'s como operamos em proposições são os **operadores lógicos**.

## Operadores Lógicos
---
Operadores lógicos operam sobre bools. São eles **`&&`**, **`||`** e o **`!`**, respectivamente o **E**, **OU** e **NÃO**.

| a       | b       | a && b  | a \|\| b | !a      |
| ------- | ------- | ------- | -------- | ------- |
| `true`  | `true`  | `true`  | `true`   | `false` |
| `true`  | `false` | `false` | `true`   |         |
| `false` | `true`  | `false` | `true`   | `true`  |
| `false` | `false` | `false` | `false`  |         |

Note que
- Enquanto `&&` e `||` são operadores binários, recebendo dois operandos, `!` é um operador unário, agindo apenas sobre um operando.
- O `||` é um **OU inclusivo**, ou seja, basta que um dos operandos seja verdadeiro para o resultado ser verdadeiro.

Desses operadores, `!` tem a maior precedência, seguido por `&&` e `||`.

Caso operadores lógicos sejam utilizados em outros tipos, eles serão implicitamente convertidos para `bool`. Seguem exemplos de uso dos operadores lógicos:

```cpp
cout << (true && true) << '\n'; // 1
cout << (true && false) << '\n'; // 0
cout << (false && true) << '\n'; // 0
cout << (false && false) << '\n'; // 0

cout << (true || true) << '\n'; // 1
cout << (true || false) << '\n'; // 1
cout << (false || true) << '\n'; // 1
cout << (false || false) << '\n'; // 0

cout << (!true) << '\n'; // 0;
cout << (!false) << '\n'; // 1;
```
---
```cpp
cout << (1 && 2) << '\n'; // 1
cout << (1 && 0) << '\n'; // 0
cout << (1.5 && 'c') << '\n'; // 1
```
---
```cpp
bool a, b;
cout << (a && !b || b && !a) << '\n'; //OU exclusivo
```
---
```cpp
cout << (1 < 4 < 2) << '\n'; // 1, ERRADO
cout << (1 < 4 && 4 < 2) << '\n'; // 0
```

### Curto-circuito
---
Em alguns casos, uma operação com um operador lógico não precisa avaliar todos os seus operandos para seu resultado ser conhecido. Chamamos esse fenômeno de **curto-circuito**.

Ocorre curto-circuito quando
- O primeiro operando do `&&` é falso. O resultado já é determinado falso e o segundo operando não é avaliado. 
- O primeiro operando do `||` é verdadeiro. O resultado já é determinado verdadeiro e o segundo operando não é avaliado.

O uso inteligente do curto-circuito é muito útil em dois casos
- Uma dos operandos é muito mais custoso que o outro e, portanto, deve ser avaliado apenas se for necessário.
- Um dos operandos só pode ser avaliado se o resultado do outro for determinado.

```cpp
	int x;
	cin >> x;
	bool b = x < 100 || x/2 == 100;
```
Quando `x` for menor que 100, o programa nem avalia o lado direito do `&&`, evitando de fazer a operação custosa da divisão.

---
```cpp
string s;
cin >> s;
bool b = s.size() >= 3 && s[2] == 'z';
```
O programa apenas acessa o terceiro caractere da `string` se já souber que seu tamanho é ao menos 3, ou seja, que o caractere existe.