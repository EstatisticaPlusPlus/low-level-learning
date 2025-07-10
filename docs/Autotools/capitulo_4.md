---
title: "4. Verificação de Bibliotecas"
---

# 4. Verificação de Bibliotecas

O Autoconf também possui macros definidas para a verificação de bibliotecas e
headers existentes no sistema.

## 4.1. Programa

```autoconf
# Verificando algumas bibliotecas
AC_INIT([epp], [1.0])

AC_CHECK_LIB([pthread], [pthread_create])
AC_CHECK_LIB([m], [sqrt])

AC_CHECK_HEADERS([stdlib.h stdio.h string.h unistd.h])

AC_OUTPUT
```

## 4.3. Macros Utilizados

- `AC_CHECK_LIB([biblioteca], [função])`: Verifica se biblioteca existe e
  contém função específica
- `AC_CHECK_HEADERS([headers])`: Confirma existência de headers no sistema

## 4.4. Saída Esperada

```sh
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether the compiler supports GNU C... yes
checking whether gcc accepts -g... yes
checking for gcc option to enable C11 features... none needed
checking for pthread_create in -lpthread... yes
checking for sqrt in -lm... yes
checking for stdio.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for strings.h... yes
checking for sys/stat.h... yes
checking for sys/types.h... yes
checking for unistd.h... yes
checking for stdlib.h... yes
checking for stdio.h... yes
checking for string.h... yes
checking for unistd.h... yes
configure: creating ./config.status
```
