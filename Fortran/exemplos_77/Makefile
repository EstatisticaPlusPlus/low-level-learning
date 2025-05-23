# Compilador 

FC = gfortran
FFLAGS = -std=legacy -Wall #flag para seguir formatação legado 77
LIBS = -lopenblas

# arquivos-fonte 
EXAMPLES = 1.hello_world 2.tipagem 3.cadastro 4.1.loop 4.2.whiledo 4.3.untildo 5.1.quadrado 5.2.quad_cubo 6.1.array_basico 6.2.array_soma 6.3.array_produto 7.1.inicializacao 7.2.inicializacao_alt 7.3.inicializacao_matricial  8.IO 9.format 10.solucao_linear

# make default
all: $(EXAMPLES)

#Caso especial para o último exemplo
10.solucao_linear: 10.solucao_linear.f
	$(FC) $(FFLAGS) -o $@ $< $(LIBS)

# Regra para compilar cada exemplo 
%: %.f
	$(FC) $(FFLAGS) -o $@ $<

# Limpar os binários gerados
clean:
	rm -f $(EXAMPLES)



# Para compilar todos os arquivos de uma vez: abra o terminal no diretório desse arquivo e digite make

# Para compilar um arquivo específico: abra o terminal no diretório desse arquivo e digite make <nome_do_arquivo>

# Para limpar o seu diretório de executáveis gerados: abra o terminal no diretório desse arquivo e digite make clean





