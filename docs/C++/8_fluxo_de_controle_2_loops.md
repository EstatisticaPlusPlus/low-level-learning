# Fluxo de Controle 2 - Loops
---
Uso de estruturas de repetição

## Loops
---
Uma **loop** ou uma **estrutura de repetição** é um comando de uma linguagem de programação que permite a execução das mesmas linhas de código repetidas vezes.

As estruturas de repetição mais comuns em linguagens de programação são o **`while`** e o **`for`**.

## `while`
---
O while executa o mesmo comando **enquanto sua condição for verdadeira**. Ele sempre é da forma.

`while(condição) comando`

Assim como o `if`, o comando pode ser substituído por uma sequência de comandos com o uso de `{}`. Seguem alguns exemplos do uso do `while`.
```cpp
int x = 0;
while(x < 5) {
	cout << x << ' ';
	x++;
}
cout << '\n';
//0 1 2 3 4
```
---
```cpp
int x = 8;
while(x != 1) {
	cout << x << ' ';
	x /= 2;
}
cout << '\n';
//8 4 2
```
---
```cpp
int x = 2;
while(x < 1000) {
	cout << x << ' ';
	x *= x;
}
cout << '\n';
//2 4 16 256
```
---
```cpp
while(true) {
	cout << a;
}
//aaaa...
```
Loops podem executar infinitamente, caso a condição permita.

---
```cpp
while(false) {
	cout << a;
}
//
```
Loops podem nunca executar, caso a condição permita.

---

```cpp
int x = 5;
while(x) {
	cout << x << ' ';
	x--;
}
cout << '\n';
//5 4 3 2 1
```

## `for`
---
O `for` faz o mesmo que o `while`, mas sua estrutura permite a declaração de uma ou mais variáveis do mesmo tipo e um comando para a alteração de valores de iteração em iteração. Ele sempre é da forma.

`for(declaração; condição; alteração) comando`

Quando o programa chega ao `for`, são executadas a declaração e a condição. Caso a condição seja verdadeira, o comando é executado. Após o comando, o comando de alteração é executado e é checada novamente a condição para adentrar o loop. Uma vez que a condição for avaliada falsa, o programa continua a execução após o `for`.

Seguem exemplos de seu uso.

```cpp
for(int i = 0; i < 5; i++) {
	cout << i << ' ';
}
cout << '\n';
//0 1 2 3 4
```
---
```cpp
for(int i = 0, j = 10; i != j; i++, j--) {
	cout << i << ' ' << j << '\n';
}
//1 9
//2 8
//3 7
//4 6
```

## Loops Aninhados
---
É possível aninhar loops dentro de outros loops

```cpp
for(int i = 0; i < 5; i++) {
	cout << i << '\n';
	for(int j = 0; j < 3; j++) {
		cout << "    " << j << '\n';
	}
}
//0
//  0
//  1
//  2
//1
//  0
//  1
//  2
//2
//  0
//  1
//  2
//3
//  0
//  1
//  2
//4
//  0
//  1
//  2
```

## `break`
---
O comando `break` pode forçadamente finalizar a execução de um loop:

```cpp
for(int i = 0; i < 5; i++) {
	if(i == 3) break;
	cout << x << ' ';
}
cout << '\n';
//0 1 2
```
---
```cpp
while(true) {
	string entrada;
	cin >> entrada;
	if(entrada == "PARE!") break;
}
```

## `continue`
---
O comando `continue` pode forçadamente pular a execução de uma iteração de um loop:

```cpp
for(int i = 0; i < 5; i++) {
	if(i == 3) continue;
	cout << i << ' ';
}
cout << '\n';
//0 1 2 4
```