---
title: "7. Verificação de flags"
---

# 7. Verificação de flags

Além de verificar versões de linguagens, é necessário
conhecer também a disponibilidade de alguma flag para
diferentes compiladores.

Como no último capítulo, não há uma forma padrão do Autoconf
para verificar a existência de alguma flag de um compilador,
logo, teremos que prover uma implementação nossa.

## 7.1 Macros Utilizadas

Por questões de simplicidade, os macros apresentados serão
bem repetitivos inicialmente.

```m4
AC_DEFUN([CHECK_CFLAG], [
    AC_REQUIRE([AC_PROG_CC])

    AC_LANG_PUSH([C])
    AC_MSG_CHECKING([if $CC accepts $1])
    old_CFLAGS="$CFLAGS"
    CFLAGS="$1"

    AC_COMPILE_IFELSE(
        [AC_LANG_PROGRAM([], [return 0;])],
        [AC_MSG_RESULT([yes])],
        [AC_MSG_RESULT([no])]
    )

    CFLAGS="$old_CFLAGS"
    AC_LANG_POP([C])
])

AC_DEFUN([CHECK_CXXFLAG], [
    AC_REQUIRE([AC_PROG_CXX])

    AC_LANG_PUSH([C++])
    AC_MSG_CHECKING([if $CXX accepts $1])
    old_CXXFLAGS="$CXXFLAGS"
    CXXFLAGS="$1"

    AC_COMPILE_IFELSE(
        [AC_LANG_PROGRAM([], [return 0;])],
        [AC_MSG_RESULT([yes])],
        [AC_MSG_RESULT([no])]
    )

    CXXFLAGS="$old_CXXFLAGS"
    AC_LANG_POP([C++])
])

AC_DEFUN([CHECK_FCFLAG], [
    AC_REQUIRE([AC_PROG_FC])

    AC_LANG_PUSH([Fortran])
    AC_MSG_CHECKING([if $FC accepts $1])
    old_FCFLAGS="$FCFLAGS"
    FCFLAGS="$1"

    AC_COMPILE_IFELSE(
        [AC_LANG_PROGRAM()],
        [AC_MSG_RESULT([yes])],
        [AC_MSG_RESULT([no])]
    )

    FCFLAGS="$old_FCFLAGS"
    AC_LANG_POP([Fortran])
])

```

As 3 definições seguem o exato mesmo estilo, apenas com
nomes diferentes. Elas seguem o fluxo:

1. Definem um macro para verificar uma flag de uma
   linguagem específica
2. Verificam se as dependências da linguagem foram
   propriamente definidas anteriormente. Esse passo é apenas
   para redundância, para o caso do desenvolvedor ter
   esquecido dessa etapa antes.
3. Colocam a linguagem no stack do Autoconf, indicando qual
   linguagem estamos lidando
4. Salva as flags antigas e define a variável das flags como
   a que queremos testar, isolando de possíveis conflitos
   com outras flags presentes anteriormente
5. Compila um programa básico com o compilador padrão
   definido e as flags passadas, indicando se a compilação
   foi bem sucedida com um "yes" ou "no"
6. Restaura as flags antigas na variável correta

Agora, testando as flags dessa forma:

```
AC_INIT([2.781pp], [2.781])

m4_include([m4/checks.m4]) # Assumindo que os macros foram
                           # postos em m4/checks.m4

CHECK_CFLAG([-O1])
CHECK_CFLAG([-O2])
CHECK_CFLAG([-O3])
CHECK_CFLAG([-Wall])
CHECK_CFLAG([-Werror])
CHECK_CFLAG([-Wextra])
CHECK_CFLAG([-ansi])
CHECK_CFLAG([-std=c89])
CHECK_CFLAG([-std=c90])
CHECK_CFLAG([-std=c9x])
CHECK_CFLAG([-std=c99])
CHECK_CFLAG([-std=c11])
CHECK_CFLAG([-std=c1x])
CHECK_CFLAG([-std=c18])
CHECK_CFLAG([-std=c23])
CHECK_CFLAG([-std=c2x])

CHECK_CXXFLAG([-ansi])
CHECK_CXXFLAG([-std=c++98])
CHECK_CXXFLAG([-std=c++03])
CHECK_CXXFLAG([-std=c++11])
CHECK_CXXFLAG([-std=c++0x])
CHECK_CXXFLAG([-std=c++14])
CHECK_CXXFLAG([-std=c++1y])
CHECK_CXXFLAG([-std=c++17])
CHECK_CXXFLAG([-std=c++1z])
CHECK_CXXFLAG([-std=c++20])
CHECK_CXXFLAG([-std=c++2a])
CHECK_CXXFLAG([-std=c++23])
CHECK_CXXFLAG([-std=c++2b])
CHECK_CXXFLAG([-std=c++26])
CHECK_CXXFLAG([-std=c++2c])

CHECK_FCFLAG([-std=gnu])
CHECK_FCFLAG([-std=f95])
CHECK_FCFLAG([-std=f2003])
CHECK_FCFLAG([-std=legacy])
CHECK_FCFLAG([-O3])
CHECK_FCFLAG([-O0])
CHECK_FCFLAG([-O1])
CHECK_FCFLAG([-O2])
CHECK_FCFLAG([-O3])
CHECK_FCFLAG([-g])
CHECK_FCFLAG([-cpp])
```

A saída será, aproximadamente:

```
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether the compiler supports GNU C... yes
checking whether gcc accepts -g... yes
checking for gcc option to enable C23 features... none needed
checking if gcc accepts -O1... yes
checking if gcc accepts -O2... yes
checking if gcc accepts -O3... yes
checking if gcc accepts -Wall... yes
checking if gcc accepts -Werror... yes
checking if gcc accepts -Wextra... yes
checking if gcc accepts -ansi... yes
checking if gcc accepts -std=c89... yes
checking if gcc accepts -std=c90... yes
checking if gcc accepts -std=c9x... yes
checking if gcc accepts -std=c99... yes
checking if gcc accepts -std=c11... yes
checking if gcc accepts -std=c1x... yes
checking if gcc accepts -std=c18... yes
checking if gcc accepts -std=c23... yes
checking if gcc accepts -std=c2x... yes
checking for g++... g++
checking whether the compiler supports GNU C++... yes
checking whether g++ accepts -g... yes
checking if g++ accepts -ansi... yes
checking if g++ accepts -std=c++98... yes
checking if g++ accepts -std=c++03... yes
checking if g++ accepts -std=c++11... yes
checking if g++ accepts -std=c++0x... yes
checking if g++ accepts -std=c++14... yes
checking if g++ accepts -std=c++1y... yes
checking if g++ accepts -std=c++17... yes
checking if g++ accepts -std=c++1z... yes
checking if g++ accepts -std=c++20... yes
checking if g++ accepts -std=c++2a... yes
checking if g++ accepts -std=c++23... yes
checking if g++ accepts -std=c++2b... yes
checking if g++ accepts -std=c++26... yes
checking if g++ accepts -std=c++2c... yes
checking for gfortran... gfortran
checking whether the compiler supports GNU Fortran... yes
checking whether gfortran accepts -g... yes
checking if gfortran accepts -std=gnu... yes
checking if gfortran accepts -std=f95... yes
checking if gfortran accepts -std=f2003... yes
checking if gfortran accepts -std=legacy... yes
checking if gfortran accepts -O3... yes
checking if gfortran accepts -O0... yes
checking if gfortran accepts -O1... yes
checking if gfortran accepts -O2... yes
checking if gfortran accepts -O3... yes
checking if gfortran accepts -g... yes
checking if gfortran accepts -cpp... yes
configure: creating ./config.status
```

Note que os compiladores utilizados são os padrões do
Autoconf e as flags são testadas separadamente, uma em cada
linha. Em breve usaremos novos macros do M4 para criar uma
versão mais agnóstica da macros criadas
