---
title: "2. Programa Básico"
---

# 1. Exemplo Mínimo

# 1.1. Estrutura

Para começar, essa será a estrutura dos arquivos que
usaremos:

```
$ tree
.
├── configure.ac
├── Makefile.am
├── README
└── src
    ├── main.c
    └── Makefile.am

2 directories, 5 files
```

# 1.2. Arquivos

Aqui estão os conteúdos dos arquivos que escreveremos:

Primeiro, `configure.ac`:

```
$ cat configure.ac
AC_INIT([epp], [148.41])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])

AC_PROG_CC
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([
                 Makefile
                 src/Makefile
                 ])

AC_OUTPUT
```

O arquivo `configure.ac` permanece similar ao que foi visto
anteriormente, porém com algumas linhas adicionais para
indicar que estamos usando o Automake junto ao Autoconf.

- `AM_INIT_AUTOMAKE`: inicia o Automake com as flags
  passadas
- `AC_CONFIG_HEADERS`: diz ao Autoconf onde guardaremos as
  variáveis que definimos dentro do `configure.ac`.
- `AC_CONFIG_FILES`: indica ao Autoconf onde encontrar os
  `makefile`s que estamos usando

Segundo `Makefile.am`:

```
$ cat Makefile.am
SUBDIRS = src
dist_doc_DATA = README
```

Um arquivo `Makefile.am` extremamente simples, indicando
apenas que estamos trabalhando com o subdiretório `src` e
que a documentação do nosso programa está no arquivo
`README`.

Terceiro, `src/Makefile.am`:

```
$ cat src/Makefile.am
bin_PROGRAMS = hello
hello_SOURCES = main.c
```

- `bin_PROGRAMS`: indica o nome do binário que produziremos
- `{nome do binário}_SOURCES`: indica quais serão os
  arquivos usados como fonte para compilar o programa

Como o programa será bem simples, apenas essas duas linhas
já serão o suficiente para compilar, instalar e criar um
tarball para uma futura distribuição.

Finalmente, `src/main.c`:

```
$ cat src/main.c
#include <config.h>
#include <stdio.h>

int main(void) {
    puts("Hello World");
    puts("This is " PACKAGE_STRING ".");

    return 0;
}
```

Um programa simples que apenas imprime `Hello World` e o
nome do pacote, que definimos no arquivo `configure.ac`.

O arquivo `config.h` será automaticamente criado pelo
Autoconf.

# 2. Compilação

Para começar, digite no seu terminal, dentro do diretório do
`Makefile.am` raiz:

```
$ autoreconf -fi
configure.ac:4: installing './compile'
configure.ac:2: installing './install-sh'
configure.ac:2: installing './missing'
src/Makefile.am: installing './depcomp'
```

Após um tempo, caso tudo tenha corrido corretamente, algumas
mensagens do Autoconf e Automake apareceram e um enxurrada
de arquivos também. Aqui está a nossa nova estrutura de
arquivos:

```
$ tree
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
├── README
└── src
    ├── main.c
    ├── Makefile.am
    └── Makefile.in

3 directories, 21 files
```

Nenhum desses arquivos importam agora, apenas seguimos em
frente com o processo de compilação. Note que o comando
`autoreconf -fi` já criou o arquivo `configure`, assim, não
há a necessidade de rodar os comandos comuns do Autoconf.

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
checking that generated files are newer than configure... done
configure: creating ./config.status
config.status: creating Makefile
config.status: creating src/Makefile
config.status: creating config.h
config.status: executing depfiles commands
```

Caso tudo tenha rodado corretamente, a sua saída será
similar.

A execução do `configure` segue igual a que já foi mostrada
anteriormente, com a diferença da criação dos arquivos
`Makefile` e do `config.h` indicados no final da saída.

Não é útil mostrar os arquivos `Makefile`s criados, já que
são absurdamente enormes, porém, o arquivo `config.h` é
breve o suficiente:

```
$ cat config.h
/* config.h.  Generated from config.h.in by configure.  */
/* config.h.in.  Generated from configure.ac by autoheader.  */

/* Name of package */
#define PACKAGE "epp"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT ""

/* Define to the full name of this package. */
#define PACKAGE_NAME "epp"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "epp 148.41"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "epp"

/* Define to the home page for this package. */
#define PACKAGE_URL ""

/* Define to the version of this package. */
#define PACKAGE_VERSION "148.41"

/* Version number of package */
#define VERSION "148.41"
```

Como dito antes, as variáveis definidas no `configure.ac`
são postas nesse arquivo, e, como são incluídas em
`src/main.c`, poderão ser acessadas pelo programa.

O último passo para finalizar a compilação é executar o
comando `make` normalmente:

```
$ make
make  all-recursive
make[1]: Entering directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/01'
Making all in src
make[2]: Entering directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/01/src'
gcc -DHAVE_CONFIG_H -I. -I..     -g -O2 -MT main.o -MD -MP -MF .deps/main.Tpo -c -o main.o main.c
mv -f .deps/main.Tpo .deps/main.Po
gcc  -g -O2   -o hello main.o
make[2]: Leaving directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/01/src'
make[2]: Entering directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/01'
make[2]: Leaving directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/01'
make[1]: Leaving directory '/home/kdu/sync-dir/pdfs/ufrj/extensao/epp/autotools/automake/01'
```

Caso tudo tenha rodado corretamente, o binário `hello`
estará presente no diretório `src/` e poderá ser executado
normalmente:

```
$ ls src
.deps  hello  main.c  main.o  Makefile  Makefile.am  Makefile.in
$ ./src/hello
Hello World
This is epp 148.41.
```
