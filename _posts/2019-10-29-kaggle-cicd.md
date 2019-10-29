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

<div style="width:100%;height:0;padding-bottom:46%;position:relative;"><iframe src="https://giphy.com/embed/AvAVxpOeUcxgY" width="100%" height="100%" style="position:absolute" frameBorder="0" class="giphy-embed" allowFullScreen></iframe></div><p><a href="https://giphy.com/gifs/question-AvAVxpOeUcxgY">via GIPHY</a></p>

Eu também não sei!

A boa noticia é que estamos todos tentando descobrir.

<script type="text/javascript" src="https://ssl.gstatic.com/trends_nrtr/1982_RC01/embed_loader.js"></script> <script type="text/javascript"> trends.embed.renderExploreWidget("TIMESERIES", {"comparisonItem":[{"keyword":"MLOps","geo":"","time":"today 5-y"}],"category":0,"property":""}, {"exploreQuery":"date=today%205-y&q=MLOps","guestPath":"https://trends.google.com:443/trends/embed/"}); </script>

Do último ano prá cá, vimos como esse pensamento se estruturou na forma de diversos textos procurando pensar sobre o tema. Entre os meus favoritos estão:

- [Continuous Delivery for Machine Learning](https://martinfowler.com/articles/cd4ml.html)

- [Continuous Delivery for ML Models](https://medium.com/onfido-tech/continuous-delivery-for-ml-models-c1f9283aa971)

- [Deploy your machine learning pipelines](https://medium.com/@igorzabukovec/deploy-your-machine-learning-pipelines-28007b985202)

- [Itaú Unibanco: How we built a CI/CD Pipeline for machine learning with online training in Kubeflow](https://cloud.google.com/blog/products/ai-machine-learning/itau-unibanco-how-we-built-a-cicd-pipeline-for-machine-learning-with-online-training-in-kubeflow)

Foi nesse cenário que junto com [@thalsin](https://www.linkedin.com/in/thales-lima-391372155) e [@eduardovelludo
](https://www.linkedin.com/in/eduardo-prado-a775a5137/), decidimos tornar uma competição no [@Kaggle](https://twitter.com/kaggle) um simulacro do que esperariamos num cenário ideal de MLOps. 

Os eventos a seguir datam de 1 semana.

<div style="width:100%;height:0;padding-bottom:57%;position:relative;"><iframe src="https://giphy.com/embed/j9djzcMmzg8ow" width="100%" height="100%" style="position:absolute" frameBorder="0" class="giphy-embed" allowFullScreen></iframe></div><p><a href="https://giphy.com/gifs/korea-north-headlines-j9djzcMmzg8ow"></a></p>
