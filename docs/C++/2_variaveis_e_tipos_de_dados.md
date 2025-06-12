# Variáveis e Tipos de Dados
---
Armazenamento de informações para uso do programa.

## Memória
---
A memória do computador é uma sequência de bilhões de espaços para guardar informação, cada um, necessariamente, preenchido ou com 0 ou com 1. Números, palavras e até imagens podem ser armazenados apenas com sequências de 0's e 1's. Um valor binário(0 ou 1) da memória é chamado de **bit** e 8 bits formam um **byte**.

| Nome     | Símbolo  | Tamanho |
| -------- | -------- | ------- |
| Bit      | b        | 1 bit   |
| Byte     | B        | 8b      |
| KiloByte | KB       | 1024B   |
| MegaByte | MB       | 1024KB  |
| GigaByte | GB       | 1024MB  |
| TeraByte | TB       | 1024GB  |

Uma das capacidades mais fundamentais de um programa é reservar um espaço da memória para o programa usar.

## Variáveis
---
Uma **variável** é um espaço de memória que seu programa reserva e **nomeia** para uso. 

Em algumas linguagens, não é preciso especificar o tipo de informação que será armazenada na variável(número, caractere, etc...). Porém, o C++ é uma linguagem **fortemente tipada**, isto é, os tipos das informações armazenadas nas variáveis deve ser conhecido em tempo de compilação.

Portanto, uma variável em C++ sempre tem um **tipo**, um **nome** e um **valor**.

Criar uma variável é chamado de **declarar** uma variável, e pode ser feito com um comando da forma
```
<tipo> <nome> = <valor>;
```

Para armazenar o número de estados brasileiros, por exemplo, pode-se escrever:
```cpp
int estados_brasileiros = 26;
```

Acima, declaramos uma variável do **tipo `int`**, que armazena números inteiros, cujo **nome** é "estados_brasileiros" e atribuímos um **valor** inicial de 26 a ela.

Note que em momento algum temos de lidar com valores binários. Os nomes e valores são todos traduzidos para linguagem de máquina no momento da compilação. Essa é a razão de existência das linguagens de programação.

Podemos, também, declarar múltiplas variáveis do mesmo tipo. Seus nomes devem ser separados por vírgula, como abaixo: 
```cpp
int num1 = 1, num2 = 34, num3 = -50;
```
---
```cpp
int num1 = 1;
int num2 = 34;
int num3 = -50;
```

Os códigos acima tem o mesmo efeito.
## Inicialização
---
A inicialização de uma variável é o armazenamento de um valor nela no momento de sua criação.

É possível declarar uma variável e não inicializá-la:
```cpp
int estados_brasileiros;
```

Porém, uma variável **sempre contém um valor**. O valor armazenado na variável, nesse caso, é o valor que estava naquele espaço da memória antes de sua declaração. Esse valor pode ser diferente a cada execução do programa, já que nem sempre o mesmo espaço de memória é reservado.

```cpp
int lixo;
cout << lixo << endl;
//pode imprimir valores diferentes a cada execução
```

A valores obtidos dessa maneira damos o nome de **lixo**. Bugs cuja a causa são variáveis não inicializadas podem ser difíceis de encontrar, deixar variáveis não inicializadas é uma má prática de programação.

## Nomes de Variáveis
---
Existem algumas restrições quanto a nomenclatura de variáveis. Nomes de variáveis:
- devem conter apenas letras, números e ```_```.
- não podem começar com um número.
- não podem ser palavras reservadas da linguagem, como ``if``, por exemplo.

Duas variáveis não podem ter o mesmo nome dentro do mesmo escopo. Por enquanto, o escopo é tudo o que está dentro da ```main```. Além disso, letras maiúsculas e minúsculas identificam variáveis únicas, isto é, a variável minha_variavel é diferente da variável Minha_variavel.

Por convenção, nomes de variáveis com mais de uma palavra são nomeadas, por todo o programa, com uma de duas formas:
- **snake_case**: letras minúsculas com palavras separadas por _
- **camelCase**: letras maiúsculas no início de cada palavra exceto a primeira
```cpp
int snake_case;
int camelCase;
```

## Tipos de dados
---
O tipo de uma variável determina:
- Quanta memória é reservada para a variável
- Quais operações podem ser realizadas na variável(soma, concatenação, etc...)

Seguem os tipos de dados mais simples do C++, os **tipos primitivos**.

### ```int```
---
O tipo **`int`** serve para o armazenamento de números inteiros. Segue alguns exemplos de declarações de int's.
```cpp
int x = 2;
int y = 3, z = -10;
int numero = 1000000;
```

### ```float``` e ```double```
---
Os tipos **`float`** e **`double`** servem para o armazenamento de números decimais. Segue alguns exemplos de declarações de float's e double's.
```cpp
float pi = 3.14;
double altura = 1.7012345;
double planetas = -8;
float distancia = 2e9; //podem ser declarados em notação científica
```

### ```char```
---
O tipo **`char`** serve para o armazenamento de caracteres. Segue alguns exemplos de declarações de char's.
```cpp
char c = 'a';
char caractere = 'c';
char quebra_de_linha = '\n'; //caractere de quebra de linha
```

Note que caracteres são escritos entre aspas simples ```**' '**```.

Internamente, o tipo ```char``` é armazenado similar a um ```int```. Na prática, um ```char``` é um ```int``` que tem um símbolo associado ao ser lido e escrito. Qual inteiro é associado a qual caractere é determinado pela **tabela ASCII**.

Esse comportamento, dentre outras coisas, permite que se inicialize caracteres de acordo com seus respectivos números.
```cpp
char a = 65; //'A' na tabela ASCII
```

### ```bool```
---
O tipo **`bool`** armazena um estado que pode ser **`true`**(verdadeiro) ou **`false`**(falso).
```cpp
bool b1 = true;
bool b2 = false;
```

### ```void```
---
O tipo **`void`** indica a ausência de tipo. Ele será útil apenas na seção de funções.

## Modificadores de sinal
---
Os modificadores **`signed`** e **`unsigned`** se aplicam aos tipos ```int``` e ```char``` e servem para tirar ou manter o sinal dos números.

Sua função é estender um pouco o intervalo de números que pode ser armazenado por um tipo ao retirar a necessidade de armazenar um bit de sinal. Porém, pode causar resultados inesperados com uso descuidado.

Por padrão, o modificador signed é usado na omissão de modificador de sinal.
```cpp
signed int i = -2;
unsigned int ui = 10;
unsigned char c = 'a';
unsigned char uc = '2';

unsigned int cuidado = -10; // armazena 4294967286
```

## Modificadores de tamanho
---
Como a memória do computador não é infinita, o espaço reservado para guardar cada variável também não é infinito. Consequentemente, os tipos ```int```, ```double```, ```char``` e qualquer outro tipo que represente valores numéricos não pode representar números infinitamente grandes, uma vez que não há espaço para guardar infinitos dígitos.

Afim de não usar memória demais, mas também não impossibilitar a representação de números maiores, foram criados **modificadores** para os tipos ```int``` e ```char```, que modificam a quantidade de memória reservada. Para números decimais, o tipo ```double``` foi criado com o mesmo propósito.

Modificadores de tamanho do ```int``` podem ser omitidos:
```cpp
short x = 3; // mesmo que short int
unsigned long long = 4; // mesmo que unsigned long long int
```

Segue uma tabela com os tipos primitivos e modificadores mais comuns, seus tamanhos e números que podem representar. Uma tabela completa pode ser encontrada [aqui](https://en.cppreference.com/w/cpp/language/types#Integral_types).

| Tipo                | Tamanho em bits | Intervalo(Aproximado) | Intervalo(Exato)                                        |
| ------------------- | --------------- | --------------------- | ------------------------------------------------------- |
| **`char`**          | 8               |                       | -128 to 127                                             |
| **`short int`**     | 16              | ± 3 × 10⁴             | -32768 to 32767                                         |
| **`int`**           | 32              | ± 2 × 10⁹             | -2,147,483,648 to 2,147,483,647                         |
| **`long long int`** | 64              | ± 9 × 10¹⁸            | -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807 |
| **`double`**        | 64              | ± 1.7 × 10⁻³⁰⁸        |                                                         |

## Modificadores de mutabilidade
---
Toda variável pode ter o modificador **`const`**, que impede que ela seja modificada no futuro. Naturalmente, variáveis ```const``` necessariamente devem ser inicializadas.
```cpp
const int x = 3;
const char y; //erro de compilação
```

## ```string```
---
O tipo **`string`** é o tipo do C++ dedicado ao tratamento de cadeias de caracteres. Ele já não é um tipo primitivo, mas é construído em cima do tipo ```char```. Seguem exemplos de declarações de strings:
```cpp
string nome = "Marcos";
string vazio = "";
string louco = "AA\nBB";
```

Note que o conteúdo de strings sempre estão entre aspas duplas **`" "`**.

O tamanho de uma `string` pode ser obtido com o comando **`.size()`**.
```cpp
string nome = "Marcos";
cout << nome.size() << '\n'; //Imprime 6 no terminal
```

Os caracteres de uma string são numerados, da esquerda para a direita, de 0 até `string.size()-1`. Pode-se acessar um caractere específico com colchetes ```[]``` indicando a posição do caractere desejado.
```cpp
string nome = "Marcos";
cout << nome[2] << '\n'; //imprime 'r' no terminal
```

## Literais
---
Note que em diversos momentos escreve-se valores no código. Esses valores recebem o nome de **literais**.
```cpp
short si = 1s; //literal de short
int i = 2; //literal de int
long l = 3l; //literal de long
long long ll = 4ll; //literal de long long
float f = 5f; //literal de float
double d = 6.0; //literal de double
char c = 'b'; //literal de char
string s = "Bla"; //literal de string
```

Caso uma variável seja inicializada com o literal de um tipo diferente, o compilador tentará converter de um tipo para outro. Tipos numéricos podem ser convertidos entre si.
```cpp
int a = 1ll;
int b = 1.4;
int c = 'A'; //65
int d = "1.56"; //ERRO DE COMPILAÇÃO
```
## Conversões de tipos
---
Existem dois tipos de conversões de tipos, **explícitas e implícitas**.

### Conversões implícitas
---
Conversões implícitas ocorrem na presença de um tipo onde deveria haver outro. O compilador converte o tipo para o adequado automaticamente.
```cpp
int x = 6.4;
```

Conversões entre os tipos inteiros(```char```, ```int``` e seus modificadores) funcionam bem desde que o valor esteja dentro do limite que o novo tipo consegue armazenar.

Conversões de tipos inteiros para tipos decimais(```float``` e ```double```) sempre funcionam.

Conversões de tipos decimais para tipos inteiros podem perder informação.
```cpp
int x = 6.4;
cout << x << '\n'; //Escreve 6 no terminal
```
Os dígitos após a vírgula são **truncados**.

Conversões de outros tipos para ```bool``` são ```false``` apenas se o valor for o valor **nulo** daquele tipo.
```cpp
bool int_to_bool = 0; //false
bool char_to_bool = '\0'; //false
bool double_to_bool = 0.0; //false
```

### Conversões explícitas
---
Conversões explícitas são conversões solicitadas pelo programa explicitamente.
```cpp
int x = char(6.4);
cout << x << '\n'; //Escreve 6 no terminal
```

Para converter entre tipos primitivos, basta o comando:
```
<novo_tipo>(valor)
```

Já para converter tipos primitivos para strings, a função **`to_string()`** é utilizada:
```cpp
double pi = 3.14;
string s_pi = to_string(3.14);
cout << s_pi[2] << '\n'; //imprime 4 no terminal
```

Para converter de ```string``` a tipos primitivos, uma vez que a string é compatível com o tipo a ser convertido, utiliza-se:
```cpp
int i = stoi("4"); //string -> int
long l = stol("5"); //string -> long
long long ll = stoll("1000000000000"); //string -> long long
float f = stof("3.14"); //string -> float
double d = stod("4.6565323"); //string -> double
```

Outras funções de conversões numéricas de string menos comuns podem ser encontradas na [documentação de strings do C++](https://en.cppreference.com/w/cpp/header/string).

A conversão de caracteres para ```int``` e vice-versa é feita de acordo com o caractere na tabela ASCII. Mas isso pode não ser o desejado.
```cpp
char c = '3';
int x = c; //51, o valor de '3' na tabela ASCII, mas pode-se desejar x = 3
```

Para obter o valor desejado, pode-se operar com os valores da tabela ASCII da seguinte maneira:
```cpp
char c = '3';
int x = c - '0'; //51 - 48 = 3

int i = 1;
char l = 'a' + i; //b, a segunda letra do alfabeto

int k = 8;
char d = '0' + k; //'8', o caractere do digito k
```
