---
title: "2. Compilando Programas"
---

# 2. Compilando Programas em C

## 2.1. Primeiros Passos

Um dos primeiros programas que muitos programadores aprendem a escrever é o famoso `"Hello, World!"`. A seguir, mostraremos como compilar esse programa em C utilizando o compilador GCC:

### helloworld.c
```c
#include <stdio.h>
 
int main() {
  printf("Hello, World!");
  return 0;
}
```

No entanto, o código-fonte ainda não pode ser entendido pelo computador, sendo necessário compilá-lo para gerar um arquivo executável. Para isso, usamos um compilador de C, como o GCC. No caso deste exemplo, o arquivo com o código fonte se chama **helloworld.c** e o executável, **hello**. A compilação é feita pelo terminal:

```bash
$ gcc helloworld.c -o hello
```

O parâmetro `-o` indica que queremos criar um executável com o nome **hello**. Além disso, é recomendável utilizar a _flag_ `-Wall` para habilitar avisos de possíveis problemas:

```bash
$ gcc -Wall helloworld.c -o hello
```

Para executar o programa, digite:

```bash
$ ./hello
```

Se tudo ocorrer bem, a mensagem `Hello, World!` será exibida no terminal.

## 2.2. Trabalhando com Múltiplos Arquivos

Em projetos em C, é comum dividir o código em múltiplos arquivos para melhorar a organização e reduzir o tempo de compilação. Por exemplo, para criar um programa que calcula o quadrado de um número, podemos usar:

### main.c
```c
#include <stdio.h>
#include "quadrado.h"

int main() {
  int x;
  printf("Digite um número: ");
  scanf("%d", &x);
  printf("O quadrado de %d é %d\n", x, calc_quadrado(x));
  return 0;
}
```

### quadrado.c
```c
int calc_quadrado(int x) {
  return x * x;
}
```

### quadrado.h
```c
int calc_quadrado(int x);
```

Se incluíssemos diretamente **quadrado.c** em **main.c**, teríamos duas definições da função `int calc_quadrado(int x)`, o que causaria um erro. Assim, usamos **quadrado.h** para declarar a função. Para compilar todos os arquivos de uma vez, execute:

```bash
$ gcc -Wall main.c quadrado.c -o programa
```

E para rodar o programa:

```bash
$ ./programa
```

Para evitar recompilar o programa inteiro após uma alteração, compile cada arquivo em um objeto:

```bash
$ gcc -Wall main.c -c
$ gcc -Wall quadrado.c -c
```

Isso gera os arquivos **main.o** e **quadrado.o**. Em seguida, ligue-os para criar o executável:

```bash
$ gcc main.o quadrado.o -o programa
```

Assim, você pode compilar apenas os arquivos modificados e ligar os objetos pré-compilados.

## 2.3. Utilizando Makefiles

Em projetos grandes com muitos arquivos, é comum que apenas alguns precisem ser recompilados após alterações. Para gerenciar essas dependências, utiliza-se o `make` com um **Makefile**. Esse arquivo especifica como os arquivos-fonte são compilados e ligados para criar o programa final.

A estrutura básica de um **Makefile** é:

```makefile
alvo: dependencia
  comando

dependencia:
  comando
```

Por exemplo, um **Makefile** simples para imprimir uma mensagem:

```makefile
saudacao:
	echo "Ola, mundo!"
```

Se o arquivo **saudacao** não existe, o comando é executado. Para forçar sua execução, chame:

```bash
$ make saudacao
```

Um exemplo mais complexo:

```makefile
hello: hello.o
  gcc hello.o -o hello

hello.o: hello.c
  gcc -Wall hello.c -c
```

O arquivo **hello.c** tem o seguinte conteúdo:

### hello.c
```c
#include <stdio.h>

int main() {
  printf("Hello, World!\n");
  return 0;
}
```

Nesse exemplo, o objetivo é criar o executável **hello**. Ele depende do objeto **hello.o**, que depende do arquivo fonte **hello.c**. Ao chamar `make`, o sistema:

1. Verifica se **hello** precisa ser recompilado.
2. Verifica se **hello.o** precisa ser recompilado.
3. Executa `gcc -Wall hello.c -c` se necessário.
4. Executa `gcc hello.o -o hello` para gerar o executável.

Usar um **Makefile** garante que somente os arquivos modificados sejam recompilados, otimizando o tempo de compilação e a gestão das dependências.
