---
title: "10. Comparação de tamanhos de variáveis"
---

# 10. Comparação de tamanhos de variáveis

Em diversas ocasiões, principalmente em projetos que
utilizam linguagens diferentes comunicando entre si, é
necessário saber a diferença de tamanho entre diferentes
tipos de variáveis para que não ocorra nenhum acesso
indevido de memoria.

O exemplo dado nesse capítulo será entre C e Fortran, porém
a ideia para outras linguagens é similar.

## 10.1 Macros utilizados

```config
# configure.ac
AC_INIT([epp], [54.59])

m4_include([m4/checks.m4])

AC_PROG_CC
AC_PROG_FC

bcc=2
mb=1
bbb=0

define_c_sizes
define_fortran_sizes

epp_compare_sizes([c_int],
                  [$ac_cv_sizeof_int],
                  [fortan_int],
                  [$epp_fortran_sizeof_integer])

epp_compare_sizes([c_float],
                  [$ac_cv_sizeof_float],
                  [fortan_real],
                  [$epp_fortran_sizeof_real])

epp_compare_sizes([c_double],
                  [$ac_cv_sizeof_double],
                  [fortan_real],
                  [$epp_fortran_sizeof_real])

epp_compare_sizes([bcc], [$bcc], [bbb], [$bbb])
epp_compare_sizes([bcc], [$bcc], [mb], [$mb])
epp_compare_sizes([bbb], [$bbb], [mb], [$mb])

AC_OUTPUT
```

```config
# m4/checks.m4

AC_DEFUN([define_c_sizes], [
    AC_LANG_PUSH([C])
    AC_CHECK_SIZEOF(int)
    AC_CHECK_SIZEOF(long)
    AC_CHECK_SIZEOF(long long)
    AC_CHECK_SIZEOF(float)
    AC_CHECK_SIZEOF(double)
    AC_CHECK_SIZEOF(int *)
    AC_CHECK_SIZEOF(long *)
    AC_CHECK_SIZEOF(long long *)
    AC_CHECK_SIZEOF(float *)
    AC_CHECK_SIZEOF(double *)
    AC_LANG_POP([C])
])

AC_DEFUN([define_fortran_sizes], [
    epp_fortran_sizeof([integer], [epp_fortran_sizeof_integer])
    epp_fortran_sizeof([real], [epp_fortran_sizeof_real])
])

# $1 => Nome da primeira variável
# $2 => Valor da primeira variável
# $3 => Nome da segunda variável
# $4 => Valor da segunda variável
AC_DEFUN([epp_compare_sizes], [
    AC_MSG_CHECKING(sizes of $1 vs $3)

    AS_IF(
    [test $2 -gt $4], [AC_MSG_RESULT($1 > $3)],
    [test $2 -lt $4], [AC_MSG_RESULT($1 < $3)],
    [AC_MSG_RESULT($1 == $3)]
    )
])

AC_DEFUN([epp_fortran_sizeof], [
    AC_LANG_PUSH([Fortran])

    AC_MSG_CHECKING([size of Fortran $1])
    AC_RUN_IFELSE([AC_LANG_PROGRAM([],
    [[
            $1 :: x
            integer :: i
            i = storage_size(x)/8
            open(99, file='conftest.out', status='unknown')
            write(99, '(I0)') i
            close(99)
    ]])],
    [eval $2=`cat conftest.out`],
    [AC_MSG_RESULT(Compile errored out. Check config.log for more info)])
    AC_MSG_RESULT($$2)
    AC_LANG_POP([Fortran])
])
```

O exemplo acima segue um fluxo bem simples, começando por
`configure.ac`:

1. `AC_PROG_CC` e `AC_PROG_FC` para garantir que o C e o
   Fortran estão inicializados antes de começar o programa
2. Definição de tamanhos de tipos de diferentes linguagens,
   além de um tipos sem sentido apenas para demonstrar que a
   função de comparação de tipos é agnóstica à linguagens
3. Comparação entre os tamanhos, seguindo o estilo: nome da
   primeira variável, tamanho da primeira variável, nome da
   segunda variável, tamanho da segunda variável

Agora, seguindo `m4/checks.m4`:

1. `define_c_sizes`: macro simples pra definir os tipos C
   que serão utilizados. Para tipos C o Autoconf possui
   uma maneira pré-definida de conseguir o tamanho dos
   tipos, então usamos essa forma. A variável que guardará o
   tamanho dos tipos segue o estilo `ac_cv_sizeof_{tipo}`
2. `define_fortran_sizes`: macro para definir os tamanhos
   dos tipos do Fortran. Como o Autoconf não possui uma
   maneira nativa de obter os tipos do Fortran, é necessário
   definirmos a nossa forma, que será apresentada em breve.
   A variável que será usada para guardar o tamanho do tipo
   será da forma `epp_fortran_sizeof_{tipo}`
3. `epp_compare_sizes`: macro para comparar os tamanhos
   obtidos. Pode também ser usada para comparar qualquer
   outros valores, pois o macro é apenas um `if`, `else if`,
   `else` dentro do `AS_IF`, desde que siga a forma: nome da
   primeira variável, tamanho da primeira variável, nome da
   segunda variável, tamanho da segunda variável.
   `AS_IF` executa da seguinte forma: `AS_IF([teste1],
[roda-se-verdadeiro1], ..., [roda-se-todos-falsos])`,
   seguindo uma cadeia de `if`, `else if` dessa forma
4. `epp_fortran_sizeof`: macro para obter o tamanho de tipos
   do Fortran. Como o Autoconf não possui forma nativa de
   obter tamanhos do Fortran, precisamos prover uma maneira
   nossa. A função segue a sequência de argumentos: tipo da
   variável, nome da variável onde o valor será guardado

A forma como o tamanho de um tipo é obtido em Fortran se
utiliza de um truque com arquivos no sistema. É declarado
uma variável `x` do tipo que foi passado e um inteiro `i`. O
tamanho do tipo de `x` é guardado em `i` e convertido em
bytes ao dividir por 8 (a função do Fortran retorna o valor
em bits). Após conseguir o tamanho, abrimos/criamos um
arquivo com o nome `conftest.out` e handle 99, escrevemos o
tamanho de `i` no arquivo e fechamos o arquivo.

Fora do Fortran, dentro do Autoconf, a função `eval` avalia
a expressão `cat conftest.out` para conseguir o valor
escrito pelo Fortran e o põe na variável passado que obterá
o tamanho pedido. No final, o valor obtido é mostrado no
console.

Com tudo isso apresentado, ao rodar o programa a saída será
aproximadamente essa:

```
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
checking for gcc option to enable C23 features... none needed
checking for gfortran... gfortran
checking whether the compiler supports GNU Fortran... yes
checking whether gfortran accepts -g... yes
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
checking size of long... 8
checking size of long long... 8
checking size of float... 4
checking size of double... 8
checking size of int *... 8
checking size of long *... 8
checking size of long long *... 8
checking size of float *... 8
checking size of double *... 8
checking size of Fortran integer... 4
checking size of Fortran real... 4
checking sizes of c_int vs fortan_int... c_int == fortan_int
checking sizes of c_float vs fortan_real... c_float == fortan_real
checking sizes of c_double vs fortan_real... c_double > fortan_real
checking sizes of bcc vs bbb... bcc > bbb
checking sizes of bcc vs mb... bcc > mb
checking sizes of bbb vs mb... bbb < mb
configure: creating ./config.status
```

Caso a sua saída seja próxima a essa, o programa está
funcionando perfeitamente.
