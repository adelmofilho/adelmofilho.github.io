---
layout: post
title: Instalando um servidor Shiny-R em seu Raspberry Pi 3
subtitle: Ai ele falou "Então é possível?"
bigimg: /img/rasp_header.jpg
tags: [r, rstudio, packages, devtools, usethis]
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






<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}
});
</script>

<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
