---
layout: post
title: "Voando nas nuvens"
subtitle: "Acelerando seus estudos com IaaC"
bigimg: /img/iaac.jpeg
tags: [cloud, terraform, iaac, ansible, digital-ocean]
comments: true
draft: true
output:
  html_document:
    keep_md: true
---

Was a long and dark December... Anos atrás...

Acessei meu servidor, e quando fui conferir o status de um banco de dados me deparei com a mensagem:

> Send us 0.5 BTC to recover your database

Por pior que tenha sido ser hackeado, no futuro isso me faria estudar mais sobre segurança e a comprar bitcoins (isso não foi tão bom).

Naquela época, apesar do susto, estava tranquilo, pois tinha comigo meu bloco de notas com os comandos pra recuperar o servidor do zero.

Um bloco de notas com os comandos pra recuperar o servidor do zero...

Um bloco de notas...

<center>
<img src="/img/pocoyo.jpg" height=220 style="display: block; margin: auto">
</center>

<p align="center">O importante é a gente ir evoluindo, né?</p>

Não nego que nesses anos até foi divertido subir na unha um cluster spark, mapear cada porta do hadoop, resolver os bugs de colocar um servidor R-shiny num raspberry. 

Mas ter que refazer todo o processo duas, três vezes por ter bloqueado meu próprio ip, já era demais.

Por isso, todo o jogo virou quando conheci as ferramentas de Infra as a Code (IaaC).

## Tl;dr

O projeto `Dirty Deeds Done Dirt Cheap` disponibiliza um conjunto de scripts em `terraform` e `ansible` para criação de instâncias na cloud da Digital Ocean.

A ideia é reduzir o desgaste gerado na configuração dessas máquinas, já disponibilizando ferramentas de segurança e ambiente para prototipagem com docker.

Todas as instruções para operacionalização do projeto estão em seu `README`. 

<center>
<blockquote class="twitter-tweet" data-theme="light"><p lang="pt" dir="ltr">Primeiro projetinho de 2020! <a href="https://twitter.com/hashtag/jojoprojects?src=hash&amp;ref_src=twsrc%5Etfw">#jojoprojects</a> <a href="https://twitter.com/hashtag/IaaC?src=hash&amp;ref_src=twsrc%5Etfw">#IaaC</a> <a href="https://twitter.com/hashtag/d4c?src=hash&amp;ref_src=twsrc%5Etfw">#d4c</a><a href="https://t.co/ycd09MFi1x">https://t.co/ycd09MFi1x</a></p>&mdash; Adelmo Filho (@AdelmoFilho42) <a href="https://twitter.com/AdelmoFilho42/status/1216443720544944136?ref_src=twsrc%5Etfw">January 12, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 
</center>

<br>

## Infrastructure as a Code

<br>