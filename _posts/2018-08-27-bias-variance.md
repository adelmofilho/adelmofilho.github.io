---
layout: post
title: Bias-Variance Tradeoff Simulation - 1
subtitle: A statistical war of tug
bigimg: /img/87L.gif
tags: [r, rstudio, bias, variance, statistics, machine-learning]
comments: true
draft: true
output: html_document
---

> Praticamente, todo livro de statistical / machine learning trata da apresentação do [dilema do bias-variância](https://en.wikipedia.org/wiki/Bias%E2%80%93variance_tradeoff) e utiliza sua inerente decomposição na discussão das técnicas de validação cruzada e sintonia de hiperparâmetros. 
> 
> Para além da fundamentação téorica, apresento neste post um framework básico para decomposição do bias, variância e do erro irredutível independente do modelo preditivo utilizado - Ao final chegaremos aos famosos gráficos de decomposição do bias-variance apresentados nos livros, mas que comumente não possuem explicação quanto sua construção.

$$E[]=\int_{-\infty}^\infty x f(x)dx$$
