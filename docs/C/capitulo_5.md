---
title: "5. Componentes do Compilador"
---

# 5. Componentes do Compilador

## 5.1. Pré-processador

Como dito no capítulo inicial, o pré-processador é o componente do GCC responsável por processar e manipular o código-fonte antes da compilação começar. Ele lê o código-fonte e realiza um conjunto de operações, incluindo substituição de macros, inclusão de arquivos e compilação condicional. Essas operações são definidas por um conjunto de diretivas, que são comandos especiais iniciados pelo símbolo `#`.

### 5.1.1. Inclusão de Arquivos

A diretiva de pré-processamento `#include` é utilizada para incluir no código o conteúdo de um arquivo especificado. Existem duas notações:  
- `#include<arquivo>`: o pré-processador buscará o arquivo em algum diretório do sistema (geralmente em `/usr/include`, em sistemas Unix);  
- `#include"arquivo"`: o arquivo será buscado no diretório onde o código está localizado.

Geralmente, os arquivos incluídos possuem a extensão `.h` (de *header*), que são arquivos cabeçalhos contendo definições de macros e declarações de protótipos de funções padrão do C. Porém, é possível criar arquivos de cabeçalho personalizados e adicionar outros programas em C contendo outros `#include`, que serão tratados de maneira recursiva pelo pré-processador. Veja o exemplo:

#### main.c

```c
#include "preproc.c"

int main(){
  say_hello();

  puts("Digite um número para obter sua raiz quadrada:");
  scanf("%lf", &y);
  raiz = raiz_quadrada(y);
  printf("O valor da raiz quadrada desse número é: %lf\n", raiz);
  return 0;
}
```

#### preproc.c

```c
#pragma once
#include <stdio.h>
#include <math.h>

double y, raiz;

void say_hello(){
  puts("Hello!");
}

double raiz_quadrada(double x){
  return sqrt(x);
}
```

Ao compilar o programa **main.c**, o pré-processador acoplará o código de **preproc.c**. Note que foi necessário utilizar apenas o `#include "preproc.c"` no arquivo principal, pois esse arquivo já contém as diretivas necessárias para a execução do código. Caso ocorram múltiplos `#include` acidentais, a diretiva `#pragma once` garante que o respectivo arquivo seja lido apenas uma vez durante o processo de compilação. Para gerar um arquivo com o código pré-processado, utilize:

```bash
$ gcc main.c -E -o main_preproc.c
```

No final do arquivo gerado, estará o código dos dois arquivos (**preproc.c** e **main.c**).

### 5.1.2. Definição de Macros

Uma macro é um pedaço de código ao qual se atribui um nome, definida pela diretiva `#define`. Essa diretiva permite que você atribua um nome a um valor, uma expressão ou até mesmo a um bloco de código, facilitando a reutilização sem precisar repetir o código. Veja o exemplo:

#### main.c

```c
#include <stdio.h>

#define SQUARE(x) ((x) * (x))
#define NUM 10

int main()
{
  printf("The value of NUM is: %d\n", NUM);
  printf("The value of SQUARE(NUM) is: %d\n", SQUARE(NUM));
  return 0;
}
```

O pré-processador substitui as ocorrências das macros pelo seu conteúdo correspondente. Note que, como as macros não possuem escopo ou tipo explícito, elas realizam substituições simples. No exemplo, a macro `NUM` é interpretada como um inteiro (10) em tempo de compilação e `SQUARE(NUM)` executa a multiplicação. Ao compilar e executar, a saída será:

```bash
The value of NUM is: 10
The value of SQUARE(NUM) is: 100
```

### 5.1.3. Compilação Condicional

A compilação condicional permite que se execute uma parte do programa somente se uma certa macro estiver definida. Para isso, utilizamos as diretivas `#ifdef` e `#endif`. Por exemplo:

#### main.c

```c
#include <stdio.h>

int main()
{
#ifdef NUM
  printf("The value of NUM is: %d\n", NUM);
#else
  #error "A macro NUM não foi definida!";
#endif
  return 0;
}
```

Neste caso, se a macro `NUM` não estiver definida, a mensagem de erro `"A macro NUM não foi definida!"` será exibida e a compilação será interrompida. Entretanto, podemos definir a macro ao compilar o programa com a opção `-D`. Por exemplo:

```bash
$ gcc -Wall -DNUM=5 main.c -o main
$ ./main
The value of NUM is: 5
```

As definições de macros passadas na linha de comando possuem maior precedência, ou seja, são consideradas antes das definições presentes no código fonte. Um código similar pode ser feito usando `#ifndef` e `#undef`, como no exemplo a seguir:

#### main.c

```c
#include <stdio.h>
#undef NUM

int main(){
#ifndef NUM
  #error "A macro NUM não foi definida!";
#else
  printf("The value of NUM is: %d\n", NUM);
#endif
  return 0;
}
```

Também é possível utilizar a diretiva `#elif` em conjunto com `#ifdef` para simplificar o código. Por exemplo, se somente a macro `Z` estiver definida:

#### main.c

```c
#include <stdio.h>
//#define X 'x'
//#define Y 'y'
#define Z 'z'
int main(){
#ifdef X
  printf("The value of X is: %c\n", X);
#elif defined(Y)
  printf("The value of Y is: %c\n", Y);
#elif defined(Z)
  printf("The value of Z is: %c\n", Z);
#endif
  return 0;
}
```

### 5.1.4. Fornecendo Instruções

A diretiva `#pragma` é utilizada para fornecer instruções ao compilador. Essa diretiva não faz parte do padrão C e pode variar de acordo com o compilador e a plataforma. Ela é utilizada, por exemplo, para forçar que uma função seja _inline_:

#### Exemplo

```c
#pragma inline
int add(int a, int b){
  return a + b;
}
```

Nesse caso, a função `add` será substituída diretamente em sua chamada, evitando uma chamada de rotina. Também é possível controlar quais trechos do código serão otimizados:

#### Exemplo

```c
#pragma optimize("", off) // Desliga a otimização
int add(int a, int b){
  return a + b;
}
#pragma optimize("", on) // Liga a otimização novamente
```

Além disso, `#pragma` pode ser utilizada para determinar o alinhamento de estruturas de dados em memória. No exemplo abaixo, forçamos o alinhamento mínimo para a estrutura `s2`:

#### main.c

```c
#include <stdio.h>

struct{
  char c;  // 1 byte
  int i;   // 4 bytes
  double d; // 8 bytes
}s1;
#pragma pack(push, 1) // Força o alinhamento mínimo
struct{
  char c;  // 1 byte
  int i;   // 4 bytes
  double d; // 8 bytes
}s2;
#pragma pack(pop) // Restaura o alinhamento padrão

int main(){
  printf("The size of struct 1 is: %ld\n", sizeof(s1));
  printf("The size of struct 2 is: %ld\n", sizeof(s2));
  return 0;
}
```

Ao compilar e executar o código:

```bash
$ gcc -Wall main.c -o main
$ ./main
The size of struct 1 is: 16
The size of struct 2 is: 13
```

É possível ver que a primeira estrutura consome 3 bytes a mais, pois há preenchimento entre as variáveis `char` e `int` para garantir o alinhamento adequado (por exemplo, para que o `int` esteja alinhado a um endereço múltiplo de 4 e o `double` a um múltiplo de 8).

## 5.2. Compilador

*Falar sobre Árvore de Derivação, resumir o processo de compilação e técnicas, comentar sobre otimização (otimização já foi falada no capítulo seguinte, então é só comentar informações relevantes)...*

## 5.3. Montador

O montador é o componente responsável por traduzir um código de montagem em código de máquina, conforme mencionado na introdução. Além disso, ele lida com símbolos, diretivas de montagem e dados, organizando-os de forma executável. Como o GCC é compatível com diversas arquiteturas, ele suporta diretivas específicas que tratam de alinhamento dos dados, definição de constantes e strings, determinação de seções de código, dados e endereços de memória onde as instruções e/ou os dados serão posicionados, entre outras funções. Durante a montagem, o GCC resolve endereços, _offsets_ (deslocamentos), alinha dados, manipula macros e gera a tabela de símbolos e de realocação. Para ilustrar, considere o seguinte exemplo de código em C:

#### main.c

```c
#include <stdio.h>

int main() {
  printf("Olá, mundo!\n");
  return 0;
}
```

Ao compilar esse programa com o GCC, o compilador gera um código intermediário que é convertido em código de montagem. Esse arquivo de montagem pode ser gerado explicitamente com:

```bash
gcc -S hello_world.c
```

Isso criará um arquivo chamado **hello_world.s**. Para compilar esse arquivo de montagem e gerar um objeto, utilize:

```bash
gcc -c hello_world.s -o hello_world.o
```

*Continuar...*

## 5.4. Ligador

O ligador é o componente que atua na fase final da compilação. Ele combina os arquivos-objeto gerados, resolve símbolos definidos em outros arquivos-fonte e incorpora bibliotecas ao código para gerar o arquivo executável final. Enquanto na fase anterior os endereços dos dados e códigos são tratados de forma relativa, nesta etapa esses endereços são ajustados para refletir suas posições reais na memória.

*Continuar...*
