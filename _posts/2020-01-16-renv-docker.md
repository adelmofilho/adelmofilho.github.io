---
layout: post
title: "R em Produção"
subtitle: "Parte 1 - "
bigimg: /img/docker.jpeg
tags: [r, rstudio, rstudio-server, data-science, docker, renv]
comments: true
draft: true
output:
  html_document:
    keep_md: true
---

> Este é o primeiro post de uma série. Diferente de um tutorial, minha ideia é expor alguns pensamentos e pipelines que venho desenvolvendo para pôr em produção projetos que desenvolvo em R.

"R em produção".

Já foram tantos os sentimentos que presenciei de alguém ouvindo essas três palavras...

Até hoje, minha opnião nunca mudou: R em produção, está mais relacionado à cultura da organização do que à barreiras técnicas.

O entendimento do que significa pôr algo em produção (deploy), por outro lado, não parou de crescer e mutacionar.

Parnasianismos a parte, neste primeiro post quero explorar a ideia de como desenvolver ciência de dados com R pensando no deploy mais a frente.

Vamos lá!

## Sumário



- O que significa "pôr em produção"?

- Como desenvolver pensando em produção?

  - Versionamento de código (git)
  - Versionamento de dados e experimentos (dvc)
  - Code as a package (usethis)
  - Documentação continua (roxygen2)
  - Containerização (docker)
  - Controle de dependências (renv)
  - Testes unitários (testthat, codecovr)
  - Formatação de código (rlint)

<br>

## O que significa "pôr em produção"?

## Versionamento de código

<p style="margin:0px;text-align:right"><b><cite>Só não gosto desse git add -A</cite></b></p>
<p style="margin:0px;text-align:right"><cite>constante lucidez de @rpgmbicalho</cite></p>

<br>

## Versionamento de dados e experimentos

<p style="margin:0px;text-align:right"><b><cite>Se for verdade é gol</cite></b></p>
<p style="margin:0px;text-align:right"><cite>@Lzda sobre o dvc</cite></p>

<br>

## Code as a Package

<p style="margin:0px;text-align:right"><b><cite>Polimorfismo em ciência de dados é usar o notebook do colega com outro banco de dados</cite></b></p>
<p style="margin:0px;text-align:right"><cite>by @thiagorizuti</cite></p>



<br>

## Documentação contínua

<p style="margin:0px;text-align:right"><b><cite>Podiamos ter um continuous documentation, heim?</cite></b></p>
<p style="margin:0px;text-align:right"><cite>@thalsin e sua arquitetura alvo</cite></p>

<br>

## Containerização

<p style="margin:0px;text-align:right"><b><cite>(...) estou apaixonado por docker</cite></b></p>
<p style="margin:0px;text-align:right"><cite>@boreloide #gratiluz</cite></p>

<br>

## Controle de dependências
<p style="margin:0px;text-align:right"><b><cite>Não aguento instalar mais dependências</cite></b></p>
<p style="margin:0px;text-align:right"><cite>@pyspark2 e seu raspberry pi2 com R</cite></p>


<br>

## Testes unitários

<p style="margin:0px;text-align:right"><b><cite>Vou começar a criar testes unitários e tal, e chamarei isso de defesa contra as artes dos cientistas de dados</cite></b></p>
<p style="margin:0px;text-align:right"><cite>@AdelmoFIlho42 brigando com a API do kaggle</cite></p>

<br>

## Formatação de código

<p style="margin:0px;text-align:right"><b><cite>Você curte os espaços entre linhas? Hahah </cite></b></p>
<p style="margin:0px;text-align:right"><cite>@dges julgando meus códigos</cite></p>

<br>

## Considerações finais (?)