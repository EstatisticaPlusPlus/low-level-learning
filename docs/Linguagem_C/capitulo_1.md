---
title: "1. Introdução"
---

# 1. Introdução

Esse capítulo visa estabelecer conceitos importantes que envolvem a linguagem C, compiladores e programação no geral.

## 1.1. Características da Linguagem C

C é uma **linguagem de programação compilada**, isto é, ao escrevermos o código fonte na própria linguagem, no caso em C, um programa chamado compilador reescreve esse código para a linguagem de máquina. Sendo assim, o compilador tem como entrada um arquivo com código fonte da linguagem e que gera como saída um **arquivo objeto**, com **código objeto**, que é ligado a outros arquivos objeto para gerar um **arquivo executável**. O arquivo executável é um arquivo que pode ser executado no computador alvo. Na próxima seção, serão dados mais detalhes sobre o processo de compilação de um arquivo em C. Abaixo seguem algumas características importantes da linguagem C:

- **Estruturada:** A programação estruturada (sucedida pela programação orientada a objeto) é um paradigma formado por três componentes:
  - Sequência: Uma tarefa é executada logo após a outra;
  - Decisão: A tarefa é executada logo após um teste lógico;
  - Iteração: A partir de um teste lógico, um trecho de código pode ser repetido finitas vezes.
- **Imperativa:** Descreve ações/instruções que o programa deverá executar. Ou seja, linguagens imperativas são programadas com uma sequência de comandos ordenada pelo programador;
- **Procedural:** Permite a construção de procedimentos que podem ser compartimentados e reutilizados, tornando partes do código mais independentes entre si;
- **Padronizada:** Garante que um mesmo código gere sempre o mesmo resultado, seja ele compilado e executado ou interpretado;
- **Fortemente Tipada:** Em C, os tipos das variáveis e funções precisam ser bem definidos durante toda a execução do programa. Com ponteiros do tipo `void`, é possível contornar essa restrição, mas isso não é aconselhável.

Abaixo segue uma tabela com os tipos de dados básicos da linguagem, onde a palavra-chave é usada para definir as variáveis e o formato indica a forma de capturar (por meio de funções como `scanf`) ou de imprimir (por exemplo, com `printf`):

**Tabela de dados básicos de C**

| PALAVRA-CHAVE | TIPO | BYTES | INTERVALO | FORMATO |
| ------------- | ---- | ----- | --------- | ------- |
| `char / signed char` | Caracter | 1 | -128 a 127 | `%c` |
| `unsigned char` | Caracter sem sinal | 1 | 0 a 255 | `%c` |
| `short / short int / signed short / signed short int` | Inteiro curto com sinal | 2 | -32768 a 32767 | `%hi ou %hd` |
| `unsigned short / unsigned short int` | Inteiro curto sem sinal | 2 | 0 a 65535 | `%hu` |
| `signed int / signed` | Inteiro com sinal | 2 | -32768 a 32767 | `%i ou %d` |
| `unsigned / unsigned int` | Inteiro sem sinal | 2 | 0 a 65535 | `%u` |
| `long / long int / signed long / signed long int` | Inteiro com sinal | 4 | -2147483648 a 2147483647 | `%li ou %ld` |
| `unsigned long / unsigned long int` | Inteiro sem sinal | 4 | 0 a 4294967295 | `%lu` |
| `long long / signed long long / long long int / signed long long int` | Inteiro muito lingo com sinal | 8 | −2^+63 a 2^+63 −1 | `%lli ou %lld` |
| `unsigned long long / unsigned long long int` | Inteiro muito lingo sem sinal | 8 | 0 a 2^+64 −1 | `%llu` |
| `float` | Ponto flutuante simples | 4 | 3.4 X 10^-38 a 3.4 X 10^+38 | `%f ou %F` |
| `double` | Ponto flutuante em precisao dupla | 8 | 1.7 X 10^-308 a 1.7 X 10^+308 | `%lf ou %lF` |
| `long double` | Ponto flutuante em precisão estendida | 16 | 3.4 X 10^-4932 a 3.4 X 10^+4932 | `%Lf ou %LF` |

Vale notar que esses tipos podem variar de máquina para máquina, sendo interessante imprimir os limites dos tipos presentes no cabeçalho **limits.h**. As padronizações (como ANSI e ISO) da linguagem também podem afetar certos tipos e, consequentemente, o funcionamento do código. Como C é muito popular, diversos compiladores foram construídos com características distintas. As próximas seções introduzirão o processo de compilação.

## 1.2. O Que É Um Compilador?

O compilador é um programa de computador responsável por reescrever o código fonte em código de máquina que poderá ser executado. Assim, ele recebe como entrada um arquivo com o código fonte e gera um arquivo executável.

Em outras palavras, o compilador traduz o código fonte de uma linguagem compreensível para os seres humanos para outra que o computador possa entender. Atualmente, o compilador possui muitas funcionalidades além da simples tradução: ele pode agrupar instruções de máquina em uma única linha de código, otimizar o código, gerar arquivos intermediários, tratar erros na programação e oferecer ferramentas de depuração. Os primeiros compiladores eram focados na tradução do código fonte e na junção das bibliotecas necessárias para a execução do código objeto, num processo chamado de ligação. Esses compiladores iniciais foram escritos em **Assembly** e, com o tempo, surgiram diversas ferramentas para a construção de compiladores, facilitando a criação de novas linguagens.

Com a evolução das linguagens e a necessidade de novas funcionalidades, os compiladores passaram a ter características variadas e métodos de funcionamento diferentes. A seguir, os principais tipos de compiladores:

- **Compilador *Ahead-of-time*:** Compila o código fonte antes da execução do programa, gerando um arquivo objeto com instruções de máquina nativas.
- **Compilador *Just-in-time*:** Compila o código durante a execução do programa. Na primeira execução, cada linha do código fonte é traduzida para instruções de máquina (ou para uma linguagem intermediária) e executada imediatamente; em execuções subsequentes, o código já compilado permite uma execução mais rápida.
- **Compilador Cruzado:** Gera um arquivo executável a partir do código fonte que pode ser executado em outras máquinas, útil para sistemas embutidos ou ambientes com múltiplas arquiteturas.
- **Compilador *Source-to-source*:** Tem como saída um código fonte de alto nível, em vez de instruções de máquina. Isso possibilita a criação de extensões sintáticas que são reescritas para o código alvo. Um exemplo é o TypeScript.

Existe também o interpretador, que traduz e executa o código fonte ou bytecode diretamente, sem gerar um arquivo objeto. Esse processo é geralmente mais lento, pois cada linha precisa ser interpretada em tempo real. Por fim, programas que convertem código Assembly para linguagem de máquina e vice-versa são chamados de montador (*assembler*) e desmontador (*disassembler*), respectivamente. A descompilação, que converte código de máquina para um código de alto nível, também é utilizada, especialmente em contextos de segurança.

## 1.3. GNU Compiler Collection

O GNU Compiler Collection (GCC) é uma coleção de compiladores *Ahead-of-time* do projeto GNU, criada em 1987. Ele oferece compiladores para linguagens como ADA, C++, Fortran, Java, Objective-C e Pascal, e possui compatibilidade com arquiteturas como ARM, x86 e AMD64 (x86-64). O GCC é o compilador padrão na maioria dos sistemas Linux, o principal compilador para o MAC OS e também pode ser utilizado no Windows por meio de ferramentas como MSYS2 e MinGW. Grande parte desses compiladores é escrita em C, inclusive o próprio compilador C, num processo chamado de **_bootstrapping_**. O foco aqui será o GNU C Compiler (GCC).

- **Pré-processamento:** Realizado pelo pré-processador, que trata todas as linhas que começam com `#`. As diretivas principais nessa fase são `#include` (para inclusão de arquivos de cabeçalho com definições e declarações) e `#define` (para definição de macros e constantes). Outras diretivas, como `#if...#else...#endif` e `#error`, também são utilizadas para controle condicional e exibição de mensagens de erro.
- **Compilação:** Nesta fase, o código é traduzido para assembly em vários níveis:
  1. **Análise léxica:** Verifica se os símbolos (variáveis, funções e palavras reservadas) estão corretos, removendo espaços e comentários. Erros como variáveis não definidas ou operadores inexistentes são identificados aqui.
  2. **Análise sintática:** Garante que as expressões seguem a gramática formal do C, verificando a organização correta dos símbolos.
  3. **Análise semântica:** Valida o sentido lógico das expressões, checando a consistência dos tipos, regras de visibilidade e contexto.
  4. **Otimização de alto nível:** Otimiza o código, eliminando redundâncias e trechos desnecessários.
- **Montagem:** Converte cada linha de assembly em código de máquina.
- **Ligação:** Na fase de ligação, as bibliotecas e todo o código necessário para a execução do programa são carregados e incorporados ao código objeto.

Vale ressaltar que muitas otimizações ficam desabilitadas por padrão e precisam ser ativadas por meio de *flags*. Após esta introdução aos conceitos básicos da linguagem C e do GCC, os próximos capítulos discutirão as formas de utilização deste compilador e as ferramentas que ele oferece.

