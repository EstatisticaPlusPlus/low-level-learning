---
title: "5. Verificação de Tipos e Funções"
---

# 5. Verificação de Tipos e Funções

Além de bibliotecas e compiladores, há a possibilidade de checagem de alguns
tipos e funções.

## 5.1. Programa

```autoconf
# Verificando alguns tipos e funções basicas
AC_INIT([epp], [1.0])

AC_PROG_CC

AC_TYPE_SIZE_T
AC_TYPE_UINT32_T

AC_CHECK_FUNCS([malloc memset strchr])

AC_OUTPUT
```

## 5.2. Macros Utilizadas

- `AC_TYPE_XX`: Verifica a existência de um tipo específico. No programa,
  `size_t`, `uint32_t`
- `AC_CHECK_FUNCS`: Verifica a existência de funções no sistema, independente
  de onde estejam. No programa, `malloc`, `memset` e `strchr`

## 5.4. Saída Esperada

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
checking for malloc... yes
checking for memset... yes
checking for strchr... yes
configure: creating ./config.status
```
