---
layout: post
title: "Criando um repositório git pra chamar de seu"
subtitle: "Raspberry + Gitlab"
bigimg: /img/docker.jpeg
tags: [r, rstudio, rstudio-server, data-science, docker, renv]
comments: true
draft: true
output:
  html_document:
    keep_md: true
---

Do cientista de dados até o desenvolvedor mobile, se existe uma tecnologia que conversa com todos nós, este é o `git`.

Versionar código não é somente sobre ter um backup (apesar de já ter salvo minha pele algumas vezes). 

Versionar torna mais fácil a colaboração em equipes e a resolução de bugs no código, além de tornar as mudanças no código vísiveis e documentadas (o santo commit explicativo).

Com serviços como `github` e `gitlab`, o uso do git associado a uma plataforma/interface web se popularizou até se tornar regra.

É comum empresas terem contratos com esses provedores, ou usarem infraestrutura própria para instanciar seu próprio servidor web para git.

Eu e você, mortais, consumimos essas plataformas utilizando a infraestrutura que elas nos fornecem de forma gratuita, ou paga quando necessário.

Mas...

> Apesar do tom conspiratório e alarmista das próximas palavras, elas estão aqui apenas para reflexão.

Mas, e se o serviço não for mais prestado? 

Ou, se seu código for utilizado de forma indevida ou não autorizada?

Ou ainda, a plataforma impedir seu acesso ao seu repositório git?

Parece uma teória conspiratória, mas já aconteceu recentemente, inclusive.

Foi o caso na Venezuela, quando [a Adobe removeu o acesso a usuários do photoshop aos seus projetos e ao software](https://www.fastcompany.com/90414653/adobe-shuts-down-photoshop-in-venezuela-because-of-trumps-sanctions) por conta de sanções dos EUA.

Não quero entrar no mérito da questão, até porque não li os termos de uso do software. O ponto aqui, é mesmo o que deve sempre ser lembrado ao trabalhar com serviços na cloud:

<p align="center"><img src="https://i.redd.it/f4f4tcoo8wu21.png"></img></p>




