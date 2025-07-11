# Fluxo de Controle 1 - Condicionais

Introdução ao fluxo de controle e condicionais.

## Fluxo de Controle

**Fluxo de controle** é a ordem em que comandos são executados em um programa. Com as ferramentas apresentadas até o momento, um programa sempre executa, linha a linha, todos os seus comandos de cima para baixo. Porém, existem ferramentas em linguagens de programação para modificar o fluxo de controle.

As duas categorias de comandos de fluxo de controle mais comuns nas linguagens de programação são **condicionais** e **loops**.

## Condicionais

**Condicionais** permitem que comandos sejam executados se, e somente se, determinada condição for verdadeira. São exemplos de uso da execução condicional de comandos:
- Logar um usuário somente se a senha inserida estiver correta.
- Desligar o computador somente se não houver programas abertos.
- Atualizar o computador somente se estiver carregando.

Os condicionais mais comuns no C++ são o **`if`**, o **`else`** e o **`else if`**.

### `if`

O `if` permite a execução de um comando se, e somente se, uma condição for verdadeira. Ele sempre tem a forma:

```cpp
if(condição) comando
````

A condição é uma expressão que deve retornar um `bool`, cujo valor ditará a execução do comando. Seguem exemplos de uso:

```cpp
if (1 < 5) cout << 1 << '\n';            // 1
if (1 > 5) cout << 1 << '\n';            // não executa
if (1 < 5 && 2 < 3) cout << "aqui\n";    // aqui
if (true) cout << "bla\n";               // bla
if (false) cout << "ble\n";              // não executa
```

```cpp
string senha = "12345";
string input;
cin >> input;
if (input == senha)
    cout << "Logado!\n";
```

É boa prática indentar os comandos para explicitar sua associação ao `if`.

Também é possível agrupar múltiplos comandos com `{}`:

```cpp
string senha = "12345";
string input;
cin >> input;
if (input == senha) {
    cout << "Logado!\n";
    int x, y;
    cin >> x >> y;
    cout << x + y << '\n';
}
```

```cpp
int x, y;
char op;
cin >> x >> y >> op;

if (op == '+') {
    cout << x + y << '\n';
}
if (op == '-') {
    cout << x - y << '\n';
}
if (op == '*') {
    cout << x * y << '\n';
}
if (op == '/') {
    cout << x / y << '\n';
}
```

### `else`

Um `else` acompanha um `if` para ser executado caso sua condição seja falsa:

```cpp
string nome;
cin >> nome;
if (nome.size() <= 10) {
    cout << "OK!\n";
} else {
    cout << "Grande demais!\n";
}
```

```cpp
if (true) {
    cout << "Sempre executa!\n";
} else {
    cout << "Nunca executa!\n";
}
```

### `else if`

Um `else if` é avaliado apenas se a condição do `if` anterior for falsa:

```cpp
string usuario;
cin >> usuario;

if (usuario == "wylson789") {
    cout << "Bem Vindo!\n";
} else if (usuario == "mhjmbs") {
    cout << "Ew...\n";
}
```

```cpp
int idade;
string olhos;
cin >> idade >> olhos;

if (40 <= idade && idade <= 55) {
    cout << "Você está na meia-idade\n";
} else if (olhos == "verdes") {
    cout << "Você tem olhos verdes\n";
}
```

Note que se a pessoa está na meia-idade e tem olhos verdes, o programa apenas dirá que ela está na meia-idade!

Múltiplos `else if` podem ser encadeados, e você pode adicionar um `else` final para capturar qualquer outro caso:

```cpp
double altura;
cin >> altura;

if (altura < 1.90) {
    cout << "Você é normal\n";
} else if (altura < 2.00) {
    cout << "Você é muito alto\n";
} else if (altura < 2.10) {
    cout << "Você é alto demais\n";
} else {
    cout << "?????\n";
}
```

Ao avaliar `altura < 2.00`, já sabemos que `altura` é ao menos `1.90`, pois, caso contrário, o bloco do primeiro `if` teria sido executado e o restante pulado.

