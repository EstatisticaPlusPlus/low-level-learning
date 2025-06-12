# Fluxo de Controle 1 - Condicionais
---
Introdução ao fluxo de controle e condicionais.

## Fluxo de Controle
---
**Fluxo de controle** é a ordem em que comandos são executados em um programa. Com as ferramentas apresentadas até o momento, um programa sempre executa, linha a linha, todos os seus comandos de cima para baixo. Porém, existem ferramentas em linguagens de programação para modificar o fluxo de controle.

As duas categorias de comandos de fluxo de controle mais comuns nas linguagens de programação são **condicionais** e **loops**.

## Condicionais
---
**Condicionais** permitem que comandos sejam executados se, e somente se, determinada condição for verdadeira. São exemplos de uso da execução condicional de comandos:
- Logar um usuário somente se a senha inserida estiver correta.
- Desligar o computador somente se não houver programas abertos.
- Atualizar o computador somente se estiver carregando.

Os condicionais mais comuns no C++ são o **`if`**, o **`else`** e o **`else if`**.

### `if`
---
O `if` permite a execução de um comando se, e somente se, uma condição for verdadeira. Ele é sempre é da forma
```
if(condição) comando
```

A condição é uma expressão que deve retornar um `bool`, cujo valor ditará a execução do comando. Seguem exemplos de uso do if.

```cpp
if(1 < 5) cout << 1 << '\n'; // 1
if(1 > 5) cout << 1 << '\n'; // não executa
if(1 < 5 && 2 < 3) cout << "aqui\n"; // aqui
if(true) cout << "bla\n"; //bla
if(false) cout << "ble\n"; //não executa
```
---
```cpp
string senha = "12345";
string input;
cin >> input;
if(input == senha)
	cout << "Logado!\n";
```
É uma boa prática indentar os comandos para explicitar sua associação a um `if`.

---

Também é possível associar múltiplos comandos a um if com o uso de **`{}`**. Isso é feito na grande maioria dos casos.

```cpp
string senha = "12345";
string input;
cin >> input;
if(input == senha) {
	cout << "Logado!\n";
	int x, y;
	cin >> x >> y;
	cout << x + y << '\n';
}
```
---
```cpp
int x, y;
char op;
cin >> x >> y >> op;

if(op == '+') {
	cout << x + y << '\n';
}
if(op == '-') {
	cout << x - y << '\n';
}
if(op == '*') {
	cout << x * y << '\n';
}
if(op == '/') {
	cout << x / y << '\n';
}
```

Alguns consideram uma boa prática o uso de `{}` mesmo que o `if` contenha apenas um comando, afim de melhorar a legibilidade do código.

### `else`
---
Um `else` pode acompanhar um `if` para ser executado caso sua condição seja falsa. Nesse caso, todos os comandos no bloco do `if` serão pulados e o programa passará a executar os comandos no bloco do `else`. Se um `if` é um "se", o `else` é um "senão".

```cpp
string nome;
cin >> nome;
if(nome.size() <= 10) {
	cout << "OK!\n";
}else {
	cout << "Grande demais!\n";
}
```
---
```cpp
if(true) {
	cout << "Sempre executa!\n";
}else {
	cout << "Nunca executa!\n";
}
```

### `else if`
---
Um `else if` é uma condição que pode seguir de um `if` e deve ser avaliada apenas se a condição do `if` for falsa. Se o `if` é um "se", o `else if` é um "senão, se".

```cpp
string usuario;
cin >> usuario;

if(usuario == "wylson789") {
	cout << "Bem Vindo!\n";
}else if(usuario == "mhjmbs") {
	cout << "Ew...\n";
}
```
---
```cpp
int idade;
string olhos;
cin >> idade >> olhos;

if(40 <= idade && idade <= 55) {
	cout << "Você está na meia-idade\n";
}else if(olhos == "verdes") {
	cout << "Você tem olhos verdes\n";
}
```
Note que se a pessoa está na meia-idade e tem olhos verdes, o programa apenas dirá que ela está na meia-idade!

Múltiplos `else if`'s podem ser encadeados. Além disso, pode-se sempre adicionar um `else` ao final da cadeia de `else if`'s para ser executado caso nenhuma condição avaliada seja verdadeira.

```cpp
double altura;
cin >> altura;

if(altura < 1.90) {
	cout << "Você é normal\n";
}else if(altura < 2.00) {
	cout << "Você é muito alto\n";
}else if(altura < 2.10) {
	cout << "Você é alto demais\n";
}else {
	cout << "?????\n";
}
```
Note que ao avaliar `altura < 2.00`, já sabemos `altura` é ao menos `1.90`. Caso contrário, o programa teria executado o bloco do `if` e pulado para após o `else` para continuar sua execução.