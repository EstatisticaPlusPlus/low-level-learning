---
title: "9. Verificação do sinal do char"
---

# 9. Verificação do sinal do char

Em algumas circunstâncias, o tipo char pode ser definido
como signed ou unsigned. Uma diferença simples que pode
acarreta em grandes mudanças na forma como funções com
retorno char podem ser usadas.

Dessa forma, é necessário descobrir como detectar essa
diferença, e como um bônus, também descobriremos outros
tipos que poderão ser analisados com o método a ser
apresentado

Testaremos de duas maneiras: a primeira especifica para o
tipo char e a segunda sendo mais geral

## 9.1. Maneira Especifica

### 9.1.1. Macros utilizadas

```
# configure.ac

AC_INIT([epp], [7.38])

AC_PROG_CC

m4_include([m4/check.m4])

check_char_sign

AC_OUTPUT
```

```
# m4/check.m4
AC_DEFUN(check_char_sign, [
    AC_MSG_CHECKING([if char is signed])
    AC_RUN_IFELSE([AC_LANG_PROGRAM([],
    [[
        #include <stdio.h>

        int main(int argc, char *argv[]) {
            char bbb = 0;
            --bbb;

            if (bbb == -1) {
                return 1;
            } else {
                return 0;
            }
        }
    ]]
    )],
    [AC_MSG_RESULT(signed)],
    [AC_MSG_RESULT(unsigned)])
])
```

O primeiro exemplo dado se utiliza de um evento simples que
acontece ao tentar diminuir 1 de uma variável unsigned com o
valor 0: integer overflow.

O programa acima define uma macro que compila e executa um
programa simples que tenta subtrair 1 da variável char
definida inicialmente como 0. Após a subtração, caso a
variável seja -1, o programa retorna 1 e o macro
AC_RUN_IFELSE executa o primeiro ramo da condicional, caso
contrário, a variável será 255 e o programa retornará 0,
executando o segundo ramo da condicional

Essa maneira de verificar é aceitável, pois obtém o
resultado esperado, porém há compiladores e flags que podem
se recusar a executar um programa com um overflow ou
underflow, por isso é necessário pensar em uma maneira
diferente de resolver esse problema

## 9.2. Maneira Geral

### 9.2.1. Macro utilizada

```
# configure.ac
AC_INIT([epp], [20.08])

AC_PROG_CC

m4_include([m4/check.m4])

check_char_sign

AC_OUTPUT
```

```
# m4/check.m4
AC_DEFUN(check_char_sign, [
    AC_MSG_CHECKING([if char is signed])
    AC_RUN_IFELSE([AC_LANG_PROGRAM([],
    [[
        #include <limits.h>

        int main(int argc, char *argv[]) {
            if(CHAR_MIN < 0) {
                return 1;
            } else {
                return 0;
            }
    ]]
    )],
    [AC_MSG_RESULT(signed)],
    [AC_MSG_RESULT(unsigned)])
])
```

O programa acima segue uma filosofia diferente, não há
nenhum truque de aritmética com o tipo char, apenas uma
condicional simples com um header padrão do C.

`CHAR_MIN` é definido dentro do header `limits.h`, junto de
muitos mínimos, máximos e alguns outros limites do sistema.
Caso `CHAR_MIN` seja menor que 0, é simples concluir que
`char` é signed, então retornamos 1 e a compilação
condicional do `AC_RUN_IFELSE` executa o primeiro ramo, caso
contrário concluímos que `char` é unsigned e retornamos 0 do
programa, executando o segundo ramo do macro.

Essa forma de testar evita alguns problemas com compiladores
e flags que possam impedir o programa anterior de executar e
acabar retornando o resultado errado.

Outros limites podem ser testados, como `int` e `float`, de
uma forma similar.
