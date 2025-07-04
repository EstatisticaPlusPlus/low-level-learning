---
title: "3. Flags do Compilador"
---

# 3. Bandeiras de Aviso do Compilador

O GCC compila programas usando o dialeto GNU da linguagem C como base, que incorpora o padrão ANSI C e várias extensões do GNU C. Essas extensões incluem recursos como declarações de variáveis no meio de um bloco de código, expressões com efeitos colaterais e construtores de atributos, entre outros. No entanto, programas válidos escritos em ANSI C podem conflitar com algumas extensões do GNU C.

Para lidar com esses conflitos, o GCC oferece várias opções de linha de comando, conhecidas como **bandeiras** ou **_flags_**, que permitem aos desenvolvedores controlar o comportamento do compilador ao compilar o código fonte. A flag `-ansi` é usada para desabilitar as extensões do GNU C que conflitam com o padrão ANSI C. A flag `-pedantic` desabilita todas as extensões do GNU C, não apenas aquelas que conflitam com o padrão ANSI.

No capítulo anterior, usamos a flag `-Wall` na compilação do nosso programa. Essa flag é uma combinação de várias flags de aviso especializadas que detectam erros comuns de programação. Cada uma das flags contidas em `-Wall` pode ser usada individualmente. Algumas dessas flags são:

- `-Wcomment`: Avisa sobre problemas de formatação em comentários, como comentários dentro de comentários.
- `-Wformat`: Avisa sobre o uso incorreto de formatação em *strings* em funções como `printf` e `scanf`.
- `-Wunused`: Avisa sobre variáveis que foram declaradas mas não foram usadas no programa.
- `-Wimplicit`: Avisa sobre funções que foram usadas sem serem declaradas, o que pode acontecer se esquecer de incluir o arquivo de cabeçalho.
- `-Wreturn-type`: Avisa sobre funções que não retornam nenhum valor mas que não foram declaradas como `void`.

O GCC também inclui outras flags de aviso úteis, como:

- `-W`: Uma flag geral, semelhante a `-Wall`, que avisa sobre diversos erros comuns.
- `-Wconversion`: Avisa sobre conversões implícitas de tipo, como entre `float` e `int`, que podem causar resultados inesperados.
- `-Wshadow`: Avisa sobre a declaração de variáveis em um escopo em que elas já foram declaradas.
- `-Wtraditional`: Avisa sobre partes do código que seriam interpretadas de forma diferente por um compilador ANSI/ISO e um pré-ANSI.

Se você quiser que o programa pare de compilar se houver qualquer aviso das flags que você aplicou, use a flag `-Werror`. Usar flags ao compilar um programa é uma boa prática, mas a grande quantidade pode tornar a escolha de quais usar difícil. Com isso em mente, recomendamos que, em geral, as seguintes flags sejam usadas:

```bash
$ gcc -ansi -pedantic -Wall -W programa.c -o programa
```
