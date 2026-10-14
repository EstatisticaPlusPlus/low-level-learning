
---
title: "7. Ponteiros"
---

# 7. Ponteiros

## 7.1. A Memória e as Variáveis

Para escrever programas com a linguagem C, é fundamental entender como os dados residem na memória do computador. Do ponto de vista do programador, a memória RAM pode ser vista como um enorme vetor de **bytes**. Cada byte possui um endereço único, representado por um número inteiro (geralmente em hexadecimal). Esses **bytes** podem ser manipulados individualmente como váriaveis do tipo **char**, ou em grupo, como variaveis do tipo **int**, **float**, **short int** ...

Quando declaramos uma variável, por exemplo `int idade = 25;`, o compilador realiza duas tarefas:
1. Reserva um bloco de bytes (neste caso, 4 bytes) em algum lugar da memória.
2. Associa o nome simbólico `idade` ao endereço inicial desse bloco.

Na prática, nós usamos o nome da variável para acessar o valor, mas por baixo dos panos, o processador e o compilador trabalham diretamente com o **endereço de memória** onde esse valor está guardado.

---

## 7.2. O que é um Ponteiro?

Um **ponteiro** é um tipo especial de variável. Enquanto uma variável comum armazena um dado (como um número ou uma letra), **um ponteiro armazena um endereço de memória**.

**Analogia**: Pense na memória como um grande conjunto de caixas postais. Cada caixa tem um número (endereço). Uma variável comum é o conteúdo dentro da caixa. Um ponteiro é um papel dentro de uma caixa que contém o número de *outra* caixa, dizendo exatamente onde encontrá-la.

Como o endereço de memória é um valor inteiro sem sinal, o ponteiro guarda esse número para referenciar indiretamente outra região da memória.

---
## 7.3. Sintaxe Básica (em C/C++)

Para manipular ponteiros, utilizamos operadores específicos:

- **Declaração**: `tipo *nome_do_ponteiro;` (ex: `int *p;` → lê-se "p é um ponteiro para um inteiro").
- **Operador de endereço (`&`)**: Retorna o endereço de uma variável. Ex: `p = &idade;` ( O ponteiro `p` passa a apontar para a variável `idade` ).
- **Operador de desreferência (`*`)**: Acessa o valor armazenado no endereço apontado. Ex: `printf("%d", *p);` (imprime o conteúdo do endereço guardado em `p`).


**Exemplo**

```c
int valor = 42;
int *ponteiro;       // Declaração
ponteiro = &valor;   // Ponteiro recebe o endereço de 'valor'
*ponteiro = 10;      // Altera o valor de 'valor' para 10 indiretamente
```

O tamanho da variável de um tipo ponteiro é igual ao tamanho de um endereço da memória, **não importa o tipo.**

```c
int *a;
int *b;

printf("o tamanho do ponteiro é : %lu\n", sizeof(a));
printf("o tamanho do ponteiro é : %lu\n", sizeof(a));
```
```bash
o tamanho do ponteiro é : 8
o tamanho do ponteiro é : 8
```
---
# 7.4. Porque ponteiros têm Tipos?

Diferentes tipos de dados requerem diferentes quantidades de bytes para armazenar os seus conteúdos. A declaração do tipo de dado para um ponteiro indica para o compilador quantos bytes serão necessarios para armazenar o endereço de memória de uma certa variável.
```c
char a = 'A';  //1 byte
int n = 1998; //4 bytes
float e = 2.718281; //4 bytes
```
Obs : O numero de bytes que um tipo de dado usa depende da arquitetura do seu computador.

---
# 7.5. Comandos de atribuição

Como qualquer outra variável, um ponteiro também pode ser usado para passar o seu valor para outro ponteiro, ou até mesmo para passar o conteúdo presente no endereço que ele armazena para outra variável.

```c
#include <stdio.h>

int main (){
  int x = 200, *p1, *p2; //p1 e p2 são ponteiros do tipo int
  p1 = &x; //p1 armazena o endereço de x
  p2 = p1; //p2 recebe o endereço de x por p1
  int y = *p1; //y recebe o valor do conteudo armazenado no endereço apontado por p1

  printf("x = %d, p1 = %p e p2 = %p\n", x, p1, p2);
  printf("x = %d, p1 = %p e p2 = %p\n", x, *p1, *p2);
  return 0;

}
```

```bash
x = 200, p1 = 0x7ffeaa46ab2c e p2 = 0x7ffeaa46ab2c
x = 200, p1 = 200 e p2 = 200
```

---
# 7.6. Uso dos operadores & e *

```c
int x = 1, y = 3, z[2];
int *p;
p = &x; //p aponta para x
y = *p; //y recebe o valor de x
*p = 0; //agora x possui o valor 0
p = &z[0]; //agora p aponta para z[0]
```
---
# 7.7. Inicialização de ponteiros
Existe um valor especial para ponteiros conhecido como **valor nulo** ou **NULL**. Esse valor indica que um ponteiro não aponta para nenhuma variável. Quando criamos um ponteiro devemos inicializa-lo atribuindo a ele o valor do endereço de uma variável ou o valor **Null**. Caso contrário, o ponteiro não inicializado passa a conter um valor de "lixo", ou seja, qualquer endereço de memória aleatória que estava sobrando na RAM.

Ponteiros não devem ser utilizados sem prévia inicialização. Para casos em que queremos inicializar os ponteiros com valores nulos é preciso incluir a biblioteca ``<stdlib.h>``:
```c
int *ponteiro = NULL;
```
Inicializar um ponteiro dessa forma é útil para quando queremos testar se o ponteiro está apontando para um endereço válido.

```c
int *ptr, a, b;
*ptr = 10 // Errado --> o ponteiro não foi inicializado
ptr = &a;
*ptr = 10; // correto
ptr = 10; // Errado --> a posição 10 pode ser um endereço
//inválido

ptr = &b; // correto
```

---
# 7.8. Aritmética de Ponteiros

É possível realizar um numero limitado de operações com ponteiros. É possível:

- Incrementar
- Decrementar
- Adicionar
- subtrair
- comparar
- designar

As operações ``++`` e ``--`` incrementam e decrementam 1 unidade no conteúdo do ponteiro;
```c
int x[3];
x[0] = 1; x[1] = 2; x[2] = 3;
int *p = &x[0]; //p aponta para x[0]
p++; // p agora aponta para x[1]
p--; // p volta a apontar para x[0]
```
É possível também incrementar e decrementar os valores contidos nos endereços de memória apontados pelos ponteiros.

```c
int x = 8;
int *p = &x;
(*p)++; //agora o valor de x é 9;

```


**Atenção** : se você decrementar ou incrementar sem desreferenciar o ponteiro, isso gerará um possível erro.
