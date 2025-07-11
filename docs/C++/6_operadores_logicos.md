# Operadores Lógicos

Operadores para operar sobre `bool`'s.

## Proposições

Uma proposição é uma afirmação que pode ter valor **verdadeiro** ou **falso**. Por exemplo:

$$ A := \text{A primeira letra de Brasil é B.}$$  
$$ B := \text{A primeira letra de Brasil é Z.}$$  

Acima, claramente, $A$ é **verdadeiro** e $B$ é **falso**.

É possível operar com as proposições com as operações **E**, **OU** e **NÃO**, gerando novas proposições:

$$ C := A \text{ \textbf{e} } B \text{ são verdadeiros} $$  
$$ D := A \text{ \textbf{ou} } B \text{ são verdadeiros} $$  
$$ E := A \text{ \textbf{não} é verdadeiro} $$  

Em C++, naturalmente, guardamos o resultado de proposições em `bool`'s. Os operadores que utilizamos para operar sobre `bool`'s como operamos em proposições são os **operadores lógicos**.

## Operadores Lógicos

Operadores lógicos operam sobre bools. São eles:

- **`&&`** (E)  
- **`||`** (OU)  
- **`!`**  (NÃO)  

| a       | b       | a && b  | a \|\| b | !a      |
| ------- | ------- | ------- | -------- | ------- |
| `true`  | `true`  | `true`  | `true`   | `false` |
| `true`  | `false` | `false` | `true`   |          |
| `false` | `true`  | `false` | `true`   | `true`   |
| `false` | `false` | `false` | `false`  |          |

- `&&` e `||` são binários, `!` é unário.  
- `||` é OU inclusivo: basta um operando verdadeiro para o resultado ser verdadeiro.  

De precedência (maior para menor): `!` → `&&` → `||`.

Quando usados em outros tipos, esses operadores convertem implicitamente seus operandos para `bool`.

### Exemplos de uso

```cpp
cout << (true && true)   << '\n'; // 1
cout << (true && false)  << '\n'; // 0
cout << (false && true)  << '\n'; // 0
cout << (false && false) << '\n'; // 0

cout << (true || true)   << '\n'; // 1
cout << (true || false)  << '\n'; // 1
cout << (false || true)  << '\n'; // 1
cout << (false || false) << '\n'; // 0

cout << (!true)  << '\n'; // 0
cout << (!false) << '\n'; // 1
````

```cpp
cout << (1 && 2)     << '\n'; // 1
cout << (1 && 0)     << '\n'; // 0
cout << (1.5 && 'c') << '\n'; // 1
```

```cpp
bool a, b;
cout << (a && !b || b && !a) << '\n'; // OU exclusivo
```

```cpp
cout << (1 < 4 < 2)           << '\n'; // ERRADO: cadeia não funciona
cout << (1 < 4 && 4 < 2)      << '\n'; // 0
```

### Curto-circuito

Algumas expressões não avaliam todos os operandos:

* Para `&&`: se o primeiro for `false`, não avalia o segundo.
* Para `||`: se o primeiro for `true`, não avalia o segundo.

Útil quando:

1. Um operando é custoso e só deve ser avaliado se necessário.
2. O segundo operando depende do primeiro.

```cpp
int x;
cin >> x;
bool b1 = x < 100 || x/2 == 100; // evita divisão se x < 100

string s;
cin >> s;
bool b2 = s.size() >= 3 && s[2] == 'z'; // só acessa s[2] se size() >= 3
```

