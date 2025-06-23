---
title: "2. Comandos básicos"
---

# 2. Comandos Básicos

Para começar, crie um arquivo com o nome `configure.ac` e escreva:

```autoconf
AC_INIT

AC_OUTPUT
```

- `AC_INIT([projeto], [versão])`: Macro para iniciar o Autoconf com dois
  argumentos opcionais para o nome do projeto e para a versão do projeto

- `AC_OUTPUT`: Macro para indicar a saída das mensagens do autoconf, nesse
  caso será o `stdout`

Agora, dentro do mesmo diretório onde o arquivo `configure.ac` reside, digite:

```sh
$ autoconf
```

Caso não haja erros, a não haverá nenhuma saída e um executável `configure`
será criado.

Agora, executando esse arquivo a saída será:
```sh
$ ./configure
configure: creating ./config.status
```
e também serão criados outros arquivos que não são relevantes no momento

## 2.1. Checagem de Compiladores Comuns

No mesmo arquivo, adicione:

```autoconf
AC_INPUT

AC_PROG_CC
AC_PROG_CXX

AC_OUTPUT
```

- `AC_PROG_CC`: Macro para fazer as verifiações padrão do compilador gcc
- `AC_PROG_CXX`: Macro para fazer as verifiações padrão do compilador g++

Caso o seu sistema possua um compilador de c e c++, a saida deste programa será:

```sh
$ autoconf
$ ./configure
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether the compiler supports GNU C... yes
checking whether gcc accepts -g... yes
checking for gcc option to enable C11 features... none needed
checking for g++... g++
checking whether the compiler supports GNU C++... yes
checking whether g++ accepts -g... yes
checking for g++ option to enable C++11 features... none needed
configure: creating ./config.status
```

A saida pode ser levemente diferente dependendo das versões disponíveis do c e
c++ no seu sistema e do sistema operacional presente.

Os comandos na forma `AC_PROG_XX` são usados para verifiações de compiladores,
nesse caso o gcc

Outros compiladores são suportados, como o de fortran, objetive-c e go,
consulte o manual do autoconf para encontrar os comandos desses compiladores.

## 2.2 Checagem de Bibliotecas, Tipos e Funções

É possível também fazer checagens de funções, bibliotecas e até tipos definidos
nativamente com autoconf

No arquivo `configure.ac` criado anteriormente, adicione as seguintes linhas:

```autoconf
AC_INIT

AC_PROG_CC

AC_TYPE_SIZE_T
AC_TYPE_UINT32_T

AC_CHECK_HEADERS([stdlib.h stdio.h string.h unistd.h])

AC_CHECK_LIB([pthread], [pthread_create])
AC_CHECK_LIB([m], [sqrt])

AC_CHECK_FUNCS([malloc memset strchr])

AC_OUTPUT
```

- `AC_TYPE_SIZE_T`: Macro para verificar a existência do tipo `size_t`
- `AC_TYPE_UINT32_T`: Macro para verificar a existência do tipo `uint32_t`
- `AC_CHECK_HEADERS([headers])`: Macro para verificar a existência de
  bibliotecas no sistema. As bibliotecas devem ser separadas por espaços
- `AC_CHECK_LIB([lib], [func])`: Macro para verificar a existência de uma
  função específica dentro de uma biblioteca
- `AC_CHECK_FUNCS([funcs])`: Macro para verificar a existência de funções no
  sistema, independente de onde elas venham. As funções devem ser separadas por
  espaços

Ao executar os comandos corretos para a checagem, caso não hajam erros, a saída
será:

```sh
$ autoconf
$ ./configure
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether the compiler supports GNU C... yes
checking whether gcc accepts -g... yes
checking for gcc option to enable C11 features... none needed
checking for stdio.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for strings.h... yes
checking for sys/stat.h... yes
checking for sys/types.h... yes
checking for unistd.h... yes
checking for size_t... yes
checking for uint32_t... yes
checking for stdlib.h... yes
checking for stdio.h... yes
checking for string.h... yes
checking for unistd.h... yes
checking for pthread_create in -lpthread... yes
checking for sqrt in -lm... yes
checking for malloc... yes
checking for memset... yes
checking for strchr... yes
configure: creating ./config.status
```

Em um sistema operacional diferente, e em versões diferentes do c, a saída será
levemente diferente, porém, sem mensagens de errors sendo apresentadas, está
tudo correto.

Como é possível observar, o autoconf automaticamente determina de onde certos
tipos vem e checa a existência do header que conteria esse tipo. A verificação
da biblioteca `inttypes.h` é responsável por aferir a presença dos tipos
`size_t` e `uint32_t`, os quais foram constatada a existência logo após.

O mesmo se aplica às funções, `malloc` e `memset` estão presentes em
`stdlib.h`, que foram checados anteriormente pelo `configure`, e logo após
averiguados.
