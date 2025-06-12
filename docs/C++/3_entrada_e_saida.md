# Entrada e Saída
---
Troca de informações entre programa e usuário.

## Troca de dados
---
Programas podem permitir que usuários insiram informações, como nome de usuário, senha e cliques. Além disso, programas podem exibir informações, como sons, imagens e vídeos.

São chamadas de

- **Entrada**: informações que o usuário fornece ao programa.
- **Saída**: informações que o programa fornece ao usuário.

## Entrada e saída padrão
---
A **entrada e saída padrão** de um programa em C++ são, respectivamente, o arquivo de onde o programa obtém entradas e o arquivo onde o programa escreve suas saídas por padrão. São eles o **stdin** e o **stdout**.

Ambos estão, por padrão, associados ao terminal onde o programa for executado, isto é: o que for escrito no terminal é escrito na entrada padrão, e o que for escrito na saída padrão pode ser escrito no terminal e exibido ao usuário.

## Entrada
---
O comando **```cin```** solicita uma escrita na entrada padrão e o direciona para uma variável através do operador **```>>```**.
```cpp
int numero;
cin >> numero; // o que for lido da entrada padrão é armazenado em numero
```

O ```cin``` interpreta que espaços em branco, isto é, quebras de linha e espaços, separam duas entradas diferentes. Portanto, entradas lidas com o ```cin``` não devem conter espaços, pois serão interpretadas como duas entradas diferentes.

Para cada variável lida pelo ```cin```:
1. será checado se há conteúdo em ```stdin```.
    1. se não houver, realiza uma leitura no terminal e escreve em ```stdin```.
2. remove a primeira entrada de stdin e a armazena na variável.

Pode-se encadear ```>>```'s para a obtenção de diversas entradas. Os dois códigos a seguir funcionam de maneira idêntica.

```cpp
int num1, num2, num3;
cin >> num1 >> num2 >> num3;
```
---
```cpp
int num1, num2, num3;
cin >> num1;
cin >> num2;
cin >> num3;
```

Caso o ```cin``` tente armazenar uma valor em uma variável de tipo incompatível, ele entra em um estado de erro e quaisquer leituras dali em diante serão ignoradas.

## Saída
---
O comando ```**cout**``` escreve na saída padrão e recebe valores através do operador **```<<```**:
```cpp
cout << "Hello World!";
```

Também é possível escrever o valor de variáveis.
```cpp
int x = 5;
cout << x; //escreve 5 em stdout
```

Pode-se encadear ```<<```'s para escrever diversas saídas. Os comandos a seguir funcionam de maneira idêntica.

```cpp
int x = 45;
cout << "Hello " << x << " World!";
```
---
```cpp
int x = 45;
cout << "Hello ";
cout << x;
cout << " World!";
```
### Quebras de linha
---
Quebras de linha podem ser atingidas de duas maneiras: o caractere **```\n```** e o manipulador **```endl```**. Os comandos abaixo escrevem o mesmo conteúdo à saída padrão:
```cpp
cout << "Hello World!\n";
cout << "Hello World!" << endl;
```

A diferença entre os dois métodos é significativa e está em um processo que chamamos de **flush**.

O ```cout``` escreve as informações na saída padrão, isto é, no arquivo ```stdin```. A escrita das informações que estão em ```stdin``` para o terminal é o que chamamos de flush.

O caractere ```\n``` apenas escreve uma quebra de linha no ```stdin```. Já o ```endl```, além de escrever a quebra de linha, realiza um flush.

O processo de flush é bem lento e deve ser realizado apenas quando necessário. Ele é realizado quando:

- um ```endl``` é passado ao ```cout```.
- o programa finaliza.
- um ```cin``` está prestes a realizar uma leitura.
- Outras maneiras de invocar um flush explicitamente são utilizadas.

## Precisão de números decimais
---
Pode-se decidir o número de casas decimais de um número a ser impressa com os seguintes manipuladores:
```cpp
cout << fixed << setprecision(5) << 3.14 << '\n'; //imprime 3.14000 no terminal
```