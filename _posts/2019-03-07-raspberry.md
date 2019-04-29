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

Instalar R, Shiny/RStudio Server em meu [Raspberry Pi 3](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/) (a.k.a Verônica) tem sido aquele tipo de experiência ....

<img src="/img/rasp1.jpg" style="display: block; margin: auto;" />

Em 2018, foi a primeira fez que fiz todo o ecossistema funcionar, e, realmente, (pra mim) foi bem complicado pelo fato de:

1. O Shiny Server [não possui pré-compilados](https://www.rstudio.com/products/shiny/download-server/) para distribuições linux da arquitetura ARM (processor do Raspberry);

2. Haviam pouquissimos tutoriais na internet (isso não mudou muito) e todos com suas particularidades;

3. Eu era um completo NOOB em linux (isso não mudou muito);

4. O código-fonte do Shiny Server possuia "incompatibilidades" com o Raspberry Pi 3 - Isso tornava a instalação do servidor um trabalho de formiguinha, já que era necessário entender o que deveria ser alterado em cada script.

Esse último ponto me rendeu um [pull request](https://github.com/rstudio/shiny-server/pull/352) no github do [Shiny Server](https://github.com/rstudio/shiny-server) que me orgulho muito 😊 

## Chamado para Aventura

Certo dia [@pyspark2](https://twitter.com/pyspark2) aparece no zap com uma missão: Instalar o R 3.5 no Raspberry dele.  

<iframe src="https://giphy.com/embed/ly8G39g1ujpNm" width="480" height="278" frameBorder="0" class="giphy-embed" align="center" allowFullScreen></iframe>

<p align="center">Fiquei no mínimo nervoso</p>






<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}
});
</script>

<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
