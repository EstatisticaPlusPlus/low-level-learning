---
title: 3. Checagem de Compiladores
---

# 3. Checagem de Compiladores

O Autoconf possui alguns macros padrões para checagem de alguns compiladores
mais comuns.

## 3.1. Programa

Crie um arquivo `configure.ac` e escreva:

```autoconf
AC_INIT([epp], 1.0)

AC_PROG_GO # GO compiler
AC_PROG_OBJC # Objective C compiler
AC_PROG_CXX # C++ compiler
AC_PROG_OBJCXX # Objective C++ compiler
AC_PROG_FC # Check for compilers for Fortran 77, Fortran 90, and Fortran 95
AC_PROG_F77([fl32 f77]) # Check for specific Fortran 77 compilers

AC_OUTPUT
```

- `AC_PROG_XX([compiladores])`: Conjunto de macros para fazer as verificações
  padrão dos compiladores de uma linguagem específica. É possível passar um
  compilador específico para verificar a sua existência, mas não é obrigatório,
  nesse caso, as checagens padrões serão feitas

## 3.2. Saída Esperada

A saída dependerá dos compiladores e as versões presentes no seu sistema, porém
a estrutura será similar

```sh
$ autoconf && ./configure
checking for g++... g++
checking whether the C++ compiler works... yes
checking for C++ compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether the compiler supports GNU C++... yes
checking whether g++ accepts -g... yes
checking for g++ option to enable C++11 features... none needed
checking for g++... g++
checking whether the compiler supports GNU Objective C++... no
checking whether g++ accepts -g... no
checking for gfortran... gfortran
checking whether the compiler supports GNU Fortran... yes
checking whether gfortran accepts -g... yes
checking for g77... no
checking for xlf... no
checking for f77... f77
checking whether the compiler supports GNU Fortran 77... yes
checking whether f77 accepts -g... yes
checking whether the compiler supports GNU Fortran 77... yes
checking whether f77 accepts -g... yes
configure: creating ./config.status
```
