---
title: "3. Compilação Condicional"
---

# 3. Compilação Condicional

Em algumas situações, a função padrão não está presente no
sistema que está compilando, para resolver isso o Automake
possui alguns métodos de compilação condicional.

Neste exemplo vamos mostrar como o Automake permite escolher
quais arquivos compilar de acordo com o que for detectado no
sistema. Usaremos `sin` e `cos` como desculpa: em alguns
sistemas essas funções estão na `libm` (ou exigem `-lm` para
linkar), em outros simplesmente não existem. Quando não
existirem, cairemos para aproximações polinomiais escritas à
mão.

## 3.1. Programa

Para começar, essa será a estrutura dos arquivos que
escreveremos:

```
$ tree
.
├── configure.ac
├── Makefile.am
└── src
    ├── approximations.c
    ├── approximations.h
    ├── cos_approx.c
    ├── cos_system.c
    ├── funcs.h
    ├── main.c
    ├── Makefile.am
    ├── sin_approx.c
    └── sin_system.c

2 directories, 11 files
```

## 3.2. Arquivos

Primeiro, `configure.ac`:

```
$ cat configure.ac

AC_INIT([epp], [20.08])

AC_CONFIG_SRCDIR([src/main.c])

AM_INIT_AUTOMAKE([foreign])

AC_PROG_CC

AC_SEARCH_LIBS([sin], [m])
AC_SEARCH_LIBS([cos], [m])

AC_CHECK_FUNCS([sin cos])

AM_CONDITIONAL([HAVE_SIN], [test "x$ac_cv_func_sin" = "xyes"])
AM_CONDITIONAL([HAVE_COS], [test "x$ac_cv_func_cos" = "xyes"])

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([
                 Makefile
                 src/Makefile
                 ])

AC_OUTPUT
```

- `AC_CONFIG_SRCDIR`: indica ao `configure` onde encontrar o
  arquivo `main.c` que será utilizado.
- `AM_INIT_AUTOMAKE`: inicia o Automake com as flags passadas.
- `AC_SEARCH_LIBS`: tenta encontrar e linkar `sin` e `cos`
  primeiro com as libs padrão; se falhar, tenta com `-lm`.
  Em caso de sucesso, acrescenta `-lm` a `LIBS`
- `AC_CHECK_FUNCS`: verifica se `sin` e `cos` existem com os
  `LIBS` atuais e define `HAVE_SIN` e `HAVE_COS` em `config.h`
- `AM_CONDITIONAL`: condicional do `Automake`. Transforma as
  variáveis de cache `ac_cv_func_sin`/`ac_cv_func_cos` em
  condicionais do Automake, que podem ser usadas como `if
  HAVE_SIN` dentro dos `Makefile.am`.
- `AC_CONFIG_HEADERS`: diz ao Autoconf onde guardaremos as
  variáveis que definimos dentro do `configure.ac`.
- `AC_CONFIG_FILES`: indica ao Autoconf onde encontrar os
  `makefile`s que estamos usando.

Segundo, `Makefile.am`:

```
$ cat Makefile.am
AUTOMAKE_OPTIONS = subdir-objects
SUBDIRS = src
```

Como pode ver, é exatamente o mesmo do capítulo anterior.


Terceiro, `src/Makefile.am`:

```
$ cat src/Makefile.am
bin_PROGRAMS = main
main_SOURCES = main.c funcs.h

if HAVE_SIN
main_SOURCES += sin_system.c
else
main_SOURCES += sin_approx.c
endif

if HAVE_COS
main_SOURCES += cos_system.c
else
main_SOURCES += cos_approx.c
endif
```

- `main_SOURCES`: indica quais serão os arquivos usados como
  fonte para compilar o programa. Note que só `main.c` e
  `funcs.h` estão sempre presentes; as demais fontes entram
  por condicional
- `if HAVE_SIN … else … endif`: condicionais do Automake,
  resolvidas em tempo de configuração com as variáveis que
  definimos no `configure.ac`. O `make` já recebe o
  `Makefile` prontinho, com a fonte certa escolhida

Agora o arquivo `src/funcs.h`, que é a interface comum às
implementações:

```
$ cat src/funcs.h
#ifndef FUNCS_H
#define FUNCS_H

char *sin_impl_name();
char *cos_impl_name();

double sin_func(double t);
double cos_func(double t);

#endif // FUNCS_H
```

A ideia é que `main.c` chame sempre `sin_func` e `cos_func`,
sem saber se por baixo existe a versão do sistema ou a
aproximação.

As funções `_impl_name` só estão ali para podermos ter um
retorno na `main` sobre qual versão das funções estamos usando.


Em seguida, `src/main.c`:

```
$ cat src/main.c
#include "config.h"
#include <stdio.h>

#include "funcs.h"

int main(int argc, char *argv[]) {
    double angles[] = {0, 3.14159 / 4, 3.14159 / 2, 3.14159};

    printf("Using %s\n", sin_impl_name());
    printf("Using %s\n", cos_impl_name());

    for (int i = 0; i < sizeof(angles) / sizeof(*angles); i++) {
        printf("sin(%f) = %f\t", angles[i], sin_func(angles[i]));
        printf("cos(%f) = %f\n", angles[i], cos_func(angles[i]));
    }

    return 0;
}
```

Um programa simples que imprime qual implementação está sendo
usada e os valores de `sin` e `cos` para alguns ângulos.


Agora as implementações. Primeiro as aproximações:

```
$ cat src/approximations.h
#ifndef APPROXIMATONS_H
#define APPROXIMATONS_H

double approx_sin(double t);
double approx_cos(double t);

#endif
```

```
$ cat src/approximations.c
double approx_sin(double t) { return t - ((t * t * t) / 6); }

double approx_cos(double t) { return 1 - ((t * t) / 2); }
```

Simples aproximações por séries de Taylor.

As implementações que delegam para o sistema:

```
$ cat src/sin_system.c
#include <math.h>

#include "funcs.h"

char *sin_impl_name() { return "system sin"; }
double sin_func(double t) { return sin(t); }
```

```
$ cat src/cos_system.c
#include <math.h>

#include "funcs.h"

char *cos_impl_name() { return "system cos"; }
double cos_func(double t) { return cos(t); }
```

E as que usam as aproximações:

```
$ cat src/sin_approx.c
#include "funcs.h"

char *sin_impl_name() { return "approximation sin"; }
double sin_func(double t) { return t - ((t * t * t) / 6); }
```

```
$ cat src/cos_approx.c
#include "funcs.h"

char *cos_impl_name() { return "approximation cos"; }
double cos_func(double t) { return 1 - ((t * t) / 2); }
```

Note que as implementações de sistema e de aproximação são
mutuamente exclusivas: `sin_system.c` e `sin_approx.c` definem
os mesmos símbolos. É exatamente por isso que precisamos da
condicional no `Makefile.am`. Sem ela, o linker reclamaria de
símbolos duplicados.

## 3.3. Compilação

Para começar, digite no seu terminal, dentro do diretório do
`Makefile.am` raiz:

```
$ autoreconf -fi
configure.ac:7: installing './compile'
configure.ac:5: installing './install-sh'
configure.ac:5: installing './missing'
src/Makefile.am: installing './depcomp'
```

Após um tempo, caso tudo tenha corrido corretamente, algumas
mensagens do Autoconf e Automake apareceram e uma enxurrada
de arquivos também. Aqui está a nossa nova estrutura de
arquivos:

```
[kdu@mmx ~/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/03]$ tree
.
├── aclocal.m4
├── autom4te.cache
│   ├── output.0
│   ├── output.1
│   ├── output.2
│   ├── requests
│   ├── traces.0
│   ├── traces.1
│   └── traces.2
├── compile
├── config.h.in
├── configure
├── configure.ac
├── depcomp
├── install-sh
├── Makefile.am
├── Makefile.in
├── missing
└── src
    ├── approximations.c
    ├── approximations.h
    ├── cos_approx.c
    ├── cos_system.c
    ├── funcs.h
    ├── main.c
    ├── Makefile.am
    ├── Makefile.in
    ├── sin_approx.c
    └── sin_system.c

3 directories, 27 files
```

Nenhum desses arquivos importam agora, apenas seguimos em
frente com o processo de compilação. Note que o comando
`autoreconf -fi` já criou o arquivo `configure`, assim, não há
a necessidade de rodar os comandos comuns do Autoconf.

Após, execute o arquivo `configure` criado:

```
$ ./configure
checking for a BSD-compatible install... /usr/bin/install -c
checking whether sleep supports fractional seconds... yes
checking filesystem timestamp resolution... 0.01
checking whether build environment is sane... yes
checking for a race-free mkdir -p... /usr/bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking whether make supports nested variables... yes
checking xargs -n works... yes
checking whether UID '1000' is supported by ustar format... yes
checking whether GID '1000' is supported by ustar format... yes
checking how to create a ustar tar archive... gnutar
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether the compiler supports GNU C... yes
checking whether gcc accepts -g... yes
checking for gcc option to enable C23 features... none needed
checking whether gcc understands -c and -o together... yes
checking whether make supports the include directive... yes (GNU style)
checking dependency style of gcc... gcc3
checking for library containing sin... -lm
checking for library containing cos... none required
checking for sin... yes
checking for cos... yes
checking that generated files are newer than configure... done
configure: creating ./config.status
config.status: creating Makefile
config.status: creating src/Makefile
config.status: creating config.h
config.status: executing depfiles commands
```

Caso tudo tenha rodado corretamente, a sua saída será
similar. Repare nas quatro linhas do meio: `AC_SEARCH_LIBS`
encontrou `sin` e `cos` em `-lm` (e já acrescentou `-lm` a
`LIBS`), e `AC_CHECK_FUNCS` confirmou que os símbolos existem.
Portanto `HAVE_SIN` e `HAVE_COS` estarão definidos.

Novamente, não é útil mostrar os arquivos `Makefile`s criados,
já que são absurdamente enormes, porém, o arquivo `config.h` é
breve o suficiente:

```
$ cat config.h
/* config.h.  Generated from config.h.in by configure.  */
/* config.h.in.  Generated from configure.ac by autoheader.  */

/* Define to 1 if you have the 'cos' function. */
#define HAVE_COS 1

/* Define to 1 if you have the 'sin' function. */
#define HAVE_SIN 1

/* Name of package */
#define PACKAGE "epp"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT ""

/* Define to the full name of this package. */
#define PACKAGE_NAME "epp"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "epp 20.08"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "epp"

/* Define to the home page for this package. */
#define PACKAGE_URL ""

/* Define to the version of this package. */
#define PACKAGE_VERSION "20.08"

/* Version number of package */
#define VERSION "20.08"
```


Como dito antes, as variáveis definidas no `configure.ac` são
postas nesse arquivo. Além das `PACKAGE_*` de sempre, agora
também temos `HAVE_COS` e `HAVE_SIN`, que o `configure`
detectou.

O último passo para finalizar a compilação é executar o
comando `make` normalmente:

```
$ make
make  all-recursive
make[1]: Entering directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/03'
Making all in src
make[2]: Entering directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/03/src'
gcc -DHAVE_CONFIG_H -I. -I..     -g -O2 -MT main.o -MD -MP -MF .deps/main.Tpo -c -o main.o main.c
mv -f .deps/main.Tpo .deps/main.Po
gcc -DHAVE_CONFIG_H -I. -I..     -g -O2 -MT sin_system.o -MD -MP -MF .deps/sin_system.Tpo -c -o sin_system.o sin_system.c
mv -f .deps/sin_system.Tpo .deps/sin_system.Po
gcc -DHAVE_CONFIG_H -I. -I..     -g -O2 -MT cos_system.o -MD -MP -MF .deps/cos_system.Tpo -c -o cos_system.o cos_system.c
mv -f .deps/cos_system.Tpo .deps/cos_system.Po
gcc  -g -O2   -o main main.o sin_system.o  cos_system.o   -lm
make[2]: Leaving directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/03/src'
make[2]: Entering directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/03'
make[2]: Leaving directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/03'
make[1]: Leaving directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/03'
```

Repare no `-lm` no final da linha de link: foi o
`AC_SEARCH_LIBS` do `configure.ac` que acrescentou.

Caso tudo tenha rodado corretamente, o binário `main` estará
presente no diretório `src/` e poderá ser executado
normalmente:

```
[kdu@mmx ~/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/03]$ ls -1 src
.deps
approximations.c
approximations.h
cos_approx.c
cos_system.c
cos_system.o
funcs.h
main
main.c
main.o
Makefile
Makefile.am
Makefile.in
sin_approx.c
sin_system.c
sin_system.o
$ ./src/main
Using system sin
Using system cos
sin(0.000000) = 0.000000	cos(0.000000) = 1.000000
sin(0.785397) = 0.707106	cos(0.785397) = 0.707107
sin(1.570795) = 1.000000	cos(1.570795) = 0.000001
sin(3.141590) = 0.000003	cos(3.141590) = -1.000000
```

## 3.4. Testando a outra configuração

Para ver a condicional funcionando do outro lado, basta rodar
o `configure` de novo passando as variáveis de cache que ele
mesmo produz. Elas forçam o resultado dos `AC_CHECK_FUNCS`,
mesmo que o sistema tenha as funções:

```
$ make distclean
$ ./configure ac_cv_func_sin=no ac_cv_func_cos=no
checking for a BSD-compatible install... /usr/bin/install -c
checking whether sleep supports fractional seconds... yes
checking filesystem timestamp resolution... 0.01
checking whether build environment is sane... yes
checking for a race-free mkdir -p... /usr/bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking whether make supports nested variables... yes
checking xargs -n works... yes
checking whether UID '1000' is supported by ustar format... yes
checking whether GID '1000' is supported by ustar format... yes
checking how to create a ustar tar archive... gnutar
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether the compiler supports GNU C... yes
checking whether gcc accepts -g... yes
checking for gcc option to enable C23 features... none needed
checking whether gcc understands -c and -o together... yes
checking whether make supports the include directive... yes (GNU style)
checking dependency style of gcc... gcc3
checking for library containing sin... -lm
checking for library containing cos... none required
checking for sin... (cached) no
checking for cos... (cached) no
checking that generated files are newer than configure... done
configure: creating ./config.status
config.status: creating Makefile
config.status: creating src/Makefile
config.status: creating config.h
config.status: executing depfiles commands
```

Agora o `config.h` não tem mais `HAVE_COS` nem `HAVE_SIN`
definidos, e o `Makefile` gerado já contém `sin_approx.c` e
`cos_approx.c` no lugar das versões de sistema:


```
$ make
make  all-recursive
make[1]: Entering directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/03'
Making all in src
make[2]: Entering directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/03/src'
gcc -DHAVE_CONFIG_H -I. -I..     -g -O2 -MT main.o -MD -MP -MF .deps/main.Tpo -c -o main.o main.c
mv -f .deps/main.Tpo .deps/main.Po
gcc -DHAVE_CONFIG_H -I. -I..     -g -O2 -MT sin_approx.o -MD -MP -MF .deps/sin_approx.Tpo -c -o sin_approx.o sin_approx.c
mv -f .deps/sin_approx.Tpo .deps/sin_approx.Po
gcc -DHAVE_CONFIG_H -I. -I..     -g -O2 -MT cos_approx.o -MD -MP -MF .deps/cos_approx.Tpo -c -o cos_approx.o cos_approx.c
mv -f .deps/cos_approx.Tpo .deps/cos_approx.Po
gcc  -g -O2   -o main main.o  sin_approx.o  cos_approx.o  -lm
make[2]: Leaving directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/03/src'
make[2]: Entering directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/03'
make[2]: Leaving directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/03'
make[1]: Leaving directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/03'
$ ./src/main
Using approximation sin
Using approximation cos
sin(0.000000) = 0.000000	cos(0.000000) = 1.000000
sin(0.785397) = 0.704652	cos(0.785397) = 0.691575
sin(1.570795) = 0.924833	cos(1.570795) = -0.233698
sin(3.141590) = -2.026110	cos(3.141590) = -3.934794
```

Repare que agora o programa imprime `Using approximation
sin` e `Using approximation cos`, e os valores das
aproximações ficam piores. O que é esperado, já que a série
foi truncada em poucos termos.
