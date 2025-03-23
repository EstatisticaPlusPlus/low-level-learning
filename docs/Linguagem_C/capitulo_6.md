---
title: "6. Compilando com Otimização"
---

# 6. Compilando com Otimização

O GCC é um compilador otimizador que pode gerar arquivos executáveis mais rápidos e/ou menores, levando em consideração as características do processador alvo e a ordem das instruções. A otimização é um processo complexo que envolve a escolha da melhor combinação de instruções de máquina para cada comando de alto nível no código-fonte. Diferentes códigos devem ser gerados para processadores distintos, devido ao uso de linguagens de montagem e máquina incompatíveis. Além disso, cada tipo de processador possui características próprias, como o número de registradores disponíveis, que afetam a forma como o código é gerado. Ao compilar com otimização, o GCC leva em consideração todos esses fatores.

## 6.1. Otimização em Nível de Código-fonte

A otimização em nível de código-fonte melhora o desempenho de um programa por meio de alterações no código-fonte. Duas otimizações comuns são a eliminação de subexpressões repetidas e o _inline_ de funções.

### 6.1.1. Eliminação de Subexpressões Comuns

A eliminação de subexpressões repetidas evita a reavaliação de uma mesma expressão várias vezes. Por exemplo, a expressão

```c
x = cos(v).(1+sin(u/2)) + sin(w).(1-sin(u/2))
```

pode ser reescrita como

```c
t = sin(u/2); x = cos(v).(1+t) + sin(w).(1-t)
```

evitando a avaliação duplicada de `sin(u/2)`.

### 6.1.2. Inclusão de Função

O _inline_ de funções substitui uma chamada de função pelo seu próprio corpo, reduzindo a sobrecarga das chamadas de função. Por exemplo, a função `sq(x)` pode ser inlineada no _loop_:

```c
for (i = 0; i < 1000000; i++)
  sum += sq(i + 0.5);
```

Isso substitui o _loop_ interno pelo corpo da função `sq(x)`, melhorando o desempenho ao evitar chamadas de função.

### 6.1.3. *Trade-offs* de Velocidade e Espaço

Algumas formas de otimização podem aumentar a velocidade e reduzir o tamanho do programa simultaneamente, enquanto outras produzem código mais rápido em troca de um executável maior. Esse é o chamado *trade-off* de velocidade e espaço. Tais otimizações podem, inclusive, ser aplicadas de forma inversa, diminuindo o tamanho do executável em detrimento da velocidade de execução.

### 6.1.4. Desenrolamento de *Loops*

O desenrolamento de *loops* é uma otimização que aumenta a velocidade dos *loops* eliminando a condição de "fim do *loop*" em cada iteração. Ele permite atribuições diretas, sem a necessidade de testes, resultando em uma execução mais rápida. Contudo, o desenrolamento pode aumentar o tamanho do executável, exceto em *loops* muito curtos.

### 6.1.5. Agendamento

O agendamento é o nível mais baixo de otimização, onde o compilador determina a melhor ordem de execução das instruções individuais. Essa técnica melhora a velocidade do executável sem aumentar seu tamanho, mas exige memória adicional e tempo durante o processo de compilação.

## 6.2. Níveis de Otimização no GCC

O GCC oferece diferentes níveis de otimização (0 a 3) para controlar o tempo de compilação, o uso de memória do compilador e o *trade-off* entre velocidade e espaço no executável resultante. Os níveis de otimização são:

- `-O0` (padrão): Sem otimização, compilando de forma direta para facilitar a depuração.
- `-O1`: Otimizações comuns sem *trade-offs* significativos de velocidade e espaço.
- `-O2`: Otimizações adicionais sem aumentar o tamanho do executável.
- `-O3`: Otimizações mais custosas que podem aumentar o tamanho do executável.
- `-funroll-loops`: Desenrolamento de *loops*, aumentando o tamanho do executável.
- `-Os`: Otimizações para reduzir o tamanho do executável.

É importante considerar os custos das otimizações, como maior complexidade na depuração e maior tempo/memória de compilação. Geralmente, `-O0` é usado para depuração e `-O2` para desenvolvimento e implantação.

## 6.3. Otimização e Depuração

Com o GCC, é possível usar otimização em combinação com a opção de depuração `-g`. Muitos compiladores não permitem essa combinação. Ao usar depuração e otimização juntas, as reorganizações internas feitas pelo otimizador podem dificultar a compreensão do que está acontecendo ao examinar um programa otimizado no depurador. Por exemplo, variáveis temporárias geralmente são eliminadas e a ordem das instruções pode ser alterada. No entanto, quando um programa trava inesperadamente, qualquer informação de depuração é melhor do que nenhuma, portanto, o uso de `-g` é recomendado tanto para desenvolvimento quanto para implantação. Nas versões dos pacotes GNU, a opção de depuração `-g` é habilitada por padrão juntamente com a opção de otimização `-O2`.

## 6.4. Otimização e Avisos do Compilador

Quando a otimização é ativada, o GCC pode produzir avisos adicionais que não aparecem ao compilar sem otimização. Durante a otimização, o compilador realiza uma análise de fluxo de dados, examinando o uso de todas as variáveis e seus valores iniciais. Essa análise é a base para outras estratégias de otimização, como o agendamento de instruções, e pode detectar o uso de variáveis não inicializadas.

A opção `-Wuninitialized` (incluída em `-Wall`) avisa sobre variáveis que são lidas sem serem inicializadas. Ela só funciona quando o programa é compilado com otimização, pois é necessário que a análise de fluxo de dados esteja ativa. Considere o seguinte exemplo:

#### Exemplo

```c
int sign(int x)
{
  int s;
  if (x > 0)
    s = 1;
  else if (x < 0)
    s = -1;
  return s;
}
```

A função funciona corretamente para a maioria dos argumentos, mas tem um bug quando `x` é zero – nesse caso, o valor de retorno da variável `s` será indefinido. Compilar o programa apenas com a opção `-Wall` não produz nenhum aviso, porque a análise de fluxo de dados não é realizada sem otimização:

```bash
$ gcc -Wall -c uninit.c
```

Para gerar um aviso, o programa deve ser compilado com `-Wall` e otimização simultaneamente. Na prática, o nível de otimização `-O2` é recomendado para obter bons avisos:

```bash
$ gcc -Wall -O2 -c uninit.c
```

Isso detecta corretamente a possibilidade de a variável `s` ser usada sem ser definida. Embora o GCC geralmente encontre a maioria das variáveis não inicializadas, ele utiliza heurísticas que podem, ocasionalmente, deixar passar casos complicados ou emitir falsos avisos. Nesses casos, pode ser útil reescrever as partes relevantes do código para melhorar a legibilidade e eliminar o aviso.
