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

## Versionamento de código

<blockquote>
<p align="right"><cite>"Só não gosto desse git add -A"</cite></p>

<p align="right"><cite>constante lucidez de @rpgmbicalho</cite></p>
<blockquote>