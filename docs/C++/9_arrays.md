# Arrays

Declaração e uso de listas de elementos.

## Memória e arrays

A memória do computador é, de modo abstrato, uma sequência de bilhões de caixas, cada uma contendo ou o valor 1, ou o valor 0. Declarando variáveis de tipos primitivos, reservamos uma sequência contígua dessas caixas, cujo tamanho é exclusivamente dependente do tamanho do tipo que se deseja armazenar.

Porém, e se for necessário armazenar a idade de 1 milhão de usuários? É necessário que 1 milhão de variáveis sejam, uma a uma, declaradas pelo programador no código? Isso rapidamente se torna inviável e surge a necessidade de uma alternativa.

A solução está na alocação de listas de valores. Para uma lista de $3$ `int`'s, que ocupam $4$ bytes na memória, basta alocar $3 \cdot 4 = 12$ bytes contíguos na memória. Isso permite, a partir de um só nome, acessar qualquer uma das variáveis, apenas especificando o nome da lista e a posição do elemento desejado.

A leitura de um `int` é feita lendo os $4$ primeiros bytes a partir de seu endereço $E$. O mesmo vale para o primeiro elemento de uma lista de `int`'s. Mas como ler o 2° ou o 3° elemento? Basta ler os $4$ primeiros bytes a partir do endereço $E+4$, pulando o primeiro elemento. Da mesma forma, é possível ler qualquer elemento na posição $i$(a partir de $0$) da lista, basta ler os $4$ primeiros bytes a partir de:

$$E + 4 \cdot i$$

Para listas que armazenem tipos diferentes de `int`, basta adequar a leitura ao tamanho do tipo.

É dessa forma que, por baixo dos panos, o computador acessa os elementos de uma lista contígua de elementos na memória. A essa lista, dá-se o nome de **array**.

## Array

Um **array** (ou vetor) é uma lista de elementos de mesmo tipo contígua na memória do computador. Seu tamanho é imutável ao longo do programa.

## Declaração

Pode-se declarar um array em C++ inserindo chaves quadradas `[]` após o nome de uma variável em sua declaração.

Pode-se indicar o tamanho do array entre as chaves na declaração:

```cpp
int a[5]; //array de int's de tamanho 5;
```

Nesse caso, os elementos iniciais do array são lixo.

Pode-se indicar os elementos iniciais do array, sendo o tamanho deduzido a partir do número de elementos.

```cpp
int a[] = {1,200,32}; // array de int's de tamanho 3 e elementos {1,200,32}
```

Pode-se indicar tanto o tamanho do array como os elementos iniciais. Nesse caso, o tamanho do array tem que ser maior ou igual ao número de elementos iniciais inicializados. O restante dos elementos assumirá o valor nulo do tipo.

```cpp
int a[5] = {1,2,3}; // array de int's de tamanho {1,2,3,0,0}
```

Note que variáveis normais e arrays podem ser declarados na mesma linha, mas isso é desaconselhado para evitar confusão.

```cpp
int a[5], b; //a é array, b é int
```

## Acesso

Os elementos de um array podem ser acessados através de seus *índices*, ou seja, suas posições no array. Os índices iniciam a partir de 0: o primeiro elemento tem índice $0$, o segundo índice $1$, e assim por diante. Chaves quadradas contém o índice do array a ser acessado.

```cpp
char saldos[3] = {'a','j','m'};
saldo[0] = 'l'; //{'l','j','m'}
saldo[1] = 'u'; //{'l','u','m'}
saldo[2] = 'a'; //{'l','u','a'}
cout << saldo[0] << saldo[1] << saldo[2] << '\n'; // lua
```

```cpp
int numeros[4] = {1,2,3,0};
saldo[3] = saldo[0] + saldo[1] + saldo[2];
cout << saldo[3] << '\n'; // 6
```

Convém o uso de loops para o acesso de vários índices de um array.

```cpp
int arr[100];

// torna o array {0,1,2,...,99}
for(int i = 0; i < 100; i++) {
	arr[i] = i;
}

// imprime os números pares até 100: 0,2,4,...,98
for(int i = 0; i < 100; i+=2) {
	cout << arr[i] << ' ';
}
cout << '\n';
```

### Acessos indevidos

É possível tentar acessar um elemento além do tamanho do array:

```cpp
int arr[5];
cout << arr[10] << '\n';
```

Isso é comportamento indefinido, o programa está tentando acessar uma posição de memória que não reservou. Uma de duas coisas pode acontecer:

1. O elemento é acessado e se imprime um valor lixo
2. O sistema operacional mata o programa pela tentativa de acesso indevida.

Qual dos dois ocorrerá depende de quem for o dono da memória que se tenta acessar ou modificar.

## Impressão

Não é possível imprimir todos os elementos de um array de uma só vez, eles devem ser impressos, um a um, com um loop. Porém, ao se tentar imprimir um array, um número em hexadecimal é impresso em seu lugar.

```cpp
int arr[100];
cout << arr << '\n'; // 0x7ffedef36020
```

Esse número é o endereço de memória do array e, inclusive, varia de execução em execução de acordo com a escolha do endereço de memória que o sistema operacional faz para a reserva.

### Arrays de `char`

Arrays de `char` **são uma exceção**. A fim de armazenar e imprimir palavras, eles podem ser impressos de uma vez só.

```cpp
char word[] = {'S','o','l', '\0'};
cout << word << '\n'; // Sol
```

Note, porém, a presença de um caractere `'\0'` ao fim da palavra. Esse é o caractere nulo, ele é necessário para indicar ao `cout` o fim do array. Caso ele esteja ausente, o `cout` continuará imprimindo posições de memória após o fim do array até o primeiro caractere nulo que encontrar.

Arrays de `char` também tem uma conveniência que facilitam sua declaração, podendo ser declarados como palavras e já com o caractere nulo ao seu fim.

```cpp
char word[] = "Sol"; //inicializado para {'S','o','l', '\0'}
cout << word << '\n'; // Sol
```

## `size()`

O valor do tamanho de um array pode ser obtido com

```cpp
size(array)
```

Como em

```cpp
int arr[] = {1,2,3};
cout << size(arr) << '\n'; // 3
char word[] = "Carro";
cout << size(word) << '\n'; // 6
```