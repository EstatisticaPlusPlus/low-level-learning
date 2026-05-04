---
title: "16. Material deste guia"
---

# 16. Material deste guia

### Diretório de Exemplos

Este guia possui um diretório `f77_examples/` contendo todos os exemplos práticos mencionados ao longo do texto. Cada exemplo está organizado em arquivos separados para facilitar o estudo e prática.

#### Estrutura do Diretório
```
f77_examples/
├── 1.hello_world.f          # Exemplo básico de Hello World
├── 2.tipagem.f              # Demonstração de tipos de dados
├── 3.cadastro.f             # Exemplo de condicionais
├── 4.1.loop.f               # Loops básicos
├── 4.2.whiledo.f            # Loops while
├── 4.3.untildo.f            # Loops until
├── 5.1.quadrado.f           # Funções
├── 5.2.quad_cubo.f          # Subrotinas
├── 6.1.array_basico.f       # Arrays básicos
├── 6.2.array_soma.f         # Operações com arrays
├── 6.3.array_produto.f      # Produto de elementos
├── 7.1.inicializacao.f      # Inicialização com DATA
├── 7.2.inicializacao_alt.f  # Inicialização alternativa
├── 7.3.inicializacao_matricial.f  # Inicialização de matrizes
├── 8.IO.f                   # Entrada e saída de arquivos
├── 9.format.f               # Formatação de saída
├── 10.solucao_linear.f      # Exemplo com bibliotecas (LAPACK)
├── points.dat               # Arquivo de dados para exemplo 8
└── Makefile                 # Script de compilação automática
```

### Makefile para Compilação Rápida

O diretório inclui um `Makefile` que facilita a compilação e execução dos exemplos. Este arquivo automatiza o processo de compilação, evitando a necessidade de digitar comandos longos manualmente.

#### Comandos Disponíveis

```bash
# Compilar todos os exemplos
make 

# Compilar um exemplo específico
make 1.hello_world
make 2.tipagem
make 3.cadastro

# Executar um exemplo específico
make run-1.hello_world
make run-2.tipagem

# Limpar arquivos compilados
make clean

# Listar todos os exemplos disponíveis
make list
```

#### Como Usar

1. **Navegue até o diretório de exemplos:**
   ```bash
   cd f77_examples/
   ```

2. **Compile todos os exemplos:**
   ```bash
   make 
   ```

3. **Execute um exemplo específico:**
   ```bash
   make run-1.hello_world
   ```

4. **Para exemplos que requerem bibliotecas externas (como o exemplo 10):**
   ```bash
   make 10.solucao_linear
   ```


### Sugestões de Uso

1. **Estudo Sequencial**: Execute os exemplos na ordem numérica para seguir a progressão do guia
2. **Experimentação**: Modifique os exemplos para testar diferentes cenários
3. **Debugging**: Use o Makefile para recompilar rapidamente após modificações
4. **Comparação**: Execute exemplos similares para ver as diferenças na prática

### Requisitos

- Compilador Fortran (gfortran recomendado)
- Make (geralmente já instalado em sistemas Unix/Linux)
- Para o exemplo 10: bibliotecas LAPACK/BLAS (opcional)

---
Use o Makefile como ponto de partida para seus próprios projetos. Ele é boa práticas de organização e automação.
