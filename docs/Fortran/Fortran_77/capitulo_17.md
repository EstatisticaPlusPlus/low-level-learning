---
title: "17. Recursos Adicionais"
---

# 17. Recursos Adicionais

### Compiladores Gratuitos

- **gfortran**: Compilador GNU para Fortran (recomendado)
  - Download: [GNU Fortran](https://gcc.gnu.org/fortran/)
  - Disponível para Windows, Linux e macOS

- **Intel Fortran**: Versão gratuita para estudantes
  - Download: [Intel OneAPI](https://www.intel.com/content/www/us/en/developer/tools/oneapi/fortran-compiler.html)

### Livros Recomendados

1. **"Fortran 77 for Engineers and Scientists"** - Larry Nyhoff
2. **"Introduction to Fortran 77"** - Ian Chivers
3. **"Fortran 77: Reference Manual"** - Sun Microsystems

### Links Úteis

- [Fortran Wiki](https://fortranwiki.org/)
- [Netlib](http://www.netlib.org/) - Biblioteca de rotinas matemáticas
- [Fortran Standards](https://wg5-fortran.org/) - Padrões oficiais

### Ferramentas de Desenvolvimento

- **Visual Studio Code** com extensão Fortran
- **Eclipse** com plugin Photran
- **Emacs** com modo Fortran

### Comunidades Online

- [Stack Overflow - Fortran](https://stackoverflow.com/questions/tagged/fortran)
- [Reddit r/fortran](https://www.reddit.com/r/fortran/)
- [Fortran Discourse](https://fortran-lang.discourse.group/)

### Próximos Passos

Após dominar Fortran 77, considere aprender:

1. **Fortran 90/95**: Recursos modernos como alocação dinâmica
2. **Fortran 2003/2008**: Programação orientada a objetos
3. **Fortran 2018**: Recursos mais recentes

### Troubleshooting Comum

| Problema | Causa | Solução |
|----------|-------|---------|
| Erro de formatação | Código fora das colunas 7-72 | Verificar indentação |
| Variável não declarada | Falta `IMPLICIT NONE` | Adicionar declaração explícita |
| Erro de compilação | Sintaxe moderna | Usar apenas sintaxe F77 |
| Erro de execução | Índice fora dos limites | Verificar limites de arrays |

---

**Nota:** Este guia cobre os fundamentos do Fortran 77. Para projetos modernos, considere usar versões mais recentes do Fortran que oferecem recursos mais avançados e melhor segurança de tipos.
