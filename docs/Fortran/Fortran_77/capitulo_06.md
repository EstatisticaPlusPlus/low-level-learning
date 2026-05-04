---
title: "6. Loops"
---

# 6. Loops

### Tipos de Loops em Fortran 77

Fortran 77 oferece três tipos principais de loops, cada um com suas características específicas:

| Tipo | Sintaxe | Quando Usar | Vantagens | Desvantagens |
|------|---------|-------------|-----------|--------------|
| **DO Loop** | `DO label var = start, end, step` | Número conhecido de iterações | Simples, eficiente | Limitado a incrementos fixos |
| **While Loop** | `label IF (cond) THEN ... GOTO label` | Condição de continuação | Flexível | Usa GOTO (considerado má prática) |
| **Until Loop** | `label ... IF (cond) GOTO label` | Condição de parada | Flexível | Usa GOTO (considerado má prática) |

### DO Loops

A sintaxe geral é:

```fortran
c234567
      do label var = expr1, expr2, expr3
          statements
      label continue
```

**Parâmetros:**
- **var:** variável do loop (deve ser inteiro)
- **expr1:** valor inicial
- **expr2:** valor limitante
- **expr3:** incremento (opcional, padrão é 1)

**Características:**
- A variável é incrementada automaticamente
- O loop termina quando var > expr2 (se expr3 > 0) ou var < expr2 (se expr3 < 0)
- A variável pode ser modificada dentro do loop (não recomendado)

```fortran
c234567
      PROGRAM SHOW
      IMPLICIT NONE
      
      INTEGER a(10), I
      
      DATA a /1, 2, 3, 4, 5, 6, 7, 8, 9, 10/
      
      DO 10 I = 1, 10
          PRINT *, 'Elemento', I, ':', a(I)
10    CONTINUE
      
      END
```
*exemplo 4.1: loop simples*

**Variações do DO Loop:**
```fortran
c234567
      ! Loop com incremento diferente de 1
      DO 20 I = 1, 10, 2
          PRINT *, I
20    CONTINUE
      
      ! Loop decrescente
      DO 30 I = 10, 1, -1
          PRINT *, I
30    CONTINUE
```

### While Loops (Condição de Progresso)

O programador atual está acostumado com o formato:

```fortran
c234567
      while (logical expr) do
        statements
      enddo
```

Mas ele **não é ANSI Fortran 77**. O adequado é:

```fortran
c234567
      label if (logical expr) then
          statements
          goto label
      end if
```

**Quando usar:** Quando você não sabe quantas iterações serão necessárias, mas sabe a condição de continuação.

```fortran
c234567
      PROGRAM WOW
      IMPLICIT NONE
      
      INTEGER a(10), I
      
      DATA a /1, 2, 3, 4, 5, 6, 7, 8, 9, 10/
      
      I = 1
      
10    IF (a(I) /= 5) THEN
          PRINT *, 'Elemento', I, ':', a(I)
          I = I + 1
          GOTO 10
      END IF
      
      END
```
*exemplo 4.2: While do*

### Until Loops (Condição de Parada)

Um exemplo de loop "until" usando `goto`:

```fortran
c234567
10    CONTINUE
      PRINT *, 'Elemento', I, ':', a(I)
      I = I + 1
      IF (a(I) /= 9) THEN		
          GOTO 10
      END IF
      END
```
*exemplo 4.3: Until do*

**Quando usar:** Quando você quer executar o corpo do loop pelo menos uma vez e depois verificar a condição de parada.

### Comparação Prática

| Cenário | Loop Recomendado | Exemplo |
|---------|------------------|---------|
| Iterar sobre array conhecido | DO Loop | `DO 10 I = 1, N` |
| Ler até encontrar sentinela | While Loop | `WHILE (valor /= -1)` |
| Processar até condição | Until Loop | `UNTIL (convergiu)` |
| Contagem regressiva | DO Loop | `DO 20 I = N, 1, -1` |

### ⚠️ Considerações sobre GOTO

O uso de `GOTO` é considerado má prática em programação moderna, mas em Fortran 77 é frequentemente necessário para implementar loops while e until. Em versões mais modernas do Fortran, use `DO WHILE` e `DO UNTIL`.
