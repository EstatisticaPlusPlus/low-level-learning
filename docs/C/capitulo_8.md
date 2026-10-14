
---
title: "8. Alocação Dinâmica de memória"
---

#8. Alocação Dinâmica de Memória


##8.1. O Limite das Variáveis Tradicionais

Como vimos anteriormente, quando declaramos variáveis comuns ou vetores (como int notas[50];), o compilador reserva o espaço necessário na memória de forma automática. Essa abordagem é chamada de alocação estática ou automática (geralmente armazenada em uma região da memória chamada Stack).

O grande problema aqui é a rigidez: o tamanho do vetor deve ser conhecido em tempo de compilação. Mas, e se não soubermos de antemão quantos dados precisaremos armazenar? E se o usuário quiser inserir 10 notas, e na próxima execução quiser inserir 1.000?

É aqui que entra a Alocação Dinâmica. Ela permite que o nosso programa solicite blocos de memória ao sistema operacional durante a execução do programa (em tempo de execução). Essa memória é reservada em uma região diferente, chamada Heap.

Para utilizar as funções de alocação dinâmica em C, é obrigatório incluir a biblioteca padrão:

```c
c
#include <stdlib.h>
```
##8.2. A função malloc

A função malloc (abreviação de memory allocation) é a principal ferramenta para solicitar memória. Ela pede ao sistema operacional um bloco de memória de um tamanho específico, em bytes.

A sintaxe básica é:

```c
void* malloc(size_t tamanho);
```

Como o malloc trabalha apenas com a quantidade de bytes, precisamos usar a função sizeof() para garantir que estamos pedindo o tamanho correto, independentemente da arquitetura do computador. Além disso, o malloc retorna um ponteiro genérico (void*), então fazemos um cast para o tipo de ponteiro que queremos.

Exemplo: Alocando um vetor de inteiros dinamicamente
```c
C
int *vetor;
int n = 5; // Poderia ser um valor digitado pelo usuário

// Aloca espaço para 5 números inteiros (5 * 4 bytes = 20 bytes)
vetor = (int*) malloc(n * sizeof(int));

// É fundamental verificar se a alocação funcionou
if (vetor == NULL) {
    printf("Erro: Memória insuficiente!\n");
    exit(1);
}

vetor[0] = 10; // Agora podemos usar 'vetor' normalmente
```
##8.3. A função free
Uma regra de ouro na linguagem C é: toda memória alocada dinamicamente deve ser liberada manualmente.

Diferente das variáveis comuns que desaparecem quando a função termina, a memória alocada no Heap continua reservada até que o programa acabe ou até que você diga explicitamente que não precisa mais dela. Se você perder o endereço dessa memória sem liberá-la, ocorrerá um Vazamento de Memória (Memory Leak), o que pode fazer seu programa consumir toda a RAM do computador.

Para devolver a memória ao sistema, usamos a função free:

```c
// Libera o bloco de memória apontado por 'vetor'
free(vetor);

// Boa prática: apontar o ponteiro para NULL após liberar
vetor = NULL;
```

Dica de segurança: Sempre aponte seu ponteiro para NULL logo após o free. Isso evita que você tente acessar acidentalmente um endereço de memória que não pertence mais ao seu programa (erro conhecido como Dangling Pointer).

##8.4. A função realloc
O que acontece se você alocou espaço para 5 inteiros usando malloc, mas durante a execução do programa você percebe que precisará armazenar 10?

Você não precisa criar um vetor novo, copiar os dados do antigo e apagar o primeiro. A linguagem C fornece a função realloc (re-allocation), que tenta redimensionar um bloco de memória previamente alocado, mantendo os dados que já estavam lá.

A sintaxe é:

```c
void* realloc(void* ponteiro_antigo, size_t novo_tamanho);
```
O realloc é inteligente:

Se houver espaço livre logo após o seu bloco atual na memória, ele apenas "estica" o bloco.

Se não houver espaço, ele encontra um novo lugar na memória que caiba o novo tamanho, copia os dados antigos para lá automaticamente, libera o bloco velho e retorna o novo endereço.

Exemplo de uso:

```c

// Suponha que 'vetor' já foi alocado com tamanho 5
int n_novo = 10;

// Tentamos expandir o vetor para caber 10 inteiros
int *vetor_expandido = (int*) realloc(vetor, n_novo * sizeof(int));

if (vetor_expandido == NULL) {
    printf("Erro: Não foi possível redimensionar a memória!\n");
    // O vetor original continua intacto e alocado, precisamos lidar com o erro.
} else {
    // Sucesso! Atualizamos nosso ponteiro original
    vetor = vetor_expandido;
}
```