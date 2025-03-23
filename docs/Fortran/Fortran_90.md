---
title: "Fortran 90"
---

# Capítulo 1 - Introdução

Neste capítulo, visamos apresentar a linguagem Fortran (na versão Fortran 90) do zero, assumindo pouca familiaridade com programação, mas algum conhecimento de métodos numéricos – que, embora não obrigatórios, facilitarão a compreensão de algumas motivações e métodos. Ao longo deste capítulo, serão apresentados os conceitos básicos necessários para construir, por exemplo, uma implementação funcional do Método da Bisseção.

## Características da Linguagem

- **Diferenças para o Fortran 77:**  
  *Fixed-form vs. free-form*  
- **Vantagens e desvantagens** para determinadas aplicações.

## Compilação e suas Etapas

Antes de começarmos a programar, é importante entender alguns termos:

- **Código-fonte:**  
  Arquivo escrito em Fortran (extensão `.f90`) contendo as instruções do programa.  
  *Exemplo visual: imagem de código fonte (não incluída aqui).*

- **Compilador:**  
  Programa (por exemplo, `gfortran`) que traduz o código-fonte em instruções que o computador pode executar.

- **Arquivo Executável:**  
  Arquivo resultante da compilação, que é executado pelo sistema operacional.  
  *Exemplo visual: imagem de um executável aberto em um editor de texto.*

### Instalação e Uso do Compilador

- **Como instalar o compilador (`gfortran`):**  
  Siga as instruções específicas para seu sistema operacional.

- **Compilando um Código-Fonte:**  
  ```bash
  gfortran -o programa exemplo.f90
  ```

- **Executando o Programa Compilado:**  
  ```bash
  ./programa
  ```

## Estrutura Básica de um Programa

Todo programa em Fortran deve ter um bloco `program` com o nome do programa. Veja o exemplo clássico "Olá mundo!":

```fortran
program exemplo
    print *, 'Olá mundo!'
end program exemplo
```

O comando `print` usa um argumento de formatação (aqui `*`, que significa formatação padrão) seguido dos dados a serem impressos.

### Variáveis

Fortran é **fortemente tipado**, ou seja, todas as variáveis devem ser declaradas com seu tipo. Os tipos básicos são:

- `integer` – números inteiros (positivos ou negativos)
- `real` – números em ponto flutuante
- `complex` – números complexos (parte real e imaginária)
- `character` – cadeias de caracteres
- `logical` – valores booleanos (.true. ou .false.)

#### Exemplo de Declaração:
```fortran
program variaveis
    implicit none

    integer :: i
    real :: distancia
    complex :: frequencia
    character :: inicial
    logical :: eh_primo

    i = 1
    distancia = 1.41421356
    frequencia = (1.0, -0.5)
    inicial = "f"
    eh_primo = .false.
end program variaveis
```

*Nota:* Use `implicit none` para evitar tipagem implícita (por exemplo, variáveis iniciadas com I, J, K... são automaticamente inteiros em versões antigas).

#### Precisão de Variáveis

- **Float32 (real padrão):** Aproximadamente 6–9 dígitos de precisão.  
- **Float64:** Para maior precisão, use o módulo `iso_fortran_env`:
  ```fortran
  use, intrinsic :: iso_fortran_env
  implicit none

  real(real64) :: valor
  ```
  Literais de 64 bits podem ser escritos com um sufixo, por exemplo, `1.0_real64`.

### Operações Básicas

Fortran possui os seguintes operadores aritméticos (em ordem de precedência):

| Operador | Operação         |
|----------|------------------|
| **       | Exponenciação    |
| *        | Multiplicação    |
| /        | Divisão          |
| +        | Adição           |
| -        | Subtração        |

*Exemplo:*  
```fortran
program media
    print *, (3 + 4 + 5) / 2
end program media
```
*Dica:* Lembre-se de usar parênteses para alterar a ordem natural de precedência.  
*Observação:* Operações entre inteiros geram inteiros; para obter frações, use números reais.

### Comentários

Comentários iniciam com `!` e são úteis para documentar o código.
```fortran
program comentarios
    implicit none
    ! Esta linha é um comentário
    real :: alpha  ! Coeficiente do termo linear
    print *, alpha
end program comentarios
```

## Funções e Módulos

Funções e módulos promovem a modularidade e a reutilização de código.

### Funções

Funções retornam um valor único. A sintaxe básica é:
```fortran
function nome_funcao(arg1, arg2) result(var_result)
    implicit none
    tipo1, intent(in) :: arg1
    tipo2, intent(in) :: arg2
    tipo3 :: var_result

    ! Corpo da função
    return
end function nome_funcao
```

*Exemplo – Calculando a norma do dobro de um vetor em R² (cuidado com efeitos colaterais):*
```fortran
function norma_dobro(v1, v2) result(norma)
    real, intent(in) :: v1, v2
    real :: norma

    norma = sqrt((2*v1)**2 + (2*v2)**2)
    return
end function norma_dobro
```
Se for necessário evitar modificar os argumentos, use variáveis auxiliares.

### Funções Intrínsecas

Fortran possui diversas funções intrínsecas que são otimizadas, como:
- `ABS`
- `MAX`
- `LOG`
- `SQRT`
- `ATAN`
- `CONJG`

Utilize-as sempre que possível.

### Módulos

Módulos permitem agrupar funções e variáveis:
```fortran
module normas
    implicit none
contains
    function norma_do_dobro(v1, v2) result(norma)
        real, intent(in) :: v1, v2
        real :: coord1, coord2, norma
        coord1 = 2*v1
        coord2 = 2*v2
        norma = sqrt(coord1**2 + coord2**2)
        return
    end function norma_do_dobro
end module normas
```
Para utilizar o módulo:
```fortran
program calcula_norma
    use normas
    implicit none
    real :: norma_calculada, vec1, vec2

    vec1 = 1.0
    vec2 = 1.0

    print *, vec1, vec2
    norma_calculada = norma_do_dobro(vec1, vec2)
    print *, norma_calculada
    print *, vec1, vec2
end program calcula_norma
```

## Estruturas Condicionais

Para executar trechos de código dependendo de condições:
```fortran
if (expressao_logica) then
    ! Código se verdadeiro
else
    ! Código se falso
end if
```

*Exemplo – Função Valor Absoluto:*
```fortran
function absoluto(x) result(y)
    real, intent(in) :: x
    real :: y
    y = x
    if (x < 0) then
        y = -y
    end if
    return
end function absoluto
```

*Exemplo – Função Heaviside:*
```fortran
function heaviside(x) result(y)
    real, intent(in) :: x
    real :: y
    if (x >= 0) then
        y = 1
    else
        y = 0
    end if
    return
end function heaviside
```

*Dica:* Para evitar muitos IF's aninhados, utilize a técnica de inversão lógica (testar condições opostas com `return`) ou extraia o teste em uma função separada.

## Repetição - `DO`

A repetição é feita com o comando `do`:
```fortran
do iterador = valor_inicial, valor_final, passo
    ! Código a repetir
end do
```

*Exemplo – Somatório de 1/(k²) de k = 1 até n:*
```fortran
program somatorio
    implicit none
    real :: valor
    integer :: k, n
    valor = 0.0
    n = 100
    do k = 1, n
        valor = valor + 1.0/(k*k)
    end do
    print *, valor
end program somatorio
```

*Observações:*
- O passo padrão é 1 (pode ser omitido).
- Para passos fracionários, itere com inteiros e ajuste (por exemplo, `k/10.0`).
- É possível iterar com passos negativos.

## Subrotinas

Subrotinas são usadas quando se deseja modificar os argumentos e/ou retornar múltiplos valores. A sintaxe é:
```fortran
subroutine nome_subrotina(arg1, arg2, arg3)
    implicit none
    tipo1, intent(in) :: arg1
    tipo2, intent(inout) :: arg2
    tipo3, intent(out) :: arg3

    ! Corpo da subrotina
    return
end subroutine nome_subrotina
```

*Exemplo:*
```fortran
program chama_subrotina
    implicit none
    integer :: N, QUADRADO, CUBO
    print *, 'Digite um número:'
    read *, N
    call calcula_quadrado_e_cubo(N, QUADRADO, CUBO)
    print *, 'O quadrado de', N, 'é', QUADRADO
    print *, 'O cubo de', N, 'é', CUBO
end program chama_subrotina

subroutine calcula_quadrado_e_cubo(X, QUAD, CUB)
    implicit none
    integer, intent(in) :: X
    integer, intent(out) :: QUAD, CUB
    QUAD = X * X
    CUB = X * X * X
    return
end subroutine calcula_quadrado_e_cubo
```

## Construindo o Método da Bisseção

O método da bisseção segue os seguintes passos:
1. Definir a função cuja raiz se deseja encontrar e o intervalo inicial.
2. Calcular o ponto médio do intervalo.
3. Verificar se a função no ponto médio é zero.
4. Se sim, retornar o ponto; caso contrário, determinar o novo intervalo baseado no sinal da função.
5. Repetir até que um critério de parada seja atingido (por exemplo, número máximo de iterações).

*Você deverá estruturar uma função que implemente esses passos conforme o exercício proposto.*

## Formatação de Saídas

O comando `write` permite formatar a saída. Sua sintaxe é:
```fortran
write (*, label) lista_de_variaveis
label format-code
```

### Exemplos de Códigos de Formatação
- **A:** string
- **D:** números double precision (notação exponencial)
- **E:** números reais (notação exponencial)
- **F:** números reais (formato fixo)
- **I:** inteiro
- **X:** espaço horizontal
- **/**: salto de linha

*Exemplo:*
```fortran
program formatacao
    data m/10/, n/20/, x/2.5/, y/2.5/
    real :: m, n, x, y
    write (*,100) m
100 format (I2)
    write (*,'(I2)') n  
    write (*,300) x
300 format (F4.1)
    write (*,400) y
400 format (E8.2)
    stop
end program formatacao
```

## Repetição - `GOTO`

Embora Fortran 90 possua estruturas modernas, em Fortran 77 é comum usar `do` junto com `goto` para simular loops *while*.

*Exemplo de loop com GOTO:*
```fortran
program exemplo_while
    implicit none
    integer :: a(10), I
    data a /1, 2, 3, 4, 5, 6, 7, 8, 9, 10/
    I = 1
10  if (a(I) /= 5) then
       print *, 'Elemento', I, ':', a(I)
       I = I + 1
       goto 10
    end if
end program exemplo_while
```

## Imports e Linkagem

Este tópico aborda como importar módulos e ligar bibliotecas externas para compilar programas mais complexos.

# Capítulo 2 - Matrizes, Vetores e Operações Vetoriais

*Conteúdo deste capítulo a ser desenvolvido – abordará a declaração e manipulação de vetores, matrizes e operações vetoriais, com exemplos e técnicas específicas para Fortran.*

