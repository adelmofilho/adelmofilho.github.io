---
layout: post
draft: true
title: Crônicas 1
subtitle: R² negativo ?
bigimg: /img/path.jpg
comments: true
---

> Praticamente, todo livro de statistical / machine learning trata da apresentação do [dilema do bias-variância](https://en.wikipedia.org/wiki/Bias%E2%80%93variance_tradeoff) e utiliza sua inerente decomposição na discussão das técnicas de validação cruzada e sintonia de hiperparâmetros. 
> 
> Para além da fundamentação téorica, apresento neste post um framework básico para decomposição do bias, variância e do erro irredutível independente do modelo preditivo utilizado - Ao final chegaremos aos famosos gráficos de decomposição do bias-variance apresentados nos livros, mas que comumente não possuem explicação quanto sua construção.

$$R^2_{adj} = 1 - \frac{n-1}{n - (p+1)}\left ( 1 - R^2 \right )$$

xyw
