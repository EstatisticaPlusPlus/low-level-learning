---
title: "5. Operadores Lógicos e Condicionais"
---

# 5. Operadores Lógicos e Condicionais

### Operadores Lógicos

Para comparar expressões, utilizamos operadores relacionais que avaliam como `.True.` ou `.False.`:

- `.LT.` : "menor que" (equivalente a `<`)
- `.GT.` : "maior que" (equivalente a `>`)
- `.LE.` : "menor ou igual" (equivalente a `<=`)
- `.GE.` : "maior ou igual" (equivalente a `>=`)
- `.EQ.` : "igual" (equivalente a `=`)
- `.NQ.` : "diferente" (equivalente a `!=`)

Outros termos úteis são:
- `.AND.`
- `.OR.`
- `.NOT.`

### Condicionais

Condições são estruturadas de três maneiras:

1. **Condição em linha única:**  
   Se a condição lógica for verdadeira, execute o comando.
   ```fortran
         if (x .LT. 0) x = -x
   ```

2. **Condição com múltiplos comandos:**  
   ```fortran
         if (condição lógica) then
             comandos
         endif
   ```

3. **Condição com alternativas:**  
   ```fortran
         if (condição lógica) then
             comandos
         elseif (outra condição lógica) then
             comandos
         else
             comandos
         endif
   ```

#### Exemplo: Cadastro de Números Telefônicos com DDD

```fortran
c234567
      PROGRAM CONDITIONALS
      IMPLICIT NONE
      CHARACTER*11 NUMBER
      CHARACTER*9 REST
      INTEGER LEN

      write (*,*) 'Input Number:'
      read (*,*) NUMBER
      
      LEN = LEN_TRIM(NUMBER)
      
      IF (LEN .GT. 3) THEN
          REST = NUMBER(3:LEN)
      ELSE
          REST = ''
      END IF
      
      IF (LEN .LT. 8 .OR. LEN .GT. 11) then
          write(*,*) 'Invalid Number'
      ELSE IF (LEN .EQ. 8 .OR. LEN .EQ. 9) then
          write(*,*) NUMBER
      ELSE IF (LEN .EQ. 10 .OR. LEN .EQ. 11) then	      
          write(*,*) 'DDD and number are ', NUMBER(1:2) // ' ' // REST
      END IF
      
      STOP
      END
```
*exemplo 3: cadastro de telefone*

*Funcionamento do Programa:*  
- Solicita ao usuário um número de telefone (string).
- Calcula o comprimento real da string com `LEN_TRIM`.
- Se o comprimento for menor que 8 ou maior que 11, imprime "Invalid Number".
- Se for 8 ou 9, imprime o número diretamente.
- Se for entre 10 e 11, imprime o DDD (dois primeiros caracteres), um espaço e o restante do número.
