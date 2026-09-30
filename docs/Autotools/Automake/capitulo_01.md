---
title: "1. Introdução"
---

# 1. Introdução e instalação

# 1.1. Introdução

Automake é uma ferramenta que ajuda a gerar `makefile`s
automaticamente a partir de arquivos `Makefile.am`.

# 1.2. Instalação

Seguindo do Autoconf, é provável que o Automake já esteja no
seu sistema, porém, caso esteja interessando apenas no
Automake, o pacote provavelmente já está no gerenciador de
pacotes padrão do seu sistema.

### Debian / Ubuntu / Linux Mint

```bash
$ sudo apt update
$ sudo apt install autoconf automake m4
```

### Red Hat / CentOS / Fedora

```bash
$ sudo dnf install autoconf automake m4

# Ou
$ sudo yum install autoconf automake m4
```

### Arch Linux / Manjaro

```bash
$ sudo pacman -S autoconf automake m4
```

### openSUSE

```bash
$ sudo zypper install autoconf automake m4
```

### Alpine Linux

```bash
$ sudo apk add autoconf automake m4
```

### Gentoo

```bash
$ sudo emerge -av sys-devel/autoconf sys-devel/automake sys-devel/sys-devel/m4
```

### Verifique a Instalação

```bash
autoconf --version
automake --version
```

Estes comandos baixarão e instalarão todas as ferramentas necessárias para
acompanhar essa documentação
