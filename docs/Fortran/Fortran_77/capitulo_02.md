---
title: "2. Básico"
---

# 2. Básico

### Estrutura do Programa

A estrutura principal do código F77 é da forma:

```fortran
c234567	
      program *nome*
      
      *declarações de variáveis*
      
      *comandos*
      
      stop
      end
```

### Formatação de Colunas

A formatação da versão 77 é rígida, seguindo um padrão ditado pelo número referente à coluna no editor de texto, da seguinte forma:

| Coluna | Uso | Descrição |
|--------|-----|-----------|
| 1 | Vazia ou "c" ou "*" | Comentário (opcional) |
| 1-5 | Número de label | Categoria da declaração da linha |
| 6 | Qualquer caractere | Continuação da linha prévia (opcional) |
| 7-72 | Código | Comando principal |
| 73-80 | Número | Número de sequência (uso incomum) |

**Exemplo Visual da Formatação:**
```
c2345678901234567890123456789012345678901234567890123456789012345678901234567890
      program hello
      implicit none
      integer i
      i = 1
      write(*,*) 'Hello World'
      stop
      end
```

> **⚠️ Importante:** Não podemos ter uma variável com o mesmo nome que o programa.

### Primeiro Programa

```fortran
c234567
      PROGRAM HELLO
      IMPLICIT NONE
      WRITE(UNIT=*, FMT=*) 'Hello World'
      STOP
      END
```
*exemplo 1: Hello World. Note que os comandos começam a partir da coluna 7*

> **💡 Dica:** O comando `write(UNIT=*, FMT=*)` também pode ser escrito como `write(*,*)`, o que é uma simplificação usual na atribuição desses argumentos compulsórios.