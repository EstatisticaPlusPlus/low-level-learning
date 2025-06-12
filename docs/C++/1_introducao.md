# Introdução
---
Primeiro encontro com o básico de alguns conceitos de programação.

## Programa de computador
---
Um programa de computador é uma sequência de instruções que descreve tarefas a serem executadas por um computador. Uma receita de bolo está para um confeiteiro como um programa está para um computador.

## Linguagem de programação
---
Para escrever programas, utiliza-se linguagens especializadas em escrever instruções para computadores: as **linguagens de programação**. Nos concentraremos na linguagem **C++**.

Às instruções escritas em uma linguagem de programação damos o nome de **código**.

## Editor de texto
---
Um programa pode ser escrito em qualquer editor de texto, como Word, bloco de notas, Google Docs e WordPad, por exemplo. Porém, existem editores de texto especializados no desenvolvimento de programas, trazendo consigo ferramentas indispensáveis.

Desses, um editor muito comum entre programadores e simples de utilizar é o **Visual Studio Code**. Segue um [tutorial de como baixar e instalar o Visual Studio Code no Windows](https://www.youtube.com/watch?v=QT-YWT1-YI4).

## Compiladores
---
Apesar de utilizarmos uma linguagem de programação, o computador ainda não consegue executar instruções. Um computador entende apenas instruções em **linguagem de máquina**, codificadas apenas com sequências de caracteres 0 e 1. Este é o único formato em que um computador é capaz de executar uma instrução.

A **compilação** é o processo de transformar  instruções em uma linguagem de programação em um arquivo executável com instruções em linguagem de máquina.

Um **compilador** é um programa capaz de compilar um programa. O compilador de C++ que usaremos é o **G++**. Segue um [tutorial de como baixar e instalar o G++ no Windows](https://www.youtube.com/watch?v=BKsdbwGEsDM).

## Hello World
---
Começaremos analisando um programa simples que apenas exibe a frase "Hello World!" na tela:
```cpp
#include <iostream>

using namespace std;

int main() {
	cout << "Hello World!" << endl;
}
```

Ele estará no arquivo hello-world.cpp. Arquivos em c++ tem a extensão .cpp.
### ```main```
---
Primeiramente, analisemos:
```cpp
int main() {

}
```
Esta seção do programa é a **função ```main```**. Todo programa em C++ tem uma ```main```, ela é o ponto de partida de sua execução. Em outras palavras: ao executar um programa, os comandos entre as chaves da main partem a ser executados sequencialmente, de cima para baixo.

### ```cout```
---
Agora, vejamos o comando
```cpp
cout << "Hello World!" << endl;
```

O comando **```cout```**, acrônimo para "character output"(saída de caracteres), exibe caracteres na tela. Os caracteres a serem exibidos são passados para o comando através do **operador ```<<```**. Pode-se pensar que a informação segue o fluxo das setas.

O texto "Hello World!" é passado para o comando e, logo após, é passado o **```endl```**. O ```endl``` pula uma linha no texto sendo exibido. Caso mais caracteres fossem exibidos após ele, apareceriam na linha abaixo. Para "Hello" e "World" estarem em linhas diferentes, por exemplo, uma opção é:
```cpp
cout << "Hello" << endl << "World!" << endl;
```

Que pode ser separado em dois comandos com o mesmo efeito
```cpp
cout << "Hello" << endl;
cout << "World!" << endl;
```

Em C++, a grande maioria dos comandos terminam em **```;```** , assim como acima. Esquecer um ```;``` ao fim de um comando é um erro comum.

### Diretivas
---
Os comandos
```cpp
#include <iostream>

using namespace std;
```

São **diretivas**. Uma diretiva é um comando que é executado em **tempo de compilação**, alterando o comportamento da compilação.

#### ```#include```
---
A diretiva **```#include```** faz com que o compilador inclua, no lugar do comando, um código em outro lugar do computador, especificado logo após a diretiva. Este código pode ser um código seu ou uma **biblioteca**: uma coleção de código contendo funcionalidades que podem ser utilizadas no programa atual.

No programa Hello World incluímos a biblioteca **\<iostream\>**, que contém o comando ```cout```. Essa biblioteca faz parte da **biblioteca padrão do C++**.

Pode-se até incluir a biblioteca padrão inteira com o comando
```cpp
#include <bits/stdc++.h>
```

Porém, por tornar os arquivos muito grandes ao incluir código demais, isso não é uma **boa prática de programação**.

#### ```using namespace```
---
A diretiva ```**using namespace**``` nos permite não especificar o **espaço de nomes** dos comandos abaixo da diretiva.

Um espaço de nomes é análogo ao sobrenome do comando, criado para não haver ambiguidade entre comandos de duas bibliotecas diferentes com mesmo nome. ```**std**``` é o espaço de nomes da biblioteca padrão do C++. Caso a diretiva não fosse utilizada, o espaço de nomes do ```cout``` deveria ser especificada com ```::```
```cpp
#include <iostream>

int main() {
	std::cout << "Hello World!" << std::endl;
}
```

O compilador não reconhece um comando da ```std``` sem seu espaço de nomes ser identificado, seja pela diretiva ```using namespace``` ou pelo prefixo ```std::```. A compilação falhará caso um comando não seja reconhecido pelo compilador.

### Indentação
---
Indentação são espaços em branco antes de comandos. Geralmente, são usados para facilitar a visualização de que um comando está dentro de um par de chaves, como na ```main```.

Em algumas linguagens, a indentação é obrigatória, fazendo parte das regras de sintaxe da linguagem. Não é o caso do C++, onde espaços em branco adicionais não alteram o comportamento do programa. Os programas abaixo são todos iguais:
```cpp
#include <iostream>

using namespace std;

int main() {
	cout << "Hello World!" << endl;
}
```
---
```cpp
#include <iostream>

using namespace std;

int main() {cout << "Hello World!" << endl;}
```
---
```cpp
#include <iostream>

using namespace std; int main() {cout << "Hello World!" << endl;}
```

Note que a diretiva **#include** precisa de uma linha exclusiva, ela é uma excessão.

## g++
---
O **g++** é um dos compiladores de C++ mais utilizados. Seu uso básico no terminal será observado para o arquivo "hello-world.cpp".

Um programa pode ser compilado através do seguinte comando:
```
g++ hello-world.cpp
```

Um executável de nome **a.exe**(Windows) ou **a.out**(Linux e MacOS) em linguagem de máquina será criado na mesma pasta. Ele pode ser executado com os comandos:

Windows:
```
a.exe
```

Linux e MacOS:
```
./a.out
```

Também é possível especificar um nome personalizado para o executável, basta utilizar a opção **-o** do compilador.
```
g++ hello-world.cpp -o nome-personalizado.exe
```

Um executável com o nome "nome-personalizado.exe" será criado.

### Erros de compilação
---
Caso haja algum erro na **sintaxe** do código, isto é, se o código escrito pelo programador não está de acordo com as regras da linguagem, a compilação falhará e será exibido um **erro de compilação**. Segue um exemplo:
```cpp
#include <iostream>

using namespace std;  

int main() {
	cout << "Hello World!" << endl
}
```
---
```
mhjmbs@mhjmbs-ubuntu:~/Codes/examples$ g++ hello-world.cpp 
hello-world.cpp: In function ‘int main()’:
hello-world.cpp:6:35: error: expected ‘;’ before ‘}’ token
    6 |     cout << "Hello World!" << endl
      |                                   ^
      |                                   ;
    7 | }
      | ~
```
---
O erro demonstra que na linha 6, na posição 35, da esquerda para a direita, está faltando um ```;``` .

## Comentários
---
Comentários são ignorados pelo compilador e podem servir para diferentes propósitos dentro de um código. Dentre eles, estão
- Auxiliar na compreensão do código por um leitor terceiro.
- Rapidamente remover parte do código para fins de debugging

```cpp
//Isso é um comentário de uma linha

/*
Isso é
um comentário
de múltiplas linhas
*/
```
