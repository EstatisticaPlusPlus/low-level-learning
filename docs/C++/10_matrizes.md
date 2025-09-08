# Matrizes

Arrays multidimensionais.

## Matrizes

Matrizes são arrays multidimensionais, isto é, arrays de arrays, arrays de arrays de arrays, e por aí em diante.

## Declaração

Para declarar uma matriz, chaves quadradas são utilizadas para indicar o tamanho de cada dimensão. Apenas o tamanho da primeira dimensão pode ser omitido, em caso de inicialização.

```cpp
int arr[5][3]; //Matriz 5x3
```

```cpp
int arr[][2] = {{1,2},{3,4}}; //Matriz 2x2
```

```cpp
int arr[5][3][3]; //Matriz 5x3x3
```

Assim como em arrays, se nenhum elemento for inicializado, todos serão lixo, mas caso algum seja inicializado, todos os não inicializados terão o valor nulo do seu tipo.

## Acesso

Assim como em arrays, índices entre chaves quadradas acessam posições na matriz. Além disso, também é conveniente acessar as posições com loops.

```cpp
int arr[3][3] =
{
	{1,2,3}
	{4,5,6}
	{7,8,9}
}

for(int i = 0; i < 3; i++) {
	for(int j = 0; j < 3; j++) {
		cout << arr[i][j] << ' ';
	}
	cout << '\n';
}
// 1 2 3
// 4 5 6
// 7 8 9
```

## `size()`

Pode-se obter o tamanho de cada dimensão da matriz com a função `size()`, assim como em arrays. Basta acessar os arrays internos e obter seus tamanhos.

```cpp
int arr[10][9][2];
cout << size(arr) << '\n'; // 10
cout << size(arr[0]) << '\n'; // 9
cout << size(arr[0][0]) << '\n'; // 2
```