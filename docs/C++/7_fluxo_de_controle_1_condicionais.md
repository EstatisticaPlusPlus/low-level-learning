# Fluxo de Controle 1 - Condicionais

Introdução ao fluxo de controle e condicionais.

## Fluxo de Controle

**Fluxo de controle** é a ordem em que comandos são executados em um programa. Com as ferramentas apresentadas até o momento, um programa sempre executa, linha a linha, todos os seus comandos. Porém, existem ferramentas para modificar esse fluxo de execução.

As duas categorias de comandos de fluxo de controle mais comuns nas linguagens de programação são **condicionais** e **loops**.

## Condicionais

**Condicionais** permitem que comandos sejam executados se, e somente se, determinada condição for verdadeira. Com eles, pode-se:

- Logar um usuário somente se a senha inserida estiver correta.
- Desligar o computador somente se não houver programas abertos.
- Atualizar o computador somente se estiver conectado à tomada.

O C++ disponibiliza como comandos condicionais o **`if`**, **`else if`**, **`else`** e **`switch`**.

### `if`

O `if` permite a execução de um comando se, e somente se, uma condição for verdadeira. Ele sempre tem a forma:

```cpp
if (condição) comando
````

A condição é uma expressão que deve retornar um `bool` (ou valor conversível para `bool`), cujo valor ditará a execução do comando. Seguem exemplos de seu uso:

```cpp
if (1 < 5) cout << 1 << '\n';            // 1
if (1 > 5) cout << 1 << '\n';            // não executa
if (1 < 5 && 2 < 3) cout << "aqui\n";    // aqui
if (true) cout << "bla\n";               // bla
if (false) cout << "ble\n";              // não executa
if (1+1) cout << "Ok\n";                 // Ok
if (1-1) cout << "Ok\n";                 // não executa
```

```cpp
string senha = "12345";
string input;
cin >> input;
if (input == senha)
    cout << "Logado!\n";
```

É boa prática indentar o comando associado a um `if`, explicitando esse relacionamento. Além disso, é possível agrupar múltiplos comandos em um **bloco** com `{}`. Isto é, onde pode-se inserir apenas inserir um comando, torna-se possível inserir vários. Essa prática é conveniente em vários dos comandos que veremos a frente.

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

### `else if`

Um `else if` é sempre precedido por um `if`. Ele é da forma.

```cpp
if (condição)
	comando
else if (condição)
	comando
````

Caso a condição do `if` seja verdadeira, ele executa seu comando e ignora o `else if`, pulando para seu fim. Caso contrário, o comando do `if` é ignorado e a condição do `else if` é avaliada, determinando se o programa executa seu comando ou não.

```cpp
string usuario = "User1";

if (usuario == "User1") {           // avalia para true
	cout << 1 << '\n';             // imprime
}else if (usuario == "User2") {     // pulado
	cout << 2 << '\n';             // pulado
}
```

```cpp
string usuario = "User2";

if (usuario == "User1") {           // avalia para false
	cout << 1 << '\n';             // pulado
}else if (usuario == "User2") {     // avalia para true
	cout << 2 << '\n';             // imprime
}
```

```cpp
string usuario = "User3";

if (usuario == "User1") {           // avalia para false
	cout << 1 << '\n';             // pulado
}else if (usuario == "User2") {     // avalia para false
	cout << 2 << '\n';             // pulado
}
```

Múltiplos `else if` podem ser encadeados. Caso a condição de um deles avalie para verdadeira, seu comando é executado e a execução pula para o fim do **último `else if` na cadeia`.

```cpp
int num = 3;
bool multiplo_de_3 = (num % 3 == 0);   // true
bool multiplo_de_5 = (num % 5 == 0);   // false

if (multiplo_de_3 && multiplo_de_5) {  // avalia para false
    cout << "Múltiplo de 3 e de 5\n";  // pulado
} else if (multiplo_de_3) {            // avalia para true
    cout << "Múltiplo de 3\n";         // imprime
} else if (multiplo_de_5) {            // pulado
    cout << "Múltiplo de 5\n";         // pulado
}
```

```cpp
int num = 15;
bool multiplo_de_3 = (num % 3 == 0);   // true
bool multiplo_de_5 = (num % 5 == 0);   // true

if (multiplo_de_3 && multiplo_de_5) {  // avalia para false
    cout << "Múltiplo de 3 e de 5\n";  // imprime
} else if (multiplo_de_3) {            // pulado
    cout << "Múltiplo de 3\n";         // pulado
} else if (multiplo_de_5) {            // pulado
    cout << "Múltiplo de 5\n";         // pulado
}
```

Note que, apesar de 15 ser múltiplo de 3, a primeira condição foi verdadeira, então o restante é pulado.

### `else`

Um `else` sempre vem precedido de um `if` ou `else if`.  Ele é da forma:

```cpp
<if ou else if> (condição)
	comando
else
	comando
````

Seu comando sempre é executado caso a condição anterior avalie para `false`:

```cpp
string nome;
cin >> nome;
if (nome.size() <= 10) {
    cout << "OK!\n";
}else {
    cout << "Grande demais!\n";
}
```

```cpp
int num = 17;
bool multiplo_de_3 = (num % 3 == 0);       // true
bool multiplo_de_5 = (num % 5 == 0);       // true

if (multiplo_de_3 && multiplo_de_5) {      // avalia para false
    cout << "Múltiplo de 3 e de 5\n";      // pulado
} else if (multiplo_de_3) {                // avalia para false
    cout << "Múltiplo de 3\n";             // pulado
} else if (multiplo_de_5) {                // avalia para false
    cout << "Múltiplo de 5\n";             // pulado
} else {
	cout << "Não é múltiplo de 3 nem 5\n"; // imprime
}
```

### `switch`

O `switch` permite pular a execução para um lugar a depender do valor de uma variável ou expressão **do tipo `int`**. Ele é da forma:

```cpp
switch (<variável ou expressão>) {
	case valor:
		comandos
		break;
	case valor:
		comandos
		break;
	...
}
```

A execução pula para o caso associado ao valor da variável ou expressão, pulando para o fim do `switch` ao atingir o `break`. É possível que nenhum dos casos explicitamente definidos seja igual ao valor desejado. Nesse caso, a execução continua após o `switch` normalmente.

```cpp
int num = 1;
switch (num) {
    case 1:
        cout << "Entrei no 1\n"; // imprime
        break;                   // pula para o fim do switch
    case 2:
        cout << "Entrei no 2\n";
        break;
}
```

```cpp
int num = 2;
switch (num) {
    case 1: 
        cout << "Entrei no 1\n";
        break;
    case 2:
        cout << "Entrei no 2\n"; //imprime
        break;                   //pula para o fim do switch
}
```

#### `default`

O comando `default` especifica um caso a ser executado se nenhum `case` corresponder à variável. Por convenção, o `default` é colocado como último caso, quando aparece.

```cpp
int num = 3;
switch (num) {
    case 1: 
        cout << "Entrei no 1\n";
        break;
    case 2:
        cout << "Entrei no 2\n";
        break;                   
	default:
		cout << "Não entrei acima\n" //imprime
		break;
}
```

#### declarações nos case's

Um erro de compilação é gerado quando ao se tentar declarar variáveis dentro de um caso do `switch` que não seja o último.

```cpp
switch (2) {
    case 1:
        int x = 0;
        cout << "Entrei no 1" << '\n';
        break;
    case 2:
	    //x está no escopo, mas não é declarada caso o case 2 execute
        cout << "Entrei no 2" << '\n';
        break;
}
```

Isso porque o escopo dos casos é o mesmo, assim, o caso 2 vê `x`, mas `x` nunca é declarada porque o caso 1 nunca foi executado. Isso pode ser consertado envelopando os casos em blocos:

```cpp
switch (2) {
    case 1: {
        int x = 0;
        cout << "Entrei no 1" << '\n';
        break;
    }
    case 2: {
        cout << "Entrei no 2" << '\n';
        break;
    }
}
```

Dessa forma, cada caso tem seu próprio escopo.

#### Fallthrough

Os `break`'s em cada caso não são obrigatórios. Se um caso não tiver um `break` ao seu fim, a execução continuará até o próximo caso, e o próximo, até encontrar um `break` ou chegar ao fim do `switch`. Isso é chamado de *fallthrough*.

```cpp
switch (2) {
    case 1:
        cout << "Entrei no 1" << '\n';
        break;
    case 2:
        cout << "Entrei no 2" << '\n'; //imprime
    case 3
	    cout << "Entrei no 2" << '\n'; //imprime
	    break;
    default:
        cout << "No default\n";
}
```