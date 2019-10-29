---
layout: post
title: "Montando sua esteira de CICD do zero e outros contos de MLOps"
subtitle: "A kaggle horror story"
bigimg: /img/esteira.gif
tags: [CICD, CI, CD, MLOps, kaggle, esteira, pipeline, gitlab, docker, aws, s3, lambda, terraform]
comments: true
draft: true
output:
  html_document:
    keep_md: true
---

Nas últimas semanas, minhas discussões se tornaram uma nuvem de buzzwords: MLOps, CICD, pipeline, kubernets, cloud, cloud, cloud.

A verdade é que estamos observando uma mudança de mentalidade importante no que entendemos como machine learning (ML).

Após todo aquele grande buzz em torno de inteligência artifical, ML e automatização de processos, estamos caindo na real que precisamos entregar todas essas promessas.

Mas, não me entenda mal.

Quando falo sobre entregar, quero dizer de forma profissional, eficiente e adequada para os desafios que a disciplina de ciência de dados exige.

Já observamos isso acontecendo nas squads tradicionais de [DevOps](https://en.wikipedia.org/wiki/DevOps#History). O desenvolvimento de software garantido integração e entrega continua (CICD) já é uma cultura, com ferramentas e mais de 10 anos de experiência.

E a pergunta que nos resta é: `como pensar um MLOps, combinando os desafios do machine learning com as boas práticas de CICD que já existem?`

<iframe src="https://giphy.com/embed/AvAVxpOeUcxgY" width="480" height="222" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/question-AvAVxpOeUcxgY"></a></p>

Eu também não sei!

A boa noticia é que estamos todos tentando descobrir

<script type="text/javascript" src="https://ssl.gstatic.com/trends_nrtr/1982_RC01/embed_loader.js"></script> <script type="text/javascript"> trends.embed.renderExploreWidget("TIMESERIES", {"comparisonItem":[{"keyword":"MLOps","geo":"","time":"today 5-y"}],"category":0,"property":""}, {"exploreQuery":"date=today%205-y&q=MLOps","guestPath":"https://trends.google.com:443/trends/embed/"}); </script>



