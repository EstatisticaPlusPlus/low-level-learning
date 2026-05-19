---
title: "8. Verificação de Tamanhos de Tipos em C e Fortran"
---

# 8. Verificação de Tamanhos de Tipos

Saber o tamanho em bytes de um tipo é essencial em diversas
situações: interoperabilidade entre linguagens, serialização
de dados, alocação de memória e portabilidade entre
arquiteturas diferentes.

O Autoconf oferece uma forma nativa de verificar o tamanho
de tipos C, enquanto para o Fortran é necessário definir
nossa própria macro, já que não existe suporte nativo para
isso.

## 8.1. Macros Utilizadas

```
# configure.ac
AC_INIT([epp], [2.78])

m4_include([m4/check.m4])

AC_CHECK_SIZEOF([int])
AC_CHECK_SIZEOF([int *])
AC_CHECK_SIZEOF([double])
AC_CHECK_SIZEOF([double *])
AC_CHECK_SIZEOF([float])
AC_CHECK_SIZEOF([float *])
AC_CHECK_SIZEOF([char])
AC_CHECK_SIZEOF([char *])
AC_CHECK_SIZEOF([long])
AC_CHECK_SIZEOF([long *])
AC_CHECK_SIZEOF([long long])
AC_CHECK_SIZEOF([long long *])
AC_CHECK_SIZEOF([short])
AC_CHECK_SIZEOF([short *])
AC_CHECK_SIZEOF([void])
AC_CHECK_SIZEOF([void *])
AC_CHECK_SIZEOF([BBB])
AC_CHECK_SIZEOF([BBB *])
AC_CHECK_SIZEOF([MB])
AC_CHECK_SIZEOF([MB *])

AC_LANG_PUSH([Fortran])

check_fc_size([integer])
check_fc_size([real])
check_fc_size([real64])
check_fc_size([complex])

AC_LANG_POP([Fortran])

AC_OUTPUT
```

```m4
# m4/check.m4
AC_DEFUN(check_fc_size, [

    AC_MSG_CHECKING([size of $1])
    AC_RUN_IFELSE([AC_LANG_PROGRAM([],
    [[      $1 :: x
            print *, storage_size(x) / 8
    ]])],
    [AC_MSG_RESULT($ac_runval)],
    [AC_MSG_RESULT(unknown)])
])
```

## 8.2. Descrição das Macros

### 8.2.1. Tipos C — `AC_CHECK_SIZEOF`

- `AC_CHECK_SIZEOF([tipo])`: Macro nativa do Autoconf que
  verifica o tamanho em bytes de um tipo C. O resultado é
  armazenado na variável `ac_cv_sizeof_{tipo}`, que pode ser
  reutilizada em outros macros. Caso o tipo não exista no
  sistema, o tamanho retornado será `0`

No programa acima, são verificados os tipos primitivos mais
comuns do C (`int`, `double`, `float`, `char`, `long`,
`long long`, `short`, `void`) e seus respectivos ponteiros.
Também são verificados os tipos `BBB` e `MB`, que não
existem em C, para demonstrar que a macro retorna `0` para
tipos desconhecidos.

### 8.2.2. Tipos Fortran — `check_fc_size`

Como o Autoconf não possui uma forma nativa de obter o
tamanho de tipos Fortran, é necessário definir nossa própria
macro. O fluxo da macro `check_fc_size` é:

1. Exibe uma mensagem de verificação com `AC_MSG_CHECKING`
2. Compila e executa um pequeno programa Fortran com
   `AC_RUN_IFELSE`, que declara uma variável do tipo
   recebido como argumento (`$1`) e imprime seu tamanho em
   bytes via `storage_size(x) / 8` (a função `storage_size`
   retorna o valor em bits, por isso a divisão por 8)
3. Caso a execução tenha sucesso, exibe o valor capturado
   em `$ac_runval`. Caso contrário, exibe `unknown`

O contexto Fortran é ativado com `AC_LANG_PUSH([Fortran])`
antes das chamadas e encerrado com `AC_LANG_POP([Fortran])`
ao final, indicando ao Autoconf qual compilador deve ser
utilizado durante as verificações.

## 8.3. Saída Esperada

```
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
checking size of int... 4
checking size of int *... 8
checking size of double... 8
checking size of double *... 8
checking size of float... 4
checking size of float *... 8
checking size of char... 1
checking size of char *... 8
checking size of long... 8
checking size of long *... 8
checking size of long long... 8
checking size of long long *... 8
checking size of short... 2
checking size of short *... 8
checking size of void... 1
checking size of void *... 8
checking size of BBB... 0
checking size of BBB *... 0
checking size of MB... 0
checking size of MB *... 0
checking for gfortran... gfortran
checking whether the compiler supports GNU Fortran... yes
checking whether gfortran accepts -g... yes
checking size of integer...            4

checking size of real...            4

checking size of real64... unknown
checking size of complex...            8
configure: creating ./config.status
```
