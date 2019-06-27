---
layout: post
title: "Montando sua infraestrutura de ciência de dados [parte 1]"
subtitle: "R + RStudio + Shiny + Git + Hadoop + Hive + Spark + Docker"
bigimg: /img/Jnrg.gif
tags: [r, rstudio, infra, hadoop, spark]
comments: true
draft: true
output:
  html_document:
    keep_md: true
---

É muita ousadia em um subtítulo só.

Então, vamos dividir em partes essa missão.

Este vai ser o primeiro post de uma série voltada para a infraestrutura de ciência de dados.

A ideia é apresentar as principais ferramentas de um pipeline moderno para análise de dados e como as instalar e configurar.

## Começando do zero

Nos cursos online, tutoriais, datacamps e afins, é comum desenvolvermos análises de dados em nossos próprios computadores. 

Infelizmente, seja ao lidar com grandes volumes de dados, na implementação de modelos, ou na criação de um [API](https://pt.wikipedia.org/wiki/Interface_de_programa%C3%A7%C3%A3o_de_aplica%C3%A7%C3%B5es), o desenvolvimento e disponibilização dos produtos criados não serão realizados em máquinas locais.

Quando se fala de infraestrutura (infra, pros íntimos), falamos de todo ferramental disponibilizado para o cientista de dados trabalhar. 

Isso inclui, um servidor (local ou na cloud), softwares para processamento e armazenamento dos dados, ferramentas para modelagem e visualização, segurança, versionamento e backup.

![](./img/infra.PNG)

