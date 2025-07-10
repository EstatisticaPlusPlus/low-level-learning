---
title: "6. Verificação de Padrões de Linguagem"
---

# 6. Verificação de Padrões de Linguagem

Vamos testar suporte a diferentes padrões de C e C++.

Até o momento, utilizamos macros definidas por padrão pelo Autoconf, porém, a
partir de agora precisaremos definir nossos próprios macros, pois não há uma
forma padrão de testar padrões de linguagem.

Por uma questão de boa prática e organização, vamos separar o arquivo principal
`configure.ac` dos nossos macros definidos futuramente. Crie um diretório
chamado `m4` e crie um arquivo `checks.m4` dentro desse diretório.

## 6.1. Código do m4/checks.m4

```m4
AC_DEFUN([CHECK_C_STANDARD], [
  AC_MSG_CHECKING([for C$1 support])
  AC_COMPILE_IFELSE(
    [AC_LANG_SOURCE([
      #if !defined(__STDC_VERSION__) || __STDC_VERSION__ < $2
      #error "C$1 not supported"
      #endif
      int main(void) { return 0; }
    ])],
    [AC_MSG_RESULT([yes])],
    [AC_MSG_RESULT([no])]
  )
])

AC_DEFUN([CHECK_CXX_STANDARD], [
  AC_MSG_CHECKING([for C++$1 support])
  AC_COMPILE_IFELSE(
    [AC_LANG_SOURCE([
      #if !defined(__cplusplus) || __cplusplus < $2
      #error "C++$1 not supported"
      #endif
      int main() { return 0; }
    ])],
    [AC_MSG_RESULT([yes])],
    [AC_MSG_RESULT([no])]
  )
])
```

## 6.2. Macros Utilizados

Este código define duas macros para verificar suporte a padrões C e C++. Vamos
analisar cada parte:

- `CHECK_C_STANDARD`: Verifica se o compilador C suporta uma versão específica
  do padrão C.
- `CHECK_CXX_STANDARD`: Verifica se o compilador C++ suporta uma versão
  específica do padrão C++.

Ambos os macros seguem o mesmo padrão:

1. `AC_MSG_CHECKING(msg)`: Exibe uma mensagem de verificação
   (ex: "checking for C11 support"). A palavra "checking" é automaticamente
   posta no inicio da mensagem
2. `AC_COMPILE_IFELSE([program], [success], [failure])`: Tenta compilar um programa
   teste, em caso de sucesso, executará o que está em `success`, em caso de
   falha, executará o que está em `failure`
3. `AC_LANG_SOURCE([program])`: Define o código fonte a ser compilado. Caso não
   seja dado um programa, será utilizado um programa padrão simples definido
   pelo Autoconf
4. `AC_MSG_RESULT`: Exibe o resultado (yes/no)

### 6.2.1. Detalhes da Implementação para C (`CHECK_C_STANDARD`)

- Verifica `__STDC_VERSION__` (macro que indica a versão do padrão C)
- Compara com o valor numérico fornecido no segundo argumento (`$2`)
- Valores típicos:
    - C99: `199901L`
    - C11: `201112L`
    - C17: `201710L`

### 6.2.2. Detalhes da Implementação para C++ (`CHECK_CXX_STANDARD`)

- Verifica `__cplusplus` (macro que indica a versão do padrão C++)
- Compara com o valor numérico fornecido no segundo argumento (`$2`)
- Valores típicos:
    - C++11: `201103L`
    - C++14: `201402L`
    - C++17: `201703L`
    - C++20: `202002L`

## 6.3. Fluxo de execução da função

1. O Autoconf expande as macros durante a geração do script `configure`
2. Os argumentos são passados no estilo bash, o primeiro argumento é `$1`, o
   segundo, `$2`, etc.
3. Quando `./configure` é executado:
    - Compila o programa teste
    - Se compilar com sucesso: padrão suportado ("yes")
    - Se falhar (devido ao `#error`): padrão não suportado ("no")

## 6.4. Código do configure.ac

```autoconf
AC_INIT([epp], [1.0])

m4_include([m4/checks.m4])

AC_PROG_CC
AC_PROG_CXX

AC_LANG_PUSH([C])
CHECK_C_STANDARD([11], [201112L])  # C11
CHECK_C_STANDARD([17], [201710L])  # C17
CHECK_C_STANDARD([23], [202311L])  # C23
AC_LANG_POP([C])

AC_LANG_PUSH([C++])
CHECK_CXX_STANDARD([11], [201103L])  # C++11
CHECK_CXX_STANDARD([14], [201402L])  # C++14
CHECK_CXX_STANDARD([17], [201703L])  # C++17
CHECK_CXX_STANDARD([20], [202002L])  # C++20
CHECK_CXX_STANDARD([23], [202302L])  # C++23
AC_LANG_POP([C++])

AC_OUTPUT
```

- `AC_LANG_PUSH([lang])` e `AC_LANG_POP([lang])`: indicam qual linguagem o
  Autoconf está lidando na hora de compilar o programa passado

## 6.4. Saída Esperada

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
checking for g++... g++
checking whether the compiler supports GNU C++... yes
checking whether g++ accepts -g... yes
checking for g++ option to enable C++11 features... none needed
checking for C11 support... yes
checking for C17 support... yes
checking for C23 support... no
checking for C++11 support... yes
checking for C++14 support... yes
checking for C++17 support... yes
checking for C++20 support... no
checking for C++23 support... no
configure: creating ./config.status
```
