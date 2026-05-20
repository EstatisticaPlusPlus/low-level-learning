---
title: "1. Introdução e Instalação"
---

# 1. Introdução e Instalação
## 1.1. Introdução

GNU Autotools é um conjunto de ferramentas do GNU que visam a padronização e
facilitamento da compilação de diversas linguagens para diferente arquiteturas
e sistemas operacionais.

Essa documentação está sendo criada a partir de uma máquina com Linux Mint 21

## 1.2. Instalação

O pacote do Autotools possivelmente está presente no seu gerenciador de pacotes
padrão do seu sistema.

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
