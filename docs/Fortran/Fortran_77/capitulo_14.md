---
title: "14. Boas Práticas e Problemas Comuns"
---

# 14. Boas Práticas e Problemas Comuns

### Boas Práticas

#### 1. Estrutura do Programa
```fortran
c234567
      PROGRAM NOME_PROGRAMA
      IMPLICIT NONE
      
      ! Declarações de variáveis
      INTEGER I, J, K
      REAL X, Y, Z
      
      ! Declarações de parâmetros
      PARAMETER (PI = 3.14159)
      
      ! Inicializações
      DATA X /0.0/, Y /0.0/
      
      ! Corpo principal do programa
      ...
      
      STOP
      END
```

#### 2. Nomenclatura
- Use nomes descritivos (dentro do limite de 6 caracteres)
- Use maiúsculas para constantes: `PI`, `MAXSIZ`
- Use minúsculas para variáveis: `i`, `j`, `x`, `y`
- Evite nomes muito similares: `i`, `l`, `1` podem ser confusos

#### 3. Comentários
```fortran
c234567
      ! Este é um comentário moderno (Fortran 90+)
c     Este é um comentário Fortran 77
*     Este também é um comentário Fortran 77
```

#### 4. Formatação
- Sempre use `IMPLICIT NONE`
- Mantenha código nas colunas 7-72
- Use indentação consistente
- Agrupe declarações relacionadas

### Problemas Comuns e Soluções

#### 1. Erros de Compilação

**Problema:** `Error: Unexpected end of file`
```fortran
      PROGRAM TESTE
      IMPLICIT NONE
      INTEGER I
      I = 1
      ! Falta STOP e END
```
**Solução:** Sempre inclua `STOP` e `END` no final do programa.

**Problema:** `Error: Variable 'X' is used but not declared`
```fortran
      PROGRAM TESTE
      IMPLICIT NONE
      REAL Y
      X = 1.0  ! X não foi declarado
```
**Solução:** Declare todas as variáveis ou remova `IMPLICIT NONE`.

#### 2. Erros de Execução

**Problema:** `Floating point exception`
```fortran
      REAL X, Y
      X = 1.0
      Y = 0.0
      X = X / Y  ! Divisão por zero
```
**Solução:** Sempre verifique divisores antes da divisão.

**Problema:** `Array bounds exceeded`
```fortran
      INTEGER A(5)
      DO I = 1, 10  ! I vai de 1 a 10, mas A só tem 5 elementos
          A(I) = I
      END DO
```
**Solução:** Verifique sempre os limites dos arrays.

#### 3. Problemas de Lógica

**Problema:** Comparação de números reais
```fortran
      REAL X, Y
      X = 0.1
      Y = 0.1
      IF (X .EQ. Y) THEN  ! Pode falhar devido à precisão
```
**Solução:** Use tolerância para comparações de números reais.
```fortran
      REAL X, Y, TOL
      PARAMETER (TOL = 1.0E-6)
      IF (ABS(X - Y) .LT. TOL) THEN
```

**Problema:** Loop infinito
```fortran
      I = 1
10    IF (I .LT. 10) THEN
          PRINT *, I
          ! Falta incrementar I
          GOTO 10
      END IF
```
**Solução:** Sempre incremente a variável de controle do loop.

### Dicas de Debugging

#### 1. Usando PRINT para Debug
```fortran
      ! Adicione prints estratégicos
      PRINT *, 'Valor de X antes do loop:', X
      DO I = 1, N
          X = X + I
          IF (MOD(I, 100) .EQ. 0) THEN
              PRINT *, 'Iteração', I, 'X =', X
          END IF
      END DO
      PRINT *, 'Valor de X após o loop:', X
```

#### 2. Verificação de Bounds
```fortran
      ! Sempre verifique limites antes de usar arrays
      IF (I .LT. 1 .OR. I .GT. N) THEN
          PRINT *, 'Erro: Índice', I, 'fora dos limites 1-', N
          STOP
      END IF
      A(I) = VALOR
```

#### 3. Validação de Entrada
```fortran
      ! Valide sempre a entrada do usuário
      READ *, N
      IF (N .LE. 0 .OR. N .GT. MAXSIZ) THEN
          PRINT *, 'Erro: N deve estar entre 1 e', MAXSIZ
          STOP
      END IF
```

### Performance e Otimização

#### 1. Acesso a Arrays
```fortran
      ! ❌ Ruim: Acessa em ordem incorreta
      DO I = 1, N
          DO J = 1, M
              A(J, I) = A(J, I) + 1  ! Segunda dimensão varia primeiro
          END DO
      END DO
      
      ! ✅ Bom: Acessa em ordem de memória
      DO J = 1, M
          DO I = 1, N
              A(J, I) = A(J, I) + 1  ! Primeira dimensão varia primeiro
          END DO
      END DO
```

#### 2. Evite Operações Desnecessárias
```fortran
      ! ❌ Ruim: Calcula potência repetidamente
      DO I = 1, N
          Y = X**2  ! Calcula X^2 N vezes
      END DO
      
      ! ✅ Bom: Calcula uma vez
      X2 = X**2
      DO I = 1, N
          Y = X2
      END DO
```

### Checklist de Qualidade

Antes de considerar seu programa finalizado, verifique:

- [ ] Todas as variáveis estão declaradas
- [ ] `IMPLICIT NONE` está presente
- [ ] `STOP` e `END` estão no final
- [ ] Código está nas colunas 7-72
- [ ] Arrays não excedem limites
- [ ] Divisões por zero estão protegidas
- [ ] Loops têm condição de parada
- [ ] Comentários explicam lógica complexa
- [ ] Nomes de variáveis são descritivos
- [ ] Programa foi testado com diferentes entradas
