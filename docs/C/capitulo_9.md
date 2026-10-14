---
title: "9. Introdução a Estrutura de Dados"
---

# 9. Estruturas de Dados

Um vetor organiza elementos do mesmo tipo em posições contíguas de memória, permitindo acessar diretamente cada elemento pelo seu índice:

```c
int valores[100];

valores[0] = 10;
valores[1] = 20;
```

Essa organização é eficiente para acesso direto, mas apresenta algumas limitações como:

- **Capacidade fixa:** um vetor como `int valores[100]` não pode ter o seu tamanho definido em tempo de execução, portanto, o seu tamanho é fixo e determinado em tempo de compilação.
- **Deslocamento de elementos:** para inserir ou remover um elemento no meio de uma sequência armazenada em um vetor, preservando sua ordem, pode ser necessário deslocar vários elementos, o que acaba sendo ineficiente e custoso.
- **Crescimento:** um vetor alocado dinamicamente pode ser redimensionado com `realloc`, mas isso pode exigir a transferência dos dados para uma nova região de memória. O realloc se torna cada vez mais custoso a medida que o vetor deslocado cresce.

**Estruturas de dados são formas de organizar, armazenar e manipular informações, escolhidas de acordo com as operações que o programa precisa realizar.**

Listas, pilhas e filas são exemplos de **estruturas lineares**, ou seja, os seus elementos se organizam de maneira sequencial, tendo cada elemento um único sucessor e predecessor.

Cada estrutura de dados pode ter diferentes implementações, sendo elas dinâmicas ou estáticas. 
As estruturas com implementação estática possuem os seus tamanhos predefinidos em tempo de compilação, enquanto as dinâmicas podem ter o seu tamanho alterado durante a execução dos programas.


Geralmente implementamos estruturas dinâmicas, na linguagem C, com estruturas chamadas `struct` (nós) e funções de alocação dinâmica.

>A seguir, veremos com mais detalhes as implementações de diferentes tipos de estruturas de dados.

## 9.1. “Nó” (*Node*)

A base dos dados registrados em estruturas de implementações dinâmicas é o **nó**.

Um nó é como uma “caixa” com dois compartimentos:

1. **O dado armazenado:** um número, um nome ou um registro com vários campos.
2. **Um ponteiro para o próximo nó:** o endereço do sucessor na sequência.

Em C, podemos representá-lo usando uma `struct`:

```c
typedef struct No {
    int valor;
    struct No *proximo;
} No;
```

Dentro da definição, usamos `struct No *proximo` para indicar que o campo aponta para outra estrutura do mesmo tipo.

Depois da definição, o nome simplificado `No`, criado pelo `typedef`, pode ser usado normalmente:

```c
No *inicio = NULL;
```

### 9.1.1. Criando um nó dinamicamente

Em vez de reservar espaço para muitos elementos de uma só vez, podemos alocar um nó quando precisarmos:

```c
#include <stdlib.h>

No *novo_no = malloc(sizeof *novo_no);

if (novo_no != NULL) {
    novo_no->valor = 10;
    novo_no->proximo = NULL;
}
```

Nesse código:

- `malloc` solicita memória ao sistema operacionao para a criação de um nó.
- `sizeof *novo_no` a função sizeof retorna o tamanho exigido pela estrutura nó.
- `novo_no` recebe o endereço da memória alocada.
- `novo_no->valor` acessa o campo `valor` do nó e atribui a ele um valor.
- `novo_no->proximo = NULL` faz com que o nó aponte para `Null`.

**É uma boa prática verificar se `malloc` retornou `NULL` antes de acessar a memória solicitada.** Esse retorno indica falha na alocação.

Em C, não é necessário converter explicitamente o retorno de `malloc` com `(No *)`, desde que `<stdlib.h>` esteja incluído.

### 9.1.2. Ordem lógica e ordem física

Em um vetor, os elementos ocupam posições contíguas no espaço de endereçamento do programa.

Em uma estrutura encadeada, os nós podem estar em endereços separados. A sequência é determinada pelos ponteiros.

Por exemplo:

| Endereço ilustrativo do nó | Valor | Endereço guardado em `proximo` |
|---|---:|---|
| `1000` | 10 | `3500` |
| `3500` | 20 | `2200` |
| `2200` | 30 | `NULL` |

Se `inicio` guardar o endereço `1000`, a sequência lógica será **10, 20, 30**, independentemente da ordem dos endereços.

**A ordem lógica é definida pelas ligações, ela não precisa coincidir com a ordem dos nós na memória.**

### 9.1.3. Liberando um nó

Quando um nó deixa de ser necessário, ele pode ser apagado e sua memória pode ser liberada:

```c
free(novo_no);
novo_no = NULL;
```

`free` libera a alocação, mas **não altera automaticamente o valor do ponteiro**. A atribuição de `NULL` evita que essa variável continue guardando um endereço que já não pode ser utilizado.

Se houver outros ponteiros para o mesmo nó, eles também deixam de poder ser usados para acessar aquele nó.

> Remover um nó de uma estrutura e liberar sua memória são ações diferentes: primeiro ajustamos as ligações, depois usamos `free` para devolver a memória ao alocador.

## 9.2. Estruturas Básicas

Listas, pilhas e filas diferem principalmente pelas regras de inserção, remoção e acesso.

| Estrutura | Inserção | Remoção | Regra principal |
|---|---|---|---|
| **Lista** | Em posições permitidas pela aplicação | Em posições permitidas pela aplicação | Sequência com acesso mais geral |
| **Pilha** | No topo | No topo | LIFO |
| **Fila** | No fim | No início | FIFO |

Nos exemplos a seguir, utilizaremos valores inteiros para simplificar. Os nós armazenam um `REGISTRO`, que pode conter uma chave e outros campos.

Os códigos usam os seguintes cabeçalhos:

```c
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
```

`<stdbool.h>` fornece `bool`, `true` e `false` em C99 a C17. As funções que recebem um ponteiro de saída, como `int *valor`, pressupõem que o chamador forneça um endereço válido.

### A. Listas Encadeadas (*Linked Lists*)

Uma lista simplesmente encadeada é uma sequência em que cada nó guarda o endereço do seu sucessor. O primeiro nó é identificado por um ponteiro de controle, normalmente chamado `inicio`.

No modelo apresentado, o último nó aponta para `NULL`.

As operações nessa estrutura incluem:

- Inicializar.
- Verificar se está vazia.
- Contar e exibir os elementos.
- Buscar um elemento.
- Inserir e excluir elementos.
- Reinicializar, removendo todos os elementos.


#### A.1. Implementação estática: 

**Uma lista encadeada pode ser implementada dentro de um vetor.**

Nesse caso, cada elemento guarda o **índice** do sucessor, em vez de um endereço de memória:

```c
#define MAX 50
#define INVALIDO (-1)

typedef struct {
    int valor;
    int proximo;
} ElementoEstatico;

typedef struct {
    ElementoEstatico elementos[MAX];
    int inicio;
    int dispo;
} ListaEstatica;
```

Os campos de controle são:

- `inicio`: índice do primeiro elemento válido.
- `dispo`: índice da primeira posição disponível para inserção.
- `INVALIDO`: indica que não existe próximo elemento.

O vetor mantém duas sequências lógicas:

1. A sequência de elementos válidos.
2. A sequência de posições disponíveis.

Inicialmente, todas as posições estão disponíveis:

```c
void inicializarListaEstatica(ListaEstatica *lista) {
    for (int i = 0; i < MAX - 1; i++) {
        lista->elementos[i].proximo = i + 1;
    }

    lista->elementos[MAX - 1].proximo = INVALIDO;

    lista->inicio = INVALIDO;
    lista->dispo = 0;
}
```

Na inserção, retiramos uma posição da sequência de disponíveis e a conectamos à sequência de elementos válidos.

Na exclusão, fazemos o contrário: desconectamos a posição da sequência válida e a devolvemos à sequência de disponíveis.

**Não é necessário deslocar os dados no vetor: alteramos os índices que representam as ligações.** Entretanto, a capacidade continua limitada a `MAX`.

#### A.2. Implementação dinâmica: encadeamento por ponteiros

Na implementação dinâmica, utilizamos o tipo `No` definido anteriormente:

```c
typedef struct {
    No *inicio;
} Lista;
```

Inicialização:

```c
void inicializarLista(Lista *lista) {
    lista->inicio = NULL;
}
```

Lista vazia:

```c
bool listaVazia(const Lista *lista) {
    return lista->inicio == NULL;
}
```

#### A.3. Percorrendo, contando e exibindo

Para percorrer a lista, usamos um ponteiro auxiliar:

```c
void exibirLista(const Lista *lista) {
    const No *atual = lista->inicio;

    while (atual != NULL) {
        printf("%d ", atual->valor);
        atual = atual->proximo;
    }

    printf("\n");
}
```

O comando:

```c
atual = atual->proximo;
```

faz o ponteiro avançar para o próximo nó.

Como usamos uma variável auxiliar, o ponteiro `inicio` permanece inalterado.

Para contar os elementos:

```c
int tamanhoLista(const Lista *lista) {
    int quantidade = 0;

    for (const No *atual = lista->inicio;
         atual != NULL;
         atual = atual->proximo) {
        quantidade++;
    }

    return quantidade;
}
```

Sem um contador armazenado na estrutura, é necessário visitar todos os nós. Portanto, contar os elementos tem custo **O(n)**.

#### A.4. Buscando um elemento

A busca percorre a sequência até encontrar o valor ou chegar ao final:

```c
const No *buscarLista(const Lista *lista, int valor) {
    const No *atual = lista->inicio;

    while (atual != NULL) {
        if (atual->valor == valor) {
            return atual;
        }

        atual = atual->proximo;
    }

    return NULL;
}
```

O retorno é:

- O endereço do nó, se encontrado.
- `NULL`, se o valor não estiver na lista.

No pior caso, a busca visita todos os nós: **O(n)**.

#### A.5. Inserindo em uma posição

Para inserir um nó no meio da lista, precisamos encontrar o nó que ficará imediatamente antes dele, chamado **predecessor**.

Se a sequência contém **10, 30**, inserir **20** entre eles exige:

1. Fazer o novo nó apontar para o nó de valor 30.
2. Fazer o nó de valor 10 apontar para o novo nó.

A ordem das atribuições importa:

```c
novo->proximo = anterior->proximo;
anterior->proximo = novo;
```

Se alterássemos primeiro `anterior->proximo`, poderíamos perder a referência para o restante da lista.

Uma implementação por posição, com índices começando em zero:

```c
bool inserirLista(Lista *lista, int valor, int posicao) {
    if (posicao < 0) {
        return false;
    }

    No *anterior = NULL;
    No *atual = lista->inicio;

    for (int i = 0; i < posicao; i++) {
        if (atual == NULL) {
            return false;
        }

        anterior = atual;
        atual = atual->proximo;
    }

    No *novo = malloc(sizeof *novo);

    if (novo == NULL) {
        return false;
    }

    novo->valor = valor;
    novo->proximo = atual;

    if (anterior == NULL) {
        lista->inicio = novo;
    } else {
        anterior->proximo = novo;
    }

    return true;
}
```

Essa função permite inserir:

- Na posição `0`, antes do primeiro elemento.
- Entre elementos existentes.
- Na posição igual ao tamanho da lista, depois do último elemento.

**Ajustar os ponteiros tem custo O(1), mas encontrar a posição pode custar O(n).**

#### A.6. Removendo de uma posição

Para remover um nó:

1. Localizamos o nó e seu predecessor.
2. Fazemos a ligação “pular” o nó removido.
3. Liberamos sua memória.

```c
bool removerLista(Lista *lista, int posicao, int *valor) {
    if (posicao < 0) {
        return false;
    }

    No *anterior = NULL;
    No *atual = lista->inicio;

    for (int i = 0; i < posicao; i++) {
        if (atual == NULL) {
            return false;
        }

        anterior = atual;
        atual = atual->proximo;
    }

    if (atual == NULL) {
        return false;
    }

    *valor = atual->valor;

    if (anterior == NULL) {
        lista->inicio = atual->proximo;
    } else {
        anterior->proximo = atual->proximo;
    }

    free(atual);
    return true;
}
```

A remoção do primeiro nó é um caso especial porque exige alterar `inicio`.

#### A.7. Reinicializando a lista

Na versão dinâmica, **não basta atribuir `NULL` a `inicio`**. Isso faria o programa perder acesso aos nós sem liberar suas alocações.

É necessário percorrer a lista e liberar cada nó:

```c
void reinicializarLista(Lista *lista) {
    No *atual = lista->inicio;

    while (atual != NULL) {
        No *apagar = atual;
        atual = atual->proximo;
        free(apagar);
    }

    lista->inicio = NULL;
}
```

Salvamos o endereço do próximo nó **antes** de liberar o atual.

### B. Pilhas (*Stacks*)

Uma pilha segue a regra **LIFO — Last In, First Out**: o último elemento a entrar é o primeiro a sair.

Pense em uma pilha de pratos: colocamos e retiramos pratos pelo topo.

As duas operações principais são:

- **Push:** inserir no topo.
- **Pop:** retirar do topo.

Se inserirmos **10, 20 e 30**, nessa ordem, as remoções retornarão **30, 20 e 10**.



#### B.1. Implementação estática

Utilizamos um vetor e um índice para indicar o topo:

```c
typedef struct {
    int elementos[MAX];
    int topo;
} PilhaEstatica;
```

As condições de controle são:

| Estado | Condição |
|---|---|
| Vazia | `topo == -1` |
| Com um elemento | `topo == 0` |
| Cheia | `topo == MAX - 1` |
| Quantidade de elementos | `topo + 1` |

Inicialização:

```c
void inicializarPilhaEstatica(PilhaEstatica *pilha) {
    pilha->topo = -1;
}
```

Inserção:

```c
bool pushEstatico(PilhaEstatica *pilha, int valor) {
    if (pilha->topo == MAX - 1) {
        return false;
    }

    pilha->topo++;
    pilha->elementos[pilha->topo] = valor;

    return true;
}
```

Remoção:

```c
bool popEstatico(PilhaEstatica *pilha, int *valor) {
    if (pilha->topo == -1) {
        return false;
    }

    *valor = pilha->elementos[pilha->topo];
    pilha->topo--;

    return true;
}
```

**Remover não exige apagar fisicamente o valor no vetor.** Ao diminuir `topo`, aquela posição deixa de fazer parte da pilha válida.

Para reinicializar, basta voltar `topo` para `-1`. A memória do vetor continua reservada.

#### B.2. Implementação dinâmica

Na versão encadeada, controlamos o endereço do nó do topo:

```c
typedef struct {
    No *topo;
} Pilha;
```

Inicialização e teste de pilha vazia:

```c
void inicializarPilha(Pilha *pilha) {
    pilha->topo = NULL;
}

bool pilhaVazia(const Pilha *pilha) {
    return pilha->topo == NULL;
}
```

Para verificar se está vazia, basta testar `topo`. Não é necessário percorrer os nós para contar os elementos.

#### B.3. Push: inserindo no topo

O novo nó aponta para o antigo topo e passa a ser o novo topo:

```c
bool push(Pilha *pilha, int valor) {
    No *novo = malloc(sizeof *novo);

    if (novo == NULL) {
        return false;
    }

    novo->valor = valor;
    novo->proximo = pilha->topo;
    pilha->topo = novo;

    return true;
}
```

Essa lógica também funciona com a pilha vazia: nesse caso, `novo->proximo` recebe `NULL`.

#### B.4. Pop: removendo do topo

Na remoção:

1. Guardamos o endereço do topo.
2. Copiamos o valor para o local informado pelo chamador.
3. Atualizamos o topo.
4. Liberamos o nó removido.

```c
bool pop(Pilha *pilha, int *valor) {
    if (pilha->topo == NULL) {
        return false;
    }

    No *apagar = pilha->topo;

    *valor = apagar->valor;
    pilha->topo = apagar->proximo;

    free(apagar);
    return true;
}
```

Exemplo de uso:

```c
Pilha pilha;
inicializarPilha(&pilha);

push(&pilha, 10);
push(&pilha, 20);

int retirado;

if (pop(&pilha, &retirado)) {
    printf("%d\n", retirado);  // Imprime 20
}
```

O retorno `bool` indica se a operação funcionou. O valor retirado é entregue por meio do ponteiro `&retirado`.

#### B.5. Exibição, contagem e reinicialização

Na pilha dinâmica:

- A exibição começa no topo e segue por `proximo`.
- A contagem percorre todos os nós, se não houver um contador.
- A reinicialização libera todos os nós e deixa `topo == NULL`.

Podemos reinicializar reutilizando `pop`:

```c
void reinicializarPilha(Pilha *pilha) {
    int descartado;

    while (pop(pilha, &descartado)) {
        // Cada chamada bem-sucedida libera um nó.
    }
}
```

Pilhas são usadas, por exemplo, no gerenciamento de chamadas de funções, na avaliação de expressões e em mecanismos de desfazer ações.


### C. Filas (*Queues*)

Uma fila segue a regra **FIFO — First In, First Out**: o primeiro elemento a entrar é o primeiro a sair.

É a lógica de uma fila de banco:

- Quem chega entra no fim.
- Quem é atendido sai pelo início.

As operações principais são:

- **Enqueue:** inserir no fim.
- **Dequeue:** retirar do início.

Se inserirmos **10, 20 e 30**, nessa ordem, as remoções retornarão **10, 20 e 30**.

O material apresenta uma fila estática circular e uma fila dinâmica com ponteiros para início e fim.

#### C.1. Implementação estática: fila circular

Uma implementação ineficiente poderia deslocar todos os elementos a cada retirada. A **fila circular** evita esse deslocamento.

Ela utiliza:

```c
typedef struct {
    int elementos[MAX];
    int inicio;
    int quantidade;
} FilaEstatica;
```

- `inicio`: índice do primeiro elemento válido.
- `quantidade`: número de elementos na fila.

Inicialização:

```c
void inicializarFilaEstatica(FilaEstatica *fila) {
    fila->inicio = 0;
    fila->quantidade = 0;
}
```

Tratamos o vetor como circular: depois do índice `MAX - 1`, voltamos ao índice `0`.

Isso é feito com o operador de resto `%`:

```c
proxima_posicao = (posicao_atual + 1) % MAX;
```

Por exemplo, se `MAX == 5`:

```c
(4 + 1) % 5 == 0
```

**A circularidade está no cálculo dos índices; o vetor continua sendo um bloco linear de memória.**

#### C.2. Enqueue na fila estática

A próxima posição de inserção é:

```c
(inicio + quantidade) % MAX
```

Implementação:

```c
bool enqueueEstatico(FilaEstatica *fila, int valor) {
    if (fila->quantidade == MAX) {
        return false;
    }

    int posicao = (fila->inicio + fila->quantidade) % MAX;

    fila->elementos[posicao] = valor;
    fila->quantidade++;

    return true;
}
```

#### C.3. Dequeue na fila estática

Para remover, basta copiar o primeiro valor, avançar `inicio` e diminuir a quantidade:

```c
bool dequeueEstatico(FilaEstatica *fila, int *valor) {
    if (fila->quantidade == 0) {
        return false;
    }

    *valor = fila->elementos[fila->inicio];

    fila->inicio = (fila->inicio + 1) % MAX;
    fila->quantidade--;

    return true;
}
```

Nenhum elemento precisa ser deslocado.

Para exibir os elementos em ordem, também usamos a circularidade:

```c
void exibirFilaEstatica(const FilaEstatica *fila) {
    for (int i = 0; i < fila->quantidade; i++) {
        int posicao = (fila->inicio + i) % MAX;
        printf("%d ", fila->elementos[posicao]);
    }

    printf("\n");
}
```

Para reinicializar, basta retornar `inicio` e `quantidade` a zero.

#### C.4. Implementação dinâmica

Na versão encadeada, mantemos dois ponteiros de controle:

```c
typedef struct {
    No *inicio;
    No *fim;
} Fila;
```

- `inicio`: aponta para o próximo nó a ser removido.
- `fim`: aponta para o último nó, permitindo inserir diretamente depois dele.

Inicialização:

```c
void inicializarFila(Fila *fila) {
    fila->inicio = NULL;
    fila->fim = NULL;
}
```

Quando a fila está vazia, ambos devem ser `NULL`.

#### C.5. Enqueue: inserindo no fim

```c
bool enqueue(Fila *fila, int valor) {
    No *novo = malloc(sizeof *novo);

    if (novo == NULL) {
        return false;
    }

    novo->valor = valor;
    novo->proximo = NULL;

    if (fila->inicio == NULL) {
        fila->inicio = novo;
    } else {
        fila->fim->proximo = novo;
    }

    fila->fim = novo;

    return true;
}
```

Existem dois casos:

1. **Fila vazia:** o novo nó será, ao mesmo tempo, início e fim.
2. **Fila com elementos:** o antigo último nó passa a apontar para o novo.

Manter o ponteiro `fim` evita percorrer toda a fila a cada inserção.

#### C.6. Dequeue: removendo do início

```c
bool dequeue(Fila *fila, int *valor) {
    if (fila->inicio == NULL) {
        return false;
    }

    No *apagar = fila->inicio;

    *valor = apagar->valor;
    fila->inicio = apagar->proximo;

    if (fila->inicio == NULL) {
        fila->fim = NULL;
    }

    free(apagar);
    return true;
}
```

**Se o último elemento for removido, também precisamos atualizar `fim` para `NULL`.**

Caso contrário, `fim` continuaria apontando para uma região de memória já liberada.

#### C.7. Exibição, contagem e reinicialização

Na fila dinâmica:

- A exibição percorre os nós do início até o fim.
- A contagem percorre todos os nós, se não houver um contador.
- A reinicialização libera os nós e deixa os dois ponteiros iguais a `NULL`.

```c
void reinicializarFila(Fila *fila) {
    int descartado;

    while (dequeue(fila, &descartado)) {
        // Cada chamada bem-sucedida libera um nó.
    }
}
```

Filas são usadas em sistemas de impressão, processamento de solicitações e comunicação entre componentes de um sistema.

## 9.3. Por que essa abordagem é eficiente?

A eficiência depende da operação realizada e da implementação escolhida. Estruturas encadeadas oferecem flexibilidade, mas também possuem custos.

### 9.3.1. Alocação conforme a necessidade

Uma estrutura dinâmica encadeada permite alocar nós à medida que os elementos chegam e liberá-los quando são removidos.

Isso evita reservar antecipadamente uma capacidade muito maior do que a quantidade de dados utilizada.

Entretanto, **não significa uso exato de memória nem ausência de desperdício**. Cada nó também ocupa espaço com:

- O ponteiro para o próximo nó.
- Possíveis bytes de preenchimento para alinhamento.
- Metadados e arredondamentos utilizados pelo alocador.

Por isso, armazenar a mesma quantidade de inteiros em uma lista encadeada geralmente exige mais memória do que em um vetor com capacidade ajustada.

### 9.3.2. Menor necessidade de um único bloco grande

Uma lista encadeada não exige um único bloco contíguo para armazenar todos os nós.

Isso pode facilitar o crescimento quando não há um bloco suficientemente grande disponível, mas existem regiões menores que atendem às alocações individuais.

**Essa organização não elimina a fragmentação.** Muitas alocações e liberações pequenas também podem contribuir para ela.

Além disso, a contiguidade exigida por um vetor se refere ao espaço de endereçamento do programa; em sistemas com memória virtual, suas páginas não precisam ser contíguas na RAM física.

### 9.3.3. Inserções e remoções sem deslocar os demais elementos

O principal benefício do encadeamento é poder inserir ou remover nós sem deslocar os outros dados.

Mas precisamos distinguir duas etapas:

1. **Encontrar o local da operação.**
2. **Alterar as ligações.**

Em uma lista simplesmente encadeada:

- Alterar as ligações custa **O(1)**, quando já temos as referências necessárias.
- Encontrar uma posição ou seu predecessor pode custar **O(n)**.

Portanto, inserir ou remover “no meio” de uma lista não é automaticamente uma operação O(1).

Nas pilhas e filas apresentadas, os ponteiros de controle já identificam os locais das operações principais, evitando essa busca.

### 9.3.4. Comparação dos custos das operações

**O(1)** indica uma quantidade de trabalho que não cresce com o número de elementos. **O(n)** indica trabalho que cresce proporcionalmente a esse número.

Na análise usual abaixo, consideramos separadamente o custo do alocador: `malloc` e `free` possuem custos próprios e não são operações instantâneas.

| Operação | Vetor sequencial | Lista simplesmente encadeada |
|---|---|---|
| Acessar pelo índice | O(1) | O(n) |
| Buscar valor sem ordenação | O(n) | O(n) |
| Inserir no início, preservando a ordem | O(n) | O(1) para os ajustes |
| Remover do início, preservando a ordem | O(n) | O(1) para os ajustes |
| Inserir após um nó já conhecido | O(n) no caso geral, por deslocamentos | O(1) para os ajustes |
| Remover após um predecessor já conhecido | O(n) no caso geral, por deslocamentos | O(1) para os ajustes |

A comparação com o vetor pressupõe armazenamento sequencial convencional. Uma fila circular, por exemplo, evita deslocamentos na retirada do início.

Para as implementações de pilha e fila estudadas:

| Operação | Implementação estática | Implementação dinâmica encadeada |
|---|---|---|
| Push ou enqueue | O(1), se houver capacidade | O(1) para os ajustes, mais alocação |
| Pop ou dequeue | O(1) | O(1) para os ajustes, mais liberação |
| Verificar se está vazia | O(1) | O(1) |
| Consultar quantidade | O(1), pelos campos de controle | O(n), sem contador |
| Exibir todos os elementos | O(n) | O(n) |
| Reinicializar | O(1), redefinindo controles | O(n), liberando os nós |

Podemos adicionar um campo `quantidade` às estruturas dinâmicas. Nesse caso, consultar seu tamanho passa a custar O(1), desde que toda inserção e remoção atualize corretamente esse contador.

### 9.3.5. Localidade de memória e velocidade prática

Vetores têm uma vantagem importante: seus elementos ficam próximos no espaço de endereçamento, o que costuma favorecer o uso da memória cache do processador.

Nós encadeados podem estar espalhados. Para descobrir o próximo endereço, o programa precisa ler o ponteiro armazenado no nó atual, e isso pode provocar mais acessos à memória principal.

Assim:

- **Vetores** costumam ser eficientes para acesso por índice e processamento sequencial.
- **Estruturas encadeadas** oferecem flexibilidade de crescimento e alterações de ligações sem deslocar os demais elementos.
- **Pilhas estáticas e filas circulares** combinam operações rápidas com a organização contígua dos vetores.

### 9.3.6. Cuidados com o gerenciamento da memória

Nas implementações dinâmicas, alguns cuidados são essenciais:

1. **Verificar o retorno de `malloc`.**
2. **Inicializar os campos do novo nó antes de conectá-lo à estrutura.**
3. **Preservar as referências necessárias antes de alterar as ligações.**
4. **Nunca acessar um nó depois de liberá-lo.**
5. **Não liberar a mesma alocação duas vezes.**
6. **Liberar todos os nós ao reinicializar ou encerrar o uso da estrutura.**
7. **Manter os ponteiros de controle consistentes**, especialmente ao remover o último elemento de uma fila.

A escolha da estrutura deve acompanhar as necessidades do programa: acesso direto, ordem de atendimento, inserções frequentes, limite de capacidade e consumo de memória.