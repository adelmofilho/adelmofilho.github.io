---
layout: post
title: "Reticulando Python no RStudio [parte 1]"
subtitle: "@alceufc que me perdoe"
bigimg: /img/rpy.jpg
tags: [r, rstudio, packages, reticulate, python]
comments: true
draft: true
output:
  html_document:
    keep_md: true
---

## Instalando Python em sua máquina

A instalação do Python em máquinas Windows pode ser realizada via [Python Fundation](https://www.python.org/downloads/) ou [Ananconda](https://www.anaconda.com/distribution/). A última é preferível, pois permite o uso de virtual environments no Windows (discutiremos com mais detalhes virtual environments nesse post).

<br>

---

**UPDATE 18/05/2019**

Vem sendo observado erros recorrentes na instalação do Python via Anaconda [em razão de não ser instalado o arquivo `conda.exe`](https://github.com/ContinuumIO/anaconda-issues/issues/8460). O workaround encontrado para este problema está na instalação do python via [Miniconda](https://docs.conda.io/en/latest/miniconda.html).

A diferença do Anaconda para o Miniconda estão nos pacotes que vem instalados por padrão.

---


<br>

Para usuários Linux, é possível instalar o python por ambas opções sem perdas. 

O `conda` é tanto um gerenciador de pacotes, quanto gerenciador de virtual environments. Instruções para instalação do conda pode ser encontradas [no tutorial do digitalocean](https://www.digitalocean.com/community/tutorials/how-to-install-anaconda-on-ubuntu-18-04-quickstart)

Seu equivalente é o `pip`, mas assume apenas o papel de gerenciador de pacotes. Para criar virtual environments em combinação com o `pip` é necessário instalar o pacote python-virtualenv. Para tanto entramos com os seguintes comandos no terminal.

```
sudo apt-get install -y libpython-dev
sudo apt-get install -y libpython3-dev

sudo apt install python3-pip
sudo apt install python-pip

sudo apt-get install python-virtualenv
```

Neste post se espera a instalação da versões Python 2 e Python 3.


## Instalando o reticulate

Dentro do RStudio, instalamos e carregamos o pacote `reticulate` conforme comandos a seguir.


```r
#install.packages('reticulate')
```

A reticulação do python dentro do RStudio pode ser feita via terminal ou através dos chunks do `R Notebook` e `RMarkdown`.


## Reticulando em notebooks

Abra um novo arquivo (Rmarkdown ou R Notebook) e crie um novo chunk R.


```r
library(reticulate)
```

```
## Warning: package 'reticulate' was built under R version 3.5.3
```

Em seguida, vamos localizar as versões do python instaladas em sua máquina através do comando `py_discovery_config`.


```r
py_discover_config()
```

```
## python:         C:\PROGRA~3\Miniconda3\python.exe
## libpython:      C:/PROGRA~3/Miniconda3/python37.dll
## pythonhome:     C:\PROGRA~3\Miniconda3
## version:        3.7.3 (default, Mar 27 2019, 17:13:21) [MSC v.1915 64 bit (AMD64)]
## Architecture:   64bit
## numpy:           [NOT FOUND]
## 
## python versions found: 
##  C:\PROGRA~3\Miniconda3\python.exe
##  C:\PROGRA~3\Miniconda2\python.exe
##  C:\ProgramData\Miniconda2\python.exe
```

Pelo output acima, vemos que temos uma versão do python 3 e duas do python 2 instaladas em minha máquina e que a versão python 3 foi reticulada automáticamente pelo RStudio.

Neste momento, já podemos trabalhar com o python reticulado. Contudo, está não é uma boa prática. Ao trabalhar com um mesmo ambiente python em diferentes projetos corremos o risco de atualizar pacotes para versões sem compatibilidade com códigos antigos ou mesmo instalar pacotes que gerem conflitos com outros já instalados.

Para tanto, se faz necessário criar um ambiente separado daquele compartilhado pelo python reticulado - um virtual environment (v-env).

Caso esteja utilizando o `conda` para gerenciar seus pacotes e v-env, criamos um novo v-env pelo comando `conda_create`. No exemplo abaixo, vamos criar dois v-env, cada um com uma versão diferente do python.

Ajuste o path das versões distribuidas pelo conda conforme foi realizada a instalação em sua máquina.


```r
conda_create(envname = "r-py3", 
             conda = "C:/ProgramData/Miniconda3/Scripts/conda.exe",
             packages = c("pandas"))
```

```
## [1] "C:\\Users\\Adelmo Filho\\Documents\\.conda\\envs\\r-py3\\python.exe"
```



```r
conda_create(envname = "r-py2", 
             conda = "C:/ProgramData/Miniconda2/Scripts/conda.exe")
```

```
## [1] "C:\\Users\\Adelmo Filho\\Documents\\.conda\\envs\\r-py2\\python.exe"
```

Caso não esteja usando o `conda`, a criação da virtual env pode ser realizada de forma equivalente utilizando a função `virtualenv_create` com o argumento `conda` da função `conda_create` substituido pelo argumento `python`, o qual deve apontar para o executável do path do executável do python.

## Removendo virtual envs

> Parte da jornada é o fim (Stark, 2019)

A descontinuidade do python 2 está marcada para janeiro de 2020. De certo da importância do fato, o uso do python 3 é preferível. Vamos, então, remover a virtual env criada com o python 2.

Para enxergar todas as virtual envs criadas podemos utilizar a função `conda_list`


```r
conda_list()
```

```
##         name
## 1 Miniconda3
## 2      r-py2
## 3      r-py3
##                                                                python
## 1                             C:\\ProgramData\\Miniconda3\\python.exe
## 2 C:\\Users\\Adelmo Filho\\Documents\\.conda\\envs\\r-py2\\python.exe
## 3 C:\\Users\\Adelmo Filho\\Documents\\.conda\\envs\\r-py3\\python.exe
```

E removemos a virtual-env `r-py2` pela função `conda_remove`.


```r
conda_remove("r-py2")
```

Caso não esteja usando o `conda`, a remoção de v-envs é realizada pelo comando `virtualenv_remove`.

## Populando nosso virtual environment

Uma vez que nossa env está criada, por padrão, ela não possui os principais pacotes de manipulação de dados e modelagem, típicos de nossas análises.

Através da função `py_config` verificamos (output abaixo) que a versão reticulada do python é da nossa env `r-py3`. Caso fosse necessário trocar de env, bastaria utilizar o comando `conda_python` ou seu equivalente `virtualenv_python` (na ausência do `conda`) e informar no argumento `envname` o nome da env desejada.


```r
py_config()
```

```
## python:         C:\Users\Adelmo Filho\Documents\.conda\envs\r-py3\python.exe
## libpython:      C:/Users/Adelmo Filho/Documents/.conda/envs/r-py3/python37.dll
## pythonhome:     C:\Users\ADELMO~1\DOCUME~1\.conda\envs\r-py3
## version:        3.7.3 (default, Apr 24 2019, 15:29:51) [MSC v.1915 64 bit (AMD64)]
## Architecture:   64bit
## numpy:          C:\Users\ADELMO~1\DOCUME~1\.conda\envs\r-py3\lib\site-packages\numpy
## numpy_version:  1.16.3
## 
## python versions found: 
##  C:\PROGRA~3\Miniconda3\python.exe
##  C:\PROGRA~3\Miniconda2\python.exe
##  C:\ProgramData\Miniconda2\python.exe
##  C:\Users\Adelmo Filho\Documents\.conda\envs\r-py3\python.exe
```

A instalação de pacotes em uma env é realizada pelo comando `conda_install` ou, equivalentemente, `virtualenv_install`. No nosso exemplo abaixo, vamos instalar os pacotes `pandas`e `scikit-learn`


```r
conda_install(envname = "r-py3", 
              packages = c("scikit-learn"))
```

## Nosso primeiro chunk python

Crie um novo chunk python em seu R Notebook / Rmarkdown. Dentro dele, é possível escrever com a mesmo sintaxe e pacotes do python.


```python
import pandas as pd
import numpy  as np
from random import random

print("hello world")  # O que você esperava de um primeiro código em python?
```

```
## hello world
```

## Escrevendo em python via console

Outra ferramenta útil do pacote `reticulate` está em trocar o kernel do RStudio, tornando-o uma IDE para python. Para isto, entramos com o comando `reticulate::repl_python()` diretamente no console do RStudio. REPL vem da sigla [read–eval–print loop](https://en.m.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop) e basicamente implica que estaremos trabalhando em um python shell.


```r
#reticulate::repl_python()
```

```
## Python 3.7.3 (C:\Users\Adelmo Filho\Documents\.conda\envs\r-py3\python.exe)
## Reticulate 1.12 REPL -- A Python interpreter in R.
```

Uma mensagem de aviso aparecerá informando a versão / env do python que será utilizada pelo Rstudio a partir deste momento. Caso se deseja retornar ao R, basta sair do shell com o comando `exit()`.

## Próximos passos

Neste primeiro post, conectamos o python através do pacote `reticulate` e verificamos as possibilildades de uso da IDE do RStudio com o python como kernel. 

O pacote `reticulate` trabalha além disso, permitindo interações entre objetos criados no R ou no Python. Abordaremos esse tópico na parte 2 desse post. 



Vejo vocês lá!


<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}
});
</script>

<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
