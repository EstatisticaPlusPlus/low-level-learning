---
title: "13. Bibliotecas"
---

# 13. Bibliotecas

Como em qualquer outra linguagem, é possível utilizar pacotes já criados (muitos gratuitos) para resolver problemas comuns. Para problemas numéricos, por exemplo, a plataforma Netlib disponibiliza softwares e databases de interesse científico, como os pacotes **BLAS** e **LAPACK**.

### BLAS

- Acrônimo de Basic Linear Algebra Subroutines.
- Contém subprogramas para operações com vetores e matrizes.
- Suas rotinas são organizadas em três níveis:
  - **Nível 1:** Operações vetor x vetor.
  - **Nível 2:** Operações matriz x vetor.
  - **Nível 3:** Operações matriz x matriz.
- A primeira letra dos nomes dos subprogramas indica a precisão:
  - **S:** Real precisão única.
  - **D:** Real precisão dupla.
  - **C:** Complexo precisão única.
  - **Z:** Complexo precisão dupla.

### LAPACK

- Construído sobre BLAS, é uma coleção para problemas avançados de álgebra linear.
- Documentação disponível em:
  - [LAPACK Home](http://www.netlib.org/lapack/)
  - [LAPACK User's Guide](http://www.netlib.org/lapack/lug/lapack_lug.html)
- Ao instalar, coloque os arquivos `.lib` (no Windows) ou `.a` (no Linux) em um diretório apropriado. Certifique-se de ajustar os caminhos de compilação conforme necessário. O BLAS deve ser especificado por último no comando de compilação.


```fortran
c234567
      PROGRAM SolveLinearSystem
      IMPLICIT NONE

      INTEGER :: n, nrhs, lda, ldb, info
      PARAMETER (n = 3, nrhs = 1, lda = n, ldb = n)

      REAL :: A(lda, n), B(ldb, nrhs)
      INTEGER :: ipiv(n)

      EXTERNAL SGESV
  
      DATA A / 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 10.0 /
      DATA B / 6.0, 15.0, 25.0 /

      PRINT *, 'Starting the linear system solver...'
      
      CALL SGESV(n, nrhs, A, lda, ipiv, B, ldb, info)

      PRINT *, 'SGESV call completed.'

      IF (info .EQ. 0) THEN
          PRINT *, 'The solution is:'
          PRINT *, B
      ELSE
          PRINT *, 'An error occurred: info =', info
      END IF

      PRINT *, 'Program finished.'
      
      STOP      
      END
```
*Exemplo 10: Solução de Sistema Linear*

Para compilar:

```bash
$ gfortran 10.solucao_linear.f -o 10.solucao_linear -LC:/msys64/mingw64/lib -llapack -lblas

```
*ou para openblas*
```bash
$ gfortran 10.solucao_linear.f -o 10.solucao_linear -LC:/msys64/mingw64/lib -lopenblas
```

*Observação:* O diretório especificado após `-LC:` deve conter as bibliotecas necessárias. Lembre-se que se você for usar LAPACK, ele depende do BLAS, o qual deve ser listado por último no comando. No meu caso, optei por usar o Open_Blas porque as instalações dessas bibliotecas podem conflitar entre o uso no Microsoft Visual Studio e no MSYS2 caso esteja no Windows, esteja atento à extensão instalada na sua máquina - Microsoft Studio usa .lib enquanto MinGW/gfortran usam .a / .dll.a.

A maior complicação pode estar na depuração de erros relacionados a versões de DLLs e compatibilidade com a arquitetura da CPU. Em edições futuras, abordaremos a construção de pacotes e a compilação de versões específicas da BLAS ou LAPACK para sua máquina.
